function [ outputNum ] = findNearestSegment( segNum, labels, oriImage )
%FINDNEARESTSEGMENT Summary of this function goes here
%   Detailed explanation goes here
inputMask = labels==segNum;
tmpI = double(oriImage) .* double(inputMask);
h1 = hist(reshape(tmpI,1,[]),255);
h1_2 = h1(2:255);
h1_3 = h1_2 / sum(h1_2);

nC = max(max(labels));
minVal = 99999999;
minSeg = 0;
for i = 1 : nC
    if i == segNum
        continue;
    end
    
    inputMask = labels==i;
    tmpI = double(oriImage) .* double(inputMask);
    h2 = hist(reshape(tmpI,1,[]),255);
    h2_2 = h2(2:255);
    h2_3 = h2_2 / sum(h2_2);
    
    err = norm(h1_3-h2_3);
    if err < minVal
        minVal = err;
        minSeg = i;
    end
end

outputNum = minSeg;

end

