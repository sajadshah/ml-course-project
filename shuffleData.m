%this script shuffle the data randomly for the first time and use that
%random generated first for the rest.
shData = zeros(size(data,1),size(data,2));
shLabels = zeros(size(labels,1),size(labels,2));
no_data = size(data,1);
if exist('randompermutation.mat','file')
    load('randompermutation.mat');
else
    a=randperm(no_data);
    save('randompermutation.mat','a');
end
for i=1:no_data
    shData(i,:)=data(a(i),:);
    shLabels(i,:)=labels(a(i),:);
end
data = shData;
labels = shLabels;
clear shData shLabels a;