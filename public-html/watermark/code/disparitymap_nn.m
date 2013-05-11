function [ output ] = disparitymap_nn( disparityTable , height , width )

output = zeros(height,width);
for i = 1 : height
    for j = 1 : width
        tmp = disparityTable(1:2,:);
        tmp(1,:) = tmp(1,:) - j;
        tmp(2,:) = tmp(2,:) - i;
        distance = tmp(1,:).*tmp(1,:) + tmp(2,:).*tmp(2,:);
        [value,nearestPoint] = min(distance);
        output(i,j) = disparityTable(3,nearestPoint);
    end
end

end

