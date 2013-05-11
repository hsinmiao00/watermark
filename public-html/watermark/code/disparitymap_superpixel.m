function [ output ] = disparitymap_superpixel( disparityTable , height , width, oriImage, nC )
%DISPARITYMAP_NN Summary of this function goes here
%   Detailed explanation goes here

output = zeros(height,width);
numberMask = zeros(height,width);

[labels] = mex_ers(double(oriImage),nC);
labels = labels + 1;
segRecord = zeros(1,nC);

for i = 1 : length(disparityTable)
    iPosition = round(disparityTable(1,i));
    jPosition = round(disparityTable(2,i));
    segmentNum = labels( jPosition , iPosition );
    tmpMask = double(labels == segmentNum);
    output = output + tmpMask * disparityTable(3,i);
    numberMask = numberMask + tmpMask;
    
    segRecord(segmentNum) = 1;
end

% tmpMask2 = double(numberMask > 0);
% tmpImage = ((output+20) .* tmpMask2);
% imshow(uint8(tmpImage*3+10));
% for i = 1 : nC
%     if segRecord(i) == 0
%         fprintf(1,'%d ',i);
%     end
% end
% fprintf(1,'total: %d\n',nC-sum(segRecord));
%%
%find the nearest segment s and fill the disparity of s
for i = 1 : height
    for j = 1 : width
        if(numberMask(i,j)==0)
            tmp = disparityTable(1:2,:);
            tmp(1,:) = tmp(1,:) - j;
            tmp(2,:) = tmp(2,:) - i;
            distance = tmp(1,:).*tmp(1,:) + tmp(2,:).*tmp(2,:);
            [value,nearestpoint] = min(distance);
            %output(i,j) = disparitytable(3,nearestpoint);

            segmentnum = labels( i , j );
            tmpMask = double(labels == segmentnum);
            output = output + tmpMask * disparityTable(3,nearestpoint);
            numberMask = numberMask + tmpMask;

            %numbermask(i,j) = 1;
        end
    end
end



%%
%intra-matching
% 
% histDescriptors = zeros(sum(segRecord),255);
% count = 1;
% for i = 1 : nC
%     if segRecord(i) == 1
%         inputMask = labels==i;
%         tmpI = double(oriImage) .* double(inputMask);
%         h = hist(reshape(tmpI,1,[]),255);
%         h_2 = h(2:255);
%         h_3 = h_2 / sum(h_2);
%         
%         histDescriptors(count,1) = i;
%         histDescriptors(count,2:255) = h_3;
%         count = count + 1;
%     end
% end
% 
% for i = 1 : nC
%     if segRecord(i) == 0
%         inputMask = labels==i;
%         tmpI = double(oriImage) .* double(inputMask);
%         h = hist(reshape(tmpI,1,[]),255);
%         h_2 = h(2:255);
%         h_3 = h_2 / sum(h_2);
%         
%         minVal = 99999999;
%         minSeg = 0;
%         for j = 1 : sum(segRecord)
%             tmpH = histDescriptors(j,2:255);
%             err = norm(h_3-tmpH);
%             if err < minVal
%                 minVal = err;
%                 minSeg = histDescriptors(j,1);
%             end
%         end
%         
%         fprintf(1,'%d %d\n',i, minSeg);
%         
%         tmpMask = double(labels == minSeg);
%         disparityVal = max(max( double(output) .* double(tmpMask) ));
%         quotient = max(max( double(numberMask) .* double(tmpMask) ));
%         
%         tmpMask2 = (labels == i);
%         output = output + double(tmpMask2) * (disparityVal / quotient);
%         numberMask = numberMask + double(tmpMask2);
%         
%     end
% end

%%
output = output ./ numberMask;

end

