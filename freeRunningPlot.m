% This file plots an overlay of a 2000 step free running continuation of
% the trained network in networkTraining.m with the continuation of the
% original MG data generated from generatedMGTestData.m

%% Data preparation
% Testing data extraction
sampleOut = testSeq';

% Data splitting
initialRunlength = 1500;
plotRunlength = 2000;

%% Matrices initialization
totalstate =  zeros(totalDim,1);    
internalState = totalstate(1:internalLength);
teacherPL = zeros(outputLength, plotRunlength);
netOutPL = zeros(outputLength, plotRunlength);
plotindex = 0;

%% Scanning through testing sequence
for i = 1:initialRunlength +  plotRunlength 
    % Teacher extraction
    teach = sampleOut(1,i);  

    % Input update
    in = 0.02;
    totalstate(internalLength+1:internalLength+inputLength) = in; 

    % Internal state update
    internalState = tanh([intWM, inWM, ofbWM]*totalstate);  

    % Output update
    netOut = tanh(outWM *[internalState;in]);
    totalstate = [internalState;in;netOut];    
    
    % Force teacher output
    if i <= initialRunlength 
        totalstate(internalLength+inputLength+1:internalLength+inputLength+outputLength) = teach' ; 
    end
    
    % Collecting data for plotting
    if i > initialRunlength 
        plotindex = plotindex + 1;
        teacherPL(:,plotindex) = teach; 
        netOutPL(:,plotindex) = netOut;     
    end
end

% Plot network output and teacher
figure(3);
plot(1:plotRunlength,teacherPL(1,:),'r',1:plotRunlength,netOutPL(1,:),'b');
legend('Teacher','Output prediction');