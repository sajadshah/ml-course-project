function [ cf ] = extractColorFeature( img )
%SAMPLEFUNC this function extract color histogram from image img and return
%it as a feature vector. number of bins could be change from inside the
%function manually.
%  
no_bins = 8; %or 8
hsvImg = rgb2hsv(img);
[h,~] = imhist(hsvImg(:,:,1),no_bins);
[s,~] = imhist(hsvImg(:,:,2),no_bins);
[v,~] = imhist(hsvImg(:,:,3),no_bins);
h = h/sum(h);
s = s/sum(s);
v = v/sum(v);
cf = [h',mean(h),std(h),skewness(h),...
      s',mean(s),std(s),skewness(s),...
      v',mean(v),std(v),skewness(v)];
end

