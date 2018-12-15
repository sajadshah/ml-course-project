function [ feature ] = extractFeatures( img , option, bag)
%EXTRACTFEATURES this function extract features from image and returns a
%vector indicating feature vector.
%   input: 
%       img : image we want to extract features from
%       option : a string specifying which features we want to extract.
%           containing words color or shape or texture of bagOfWords or together seperated by space
%       bag: is used wen bagOfWords option is included in option string
%       output: feature vector

    ops = strsplit(option,' ');
    feature = [];
    for op = ops
        switch (op{1})
            case 'color'
                feature = [feature extractColorFeature(img)];
            case 'texture'
                feature = [feature extractTextureFeature(img)];
            case 'shape'
                feature = [feature extractShapeFeature(img)];
            case 'bagOfWords'
                feature = [feature extractBagOfWordsFeature(img,bag)];
        end        
    end
end

