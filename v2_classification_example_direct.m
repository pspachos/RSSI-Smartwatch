%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this script provides a simple demonstration on how to 
% 1. read the data,
% 2. train a classifier
% 3. evaluate the classifier with the testing dataset
% with smartwatch-based RSS data for contact tracing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
addpath('helper-functions');

% 1. read the data
fprintf('\n1. Reading the training and testing data ... \n')
fprintf('=========================================\n');

trainingData = readtable('v2_ptrainingData_direct.csv');
testingData = readtable('v2_ptestingData_direct.csv');

n = height(trainingData);
m = height(testingData);
fprintf('Size of training data: %d \n', n)
fprintf('Size of testing data: %d \n', m)

% use the value from column 5 and 16 to 20 as input feature
% Note:
% for v2, we also provided the raw data to help those who wish to explore
% other features.
xTrain = trainingData(:, [5,16:20]);
xTest = testingData(:, [5,16:20]);

% use the risk as the output, refer to the paper on how the risk is defined
yTrain = trainingData.risk;
yTest = testingData.risk;


% 2. define a classification model and train the model
% Decision tree: "fitctree(xTrain, yTrain)";
% LDA: "fitcdiscr(xTrain, yTrain,'discrimType','pseudoLinear')";
% Naive Bayes: "fitcnb(xTrain, yTrain, 'DistributionNames','kernel', 'Kernel','box')";
% kNN: "fitcknn(xTrain, yTrain,'NSMethod','exhaustive','Distance','cosine','NumNeighbors',4)";
fprintf('\n2. Train a classification model ... \n')
fprintf('=========================================\n');

cvtrainAccuracy = [];
model = {};
for k = 1:10
    shuffleInd = randperm(n);
    model{k} = fitctree(xTrain(shuffleInd, :), yTrain(shuffleInd));
    trainError = resubLoss(model{k});
    trainAccuracy = 1 - trainError;

    % 10-fold cross validation
    cvModel = crossval(model{k});
    cvtrainError = kfoldLoss(cvModel);
    cvtrainAccuracy(k,1) = 1-cvtrainError;
end
[v, k] = max(cvtrainAccuracy);
disp(model{k})

% 3. evaluate the classifier
yPred = predict(model{k},xTest);


accT = benchmark_Accuracy(yTest, yPred);
[pT, rT, f1T] = benchmarkF1(yTest, yPred);


% output the result
fprintf('\n3. Evaluate the Classifier:\n')
fprintf('=========================================\n');
fprintf('Accuracy   Precision   Recall   F1-score\n', accT);
fprintf('=========================================\n');
fprintf(' %.4f     %.4f    %.4f     %.4f \n', accT, pT, rT, f1T);



%% save the best model
save('models/v2_dtModel_direct.mat', 'model');


