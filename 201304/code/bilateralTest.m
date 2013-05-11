deltaArr = [3,5,7,9];
rangeArr = [0.01,0.025,0.05,0.1];

maxVal = max(max(disparityMap2));
minVal = min(min(disparityMap2));
for i = 1 : length(deltaArr)
    for j = 1 : length(rangeArr)
        bilaOut = bilateralFilter(double(disparityMap2), double(disparityMap2), minVal , maxVal , deltaArr(i) , rangeArr(j) );
        newImage2 = recoverDisparityMap( bilaOut*20 , I2 );
        [ extracted ] = ISSExtract( newImage2, blockSize,wmKey,watermarkSize );
        BER = norm((W-extracted)/2,1) / watermarkSize;
        fprintf(1,'BER=%f PSNR=%f SSIM=%f\n',BER,PSNR(double(compress_I_L)/255,double(newImage2)/255),ssim((compress_I_L),newImage2));
        
        sum( sum( sqrt(((tmpDisparityMap) - (bilaOut*20)) .* ((tmpDisparityMap) - (bilaOut*20))) )) / 1920 / 1088
    end
end

