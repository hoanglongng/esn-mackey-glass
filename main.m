% This main file gathers needed files in simulation of MG-17 attractor

clear;

%% Generate training data
generateMGData;

%% Generate echo state network (ESN)
generateESN;

%% Training model
networkTraining;

%% Generate testing data
generateMGTestData;

%% Computing NRMSE
networkTesting;

%% Plotting free running continuation
freeRunningPlot;  