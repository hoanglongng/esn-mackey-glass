% This file generates Mackey-Glass data from random seed with a given tau
% value. The generated data will be used for training purpose.
% The data is chaotic if tau > 16.8. Typical values are:
% tau = 17 -> mildly chaotic
% tau = 30 -> wildly chaotic

%% Parameter definition
% Length of generated data. First part with washoutLength will be wasted.
dataLength = 1e4;
washoutLength = 1e3;

% Data sequence initialization
dataSeq = zeros(dataLength,1);

% Parameters definition
tau = 17;
stepSize = 1/10;
historyLength = tau / stepSize;
seed = 1.2 * ones(historyLength,1) + 0.2 * (rand(historyLength,1) - 0.5);
oldVal = 1.2;
generatedSet = seed;
count = 0;

%% Data generation
for i = 1 : dataLength + washoutLength
    % Formula is given in the paper
    for j = 1 : (1 / stepSize)
        count = count + 1;
        tauVal = generatedSet(mod(count,historyLength) + 1,1);
        newVal = oldVal + stepSize * (0.2 * tauVal/(1.0 + tauVal^10) - 0.1 * oldVal);
        generatedSet(mod(count,historyLength) + 1,1) = oldVal;
        oldVal = newVal;
    end
    
    % Consider only data after washoutLength
    if i > washoutLength
        dataSeq(i - washoutLength,1) = newVal; 
    end
end

%% Data transformation
% The data is then shifted and squashed into a range of [-1,1] by using the
% transformation y = tanh(y - 1).
trainSeq = dataSeq(1:dataLength,1) - 1.0;
trainSeq = tanh(trainSeq);