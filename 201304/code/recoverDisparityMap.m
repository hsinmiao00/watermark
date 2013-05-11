function [ output ] = recoverDisparityMap( disparityMap , original )
%RECOVERDISPARITYMAP Summary of this function goes here
%   Detailed explanation goes here
imSize = size(original);
output = zeros(imSize(1),imSize(2));

for u = 1 : imSize(1)
    for v = 1 : imSize(2)
        tmpIndex = round(v-disparityMap(u,v));
        if tmpIndex > imSize(2)
            tmpIndex = imSize(2);
        end
        if tmpIndex < 1
            tmpIndex = 1;
        end
        output(u,v) = original(u,tmpIndex);
    end
end

end

