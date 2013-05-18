imSize = size(original_I_L);
tmpDisparityMap = zeros(imSize(1),imSize(2));
for i = 1 : imSize(1)
    for j = 1 : imSize(2)
        z = 1 / ( double(original_D_L(i,j))/255*(1/Z_near - 1/Z_far) + 1/Z_far );
        tmpDisparity = A_L(1,1) * (T_syn(1)-T_L(1)) / z + A_syn(1,3) - A_L(1,3);
        tmpDisparityMap(i,j) = tmpDisparity;
    end
end
