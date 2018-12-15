function [ bogf ] = extractBagOfWordsFeature( img,bag )
%EXTRACTBAGOFWORDSFEATURE Summary of this function goes here
%   Detailed explanation goes here

bogf = encode(bag, img);

end

