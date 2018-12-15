clear;

%%loading data either from original files or from saved previous feature extraction
%loadImagesAndExtractFeatures();
%load('data.mat');

%%k fold cross validation for tuning parameters gamma and C for svm classifier

no_data = size(data,1);
k = 4;
foldSize = floor(no_data/k);
bounds = [1:foldSize:no_data, no_data+1];

accuracyOverFolds = zeros(k,1);
fmeasureOverFolds = zeros(k,1);
for i=1:k
    b = bounds(i);
    e = bounds(i+1);
    if i==1
        trainLabels = labels(e:end,:);
        trainData = data(e:end,:);
        testLabels = labels(1:e-1,:);
        testData = data(1:e-1,:);
    elseif i==k
		trainLabels = labels(1:b-1,:);
        trainData = data(1:b-1,:);
        testLabels = labels(b:end,:);
        testData = data(b:end,:);
    else
        trainLabels = [labels(1:b-1,:);labels(e:end,:)];
        trainData = [data(1:b-1,:);data(e:end,:)];
        testLabels = labels(b:e-1,:);
        testData = data(b:e-1,:);
    end
    
    
        svmOptions = '-s 0 -t 2 -g 0.143587294374629 -c 20';
        model = svmtrain(trainLabels, trainData, svmOptions);
        [~,~,~,accuracy,fmeasure]=evaluateModel(    model,'svm',...
                                                    testLabels,testData,...
                                                    no_classes);
        accuracyOverFolds(i) = accuracy;
        fmeasureOverFolds(i) = fmeasure;
    
end
accuracy = mean(accuracyOverFolds);
fmeasure = mean(fmeasureOverFolds);
info=[accuracy' ,fmeasure'];