function [ d_new, f_new ] = featurepoint_select( d_ori, f_ori, distance )
%FEATUREPOINT_SELECT Summary of this function goes here
%   Detailed explanation goes here
d_new = [];
f_new = [];
for i = 1 : length(d_ori)
    curX = f_ori(1,i);
    curY = f_ori(2,i);
    for j = 1 : i-1
        tmpX = f_ori(1,j);
        tmpY = f_ori(2,j);
        
        pointDistance = sqrt( (curX-tmpX) * (curX-tmpX) + (curY-tmpY) * (curY-tmpY) );
        if pointDistance < distance
           break; 
        end
        
        if j == i-1
           d_new = [d_new , d_ori(:,i)];  
           f_new = [f_new , f_ori(:,i)];  
        end
    end
end

end

