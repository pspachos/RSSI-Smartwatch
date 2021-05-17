function acc = benchmark_Accuracy(groundtruthLabel, estLabel)
    acc = sum(estLabel == groundtruthLabel) / length(groundtruthLabel);
end