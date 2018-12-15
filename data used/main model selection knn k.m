clear;

%%loading data either from original files or from saved previous feature extraction
%loadImagesAndExtractFeatures();
load('data.mat');


%%k fold cross validation for tuning parameters gamma and C for svm classifier

no_data = size(data,1);
k = 4;
foldSize = floor(no_data/k);
bounds = [1:foldSize:no_data, no_data+1];

gk = @(x,Z) gaussianKernel(x,Z,1);
Ks = [1,2,3,4,5,6,7,8,9,10,15,20,25,30,100,200];

accuracyOverFolds = zeros(k,size(Ks,2));
fmeasureOverFolds = zeros(k,size(Ks,2));
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
    
    for j=1:size(Ks,2)

        mdl = fitcknn(trainData,trainLabels,...
            'NSMethod',         'exhaustive',...
            'NumNeighbors',     Ks(j),...
            'BreakTies',        'nearest',...
            'Distance',         'seuclidean',...
            'DistanceWeight',   'squaredinverse');

        [~,~,~,accuracy,fmeasure]=evaluateModel(    mdl,'knn',...
                                                    testLabels,testData,...
                                                    no_classes);
        accuracyOverFolds(i,j) = accuracy;
        fmeasureOverFolds(i,j) = fmeasure;
    end
end
accuracy = mean(accuracyOverFolds);
fmeasure = mean(fmeasureOverFolds);
info=[accuracy' ,fmeasure'];
df = df';