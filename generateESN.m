% This file generates an ESN. It is a RNN where internal units are sparsely
% connected to each other with random fixed weights. Input weight matrix 
% and output weight matrix are also randomly defined. Only output weight 
% matrix is trainable.

%% Parameter definition
% No. of internal units in the reservoir
internalLength = 1000;

% Network connectivity
connectivity = 0.01;

% No. of input neurons and output neurons
inputLength = 1;                            
outputLength = 1;

% Total dimension of the entire network
totalDim = internalLength + inputLength + outputLength;

% Spectral radius
spectralRadius = 0.8;

%% Internal weight matrix
% Internal weight matrix sparsely definition in range of [-0.5,0.5]
intWM = sprand(internalLength, internalLength, connectivity);   
intWM = spfun(@minusPoint5,intWM);                                          

% Finding an eigenvalue of W with the largest absolute value
maxval = max(abs(eigs(intWM,1)));      
intWM = intWM / maxval;

% Rescaling internal weight matrix with spectral radius
intWM = intWM * spectralRadius;

%% Input weight matrix
% Input weight matrix with random definition in range of [-1,1]
inWM = 2.0 * rand(internalLength, inputLength)- 1.0;

%% Output feedback weight matrix
% Output feedback weight matrix with random definition in range of [-1,1];
ofbWM = (2.0 * rand(internalLength, outputLength)- 1.0);

%% Output weight matrix
% Output weight matrix initialization. It is trainable.
% Direct input-to-output connection is also considered
initialOutWM = zeros(outputLength, internalLength + inputLength);