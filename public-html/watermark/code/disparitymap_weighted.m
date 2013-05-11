function [ output ] = disparitymap_weighted( disparityTable , height , width )
%DISPARITYMAP_NN Summary of this function goes here
%   Detailed explanation goes here

%height = 1088;
%width = 1920;

numOfPoints = 5;

output = zeros(height,width);
for i = 1 : height
    for j = 1 : width
        tmp = disparityTable(1:2,:);
        tmp(1,:) = tmp(1,:) - j;
        tmp(2,:) = tmp(2,:) - i;
        
        distance = ones(1,length(disparityTable))./(tmp(1,:).*tmp(1,:) + tmp(2,:).*tmp(2,:));
        %distance = (tmp(1,:).*tmp(1,:) + tmp(2,:).*tmp(2,:));
        [B,IX] = sort(distance,'descend');
           
        distanceSum = sum( B(1:numOfPoints) );
        
        value = 0;
        for k = 1 : numOfPoints
            value = value + disparityTable( 3 , IX(k) ) * B(k) / distanceSum;
        end
        
        output(i,j) = round(value);
    end
    %i
end

end

