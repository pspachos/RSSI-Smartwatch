
function [p, r, f1] = benchmarkF1(true, pred)

    precision = @(confusionMat) confusionMat(1)./sum(confusionMat,2);
    recall = @(confusionMat) confusionMat(1)./sum(confusionMat,1);
    f1Scores = @(confusionMat) 2*(precision(confusionMat).*recall(confusionMat))./(precision(confusionMat)+recall(confusionMat));
    
    confusionMat = confusionmat(true, pred);
    p = precision(confusionMat); %mean(precision(confusionMat));
    p = p(1);
    if (isnan(p)) p = 1; end
    
    r = recall(confusionMat); %mean(recall(confusionMat));
    r = r(1);
    if (isnan(r)) r = 1; end
    
    f1 = 2*(p.*r)./(p+r);

end