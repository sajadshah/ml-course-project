function [ precision,recall,confm, accuracy, fmeasure] = evaluateModel( model,modelType, testLabels, testData,no_classes)
%EVALUATEMODEL this function evaluate model according to test data provided
%by input of the function. specifying tp,tn,fp,fn, precision and recall per
%each class and providing confusion matrix and overall accuracy and
%fmeasure.
%   inputs:
%         model: a classifier model
%         model type: a string 'svm' or 'knn'
%         testData, testLabels: data for testing the classifier
%         no_classes: number of differnet class in testLabels.
%         
%         
%         
%         
no_testData = size(testData,1);
tp = zeros(no_classes,1);
tn = zeros(no_classes,1);
fp = zeros(no_classes,1);
fn = zeros(no_classes,1);
precision = zeros(no_classes,1);
recall = zeros(no_classes,1);
fmeasure = zeros(no_classes,1);
confm = zeros(no_classes,no_classes);
pl = zeros(size(testData,1),1);
    switch modelType
        case 'svm'
            [pl,~,~]=svmpredict(rand(no_testData,1),testData,model);    
        case 'knn'
            
            [pl,~,~] = predict(model,testData);
            
    end
    for i=1:no_testData
        trueLabel = testLabels(i);
        predictedLabel = pl(i);
        confm(trueLabel,predictedLabel)=confm(trueLabel,predictedLabel)+1;
    end

    for i=1:no_classes
        tp(i) = confm(i,i);
        fp(i) = sum(confm(:,i))-confm(i,i);
        fn(i) = sum(confm(i,:))-confm(i,i);
        tn(i) = sum(sum(confm))-(tp(i)+fp(i)+fn(i));
        precision(i) = (tp(i))/(tp(i)+fp(i));
        recall(i) = (tp(i))/(tp(i)+fn(i));
        fmeasure(i) = (2*precision(i)*recall(i))/(precision(i)+recall(i));

    end

    for i=1:no_classes
        confm(i,:)=confm(i,:)/sum(confm(i,:));
    end

    accuracy = mean(diag(confm));
    fmeasure = mean(fmeasure);    


end

