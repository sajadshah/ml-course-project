function [ c , gamma ] = parameterValues()
%PARAMETERVALUES Summary of this function goes here
%   Detailed explanation goes here

%cpo=-5:2:17;
gpo=-5:0.2:-1;
c = 2:2:32;

twos = ones(1,length(gpo))+ones(1,length(gpo));
gamma = twos .^ gpo;
end

