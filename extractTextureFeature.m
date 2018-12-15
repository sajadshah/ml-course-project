function [ tf ] = extractTextureFeature( img )
%EXTRACTTEXTUREFEATURE this function extract texture features form image 
%   Detailed explanation goes here
gaborArray = gaborFilterBank(3,4,39,39);
tf = gaborFeatures(img,gaborArray,32,32);
tf=tf';
end

