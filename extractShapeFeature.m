function [ zm ] = extractShapeFeature( img )
%EXTRACTSHAPEFEATURE Summary of this function goes here
%   Detailed explanation goes here
    n = 4; m = 2;           % Define the order and the repetition of the moment
    img = imresize(img, [200 200]);
    p = rgb2gray(img);
    
    
    p = logical(not(p));
    
    [~, AOH, PhiOH] = Zernikmoment(p,n,m);      % Call Zernikemoment fuction
    zm = [AOH,PhiOH];

end

