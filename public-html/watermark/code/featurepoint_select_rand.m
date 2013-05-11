function [ d_new, f_new ] = featurepoint_select_rand( d_ori, f_ori, distance )
%FEATUREPOINT_SELECT Summary of this function goes here
%   Detailed explanation goes here


d_new = [];
f_new = [];

randPerm = randperm(length(d_ori));
for i = 1 : distance
    d_new = [d_new , d_ori(:,randPerm(i))];  
    f_new = [f_new , f_ori(:,randPerm(i))];
end



end

