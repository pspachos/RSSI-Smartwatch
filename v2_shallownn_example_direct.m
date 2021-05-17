%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this script demonstrates feedforward neural network
% with smartwatch-based RSS data for contact tracing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
addpath('helper-functions');

% 1. read the data
fprintf('\n1. Reading the training and testing data from direct dataset... \n')
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
xTrain = xTrain{:,:};
xTest = testingData(:, [5,16:20]);
xTest = xTest{:,:};

% use the risk as the output, refer to the paper on how the risk is defined
yTrain = trainingData.risk;
yTest = testingData.risk;


% 2. define a 4 layers Neural Network
fprintf('\n2. Train a feedforward neural network ... \n')
fprintf('=========================================\n');
net = feedforwardnet([8 16 24 32]);
net.layers{end}.transferFcn = 'tansig';

% 10-fold cross-validation:
foldNum = 10;
foldSize = floor(n/foldNum);
foldMat = ones(foldSize, foldNum);

cvtrainAccuracy = [];
model = {};
for k = 1:10
   mask = foldMat;
   mask(:, k) = zeros(foldSize, 1);
   mask = mask(:);
   mask = logical([mask; mask(end-1:end)]);
   
   x = xTrain(mask, :);
   y = yTrain(mask, :);
   
   xVal = xTrain(~mask, :);
   yVal = yTrain(~mask, :);
   
   model{k} = train(net,x',y','CheckpointFile', 'checkpoints/direct_Checkpoint_'+string(k),'CheckpointDelay',120);
   
   yPredProb = model{k}(xVal');
   yPred = zeros(length(yPredProb),1);
   yPred(yPredProb > 0.5) = 1;


   cvtrainAccuracy(k,1) = benchmark_Accuracy(yVal, yPred);
end
view(net)



% 3. evaluate the classifier
[v, k] = max(cvtrainAccuracy);
disp(model{k})

yPredProb = model{k}(xTest');
yPred = zeros(length(yPredProb),1);
yPred(yPredProb > 0.5) = 1;


accT = benchmark_Accuracy(yTest, yPred);
[pT, rT, f1T] = benchmarkF1(yTest, yPred);


% output the result
fprintf('\n3. Evaluate the Classifier:\n')
fprintf('=========================================\n');
fprintf('Accuracy   Precision   Recall   F1-score\n', accT);
fprintf('=========================================\n');
fprintf(' %.4f     %.4f    %.4f     %.4f \n', accT, pT, rT, f1T);



%% save the best model
save('models/v2_shallowNN_direct.mat', 'model');


% weight and bias values:
% IW: {8x6 cell} containing input weight matrix
% LW: {5x5 cell} containing layer weight matrix
% b: {5x1 cell} containing bias vectors






