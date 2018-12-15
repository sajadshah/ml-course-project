%% loading data from folder CorelDB and its subfolders
rootFolder = fullfile('CorelDB');
imgSets = [ imageSet(fullfile(rootFolder, '2_building')), ...
            imageSet(fullfile(rootFolder, '3_buses')), ...
            imageSet(fullfile(rootFolder, '4_dinasours')),...
            imageSet(fullfile(rootFolder, '5_elephants')),...
            imageSet(fullfile(rootFolder, '6_flowers')),...
            imageSet(fullfile(rootFolder, '7_horses')),...
            imageSet(fullfile(rootFolder, '8_mountains')),...
            imageSet(fullfile(rootFolder, '9_foods'))];
               
no_classes = length(imgSets);
featureOption = 'color'; % this string indicate features we want to extract from images. options include color, shape, texture and bagOfWords seperated by space.
imgSetsForBag = partition(imgSets, 40, 'randomize');
if exist('bag.mat','file')
    load('bag.mat');
else
    bag = bagOfFeatures(imgSetsForBag,...
                    'VocabularySize' ,400,...
                    'StrongestFeatures',0.8);
    save('bag.mat','bag');
end


labels = [];
data = [];
for c = 1:no_classes
   set = imgSets(c);
   for i=1:set.Count
       img = read(set,i);
       featureVector = extractFeatures(img,featureOption,bag); %extract features for each image individually.
       data = [data; featureVector];
       labels = [labels; c];
       fprintf('class: %d, image: %d\n',c,i);
   end
end
shuffleData();
save('data.mat','no_classes','data','labels');