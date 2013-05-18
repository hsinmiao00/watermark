function [ output ] = SIFT_disparity( d_syn,d_input,f_syn,f_input )
%SIFT_DISPARITY Summary of this function goes here
%   Detailed explanation goes here

[matches, scores] = vl_ubcmatch(d_syn, d_input) ;
output = [];
maxDisparity = 80;
maxScore = 25000;
verticalThreshold = 3;

for i = 1 : length(matches)
    synIndex = matches(1,i);
    inputIndex = matches(2,i);
    
    tmp=zeros(3,1);
    tmp(1:2) = f_syn(1:2,synIndex);
    tmp(3) = f_input(1,inputIndex) - f_syn(1,synIndex);
    
    if abs(tmp(3)) < maxDisparity && scores(i) < maxScore &&  abs(f_input(2,inputIndex)- f_syn(2,synIndex))<verticalThreshold
        output = [output,tmp];
    end
end

end

