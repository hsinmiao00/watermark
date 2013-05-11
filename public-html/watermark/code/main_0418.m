deltaArr = [3];
%peakThreshold = [1,3,5,7,9,11,13];
%distanceThreshold = [10,20,30,40,50];
distanceThreshold = [];
peakThreshold = [1];
blockSize = 32;
patternLength = 400;
QPColor = 25;
QPDepth = 34;

imSize = size(original_I_L);

wmKey = sign(randn(1,patternLength));
watermarkSize = floor((imSize(1)/blockSize))*floor((imSize(2)/blockSize)) ;
W = sign(randn(watermarkSize,1));
W2 = sign(randn(watermarkSize,1));



%result = zeros(length(deltaArr),maxDisparity+1);

for i = 1 : length(deltaArr)
    
    [ embed_I_L ] = ISSEmbed( original_I_L , W , deltaArr(i) , 1.5 , blockSize , wmKey , watermarkSize );
    original_I_L_ycbcr(:,:,1) = embed_I_L;
    saveYUV( ycbcr2rgb(original_I_L_ycbcr), 'tmp_I_recon_l.yuv');
    
    %[ output ] = ISSEmbed( original_I_R , W , deltaArr(i) , 1.5 , blockSize , wmKey , watermarkSize );
    %original_I_R_ycbcr(:,:,1) = output;
    %saveYUV( ycbcr2rgb(original_I_R_ycbcr), 'tmp_I_r.yuv');
    
    %systemStr = strcat('./TAppEncoderStatic  --QP=',num2str(QPColor),HTMString_I_L);
    %[status,resultStr] = system( systemStr );
    %systemStr = strcat('./TAppEncoderStatic  --QP=',num2str(QPColor),HTMString_I_R);
    %[status,resultStr] = system( systemStr );
    
    %compress_I_L = loadYUV('tmp_I_recon_l.yuv',inputWidth,inputHeight);
    %compress_I_L_ycbcr = rgb2ycbcr(compress_I_L);
    %compress_I_L = compress_I_L_ycbcr(:,:,1);
    
    %compress_I_R = loadYUV('tmp_I_recon_r.yuv',inputWidth,inputHeight);
    %compress_I_R_ycbcr = rgb2ycbcr(compress_I_R);
    %compress_I_R = compress_I_R_ycbcr(:,:,1);
    
    %[ extracted ] = ISSExtract( compress_I_L, blockSize,wmKey,watermarkSize );
    %BER = norm((W-extracted)/2,1) / watermarkSize;
    %fprintf(1,'compression BER=%f\n',BER);
    
    [status,resultStr]= system('./ViewSyn vsrs_dancer_tmp.cfg');
    
    tmpYUV = loadYUV('dancer_syn_tmp.yuv',1920,1088);
    I2 = rgb2ycbcr(tmpYUV);
    I2 = I2(:,:,1);
    
    for j = 1 : length(peakThreshold)
        %[f_syn , d_syn ]= vl_sift(single(I2), 'PeakThresh', peakThreshold(j)/5) ;
        %[f_syn , d_syn ]= vl_sift(single(I2));
        %[f_input , d_input ]= vl_sift(single(embed_I_L), 'PeakThresh', peakThreshold(j)) ;
        
        %[ d_input, f_input ] = featurepoint_select( d_input, f_input, 30 );
        %d_input = round(d_input / 16)*16;
        
        %[ disparityTable ] = SIFT_disparity( d_syn,d_input,f_syn,f_input );
        [ disparityTableChog ] = chog_disparity( I2, embed_I_L );
        
        [ disparityMap ] = disparitymap_nn( disparityTableChog , 1088 , 1920 );
        %[ disparityMap ] = disparitymap_superpixel( disparityTable , 1088 , 1920 , I2 );
        %disparityMap = bilateralFilter(double(disparityMap)/20, double(I2)/255, 0, 1, 3,0.1 );
        %disparityMap = disparityMap*20;
        newImage = recoverDisparityMap( disparityMap , I2 );
        
        [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
        BER = norm((W-extracted)/2,1) / watermarkSize;
        err = sum( sum( (((tmpDisparityMap) - (disparityMap)) .* ((tmpDisparityMap) - (disparityMap))) )) / imSize(1) / imSize(2);
        fprintf(1,'BER=%f PSNR=%f SSIM=%f err=%f\n',BER,PSNR(double(original_I_L)/255,double(newImage)/255),ssim((original_I_L),newImage),err);
        
%         [ disparityMap2 ] = disparitymap_superpixel( disparityTable , 1088 , 1920 , I2 ,50);
%         newImage2 = recoverDisparityMap( disparityMap2 , I2 );
%         
%         [ extracted ] = ISSExtract( newImage2, blockSize,wmKey,watermarkSize );
%         BER = norm((W-extracted)/2,1) / watermarkSize;
%         err = sum( sum( (((tmpDisparityMap) - (disparityMap2)) .* ((tmpDisparityMap) - (disparityMap2))) )) / imSize(1) / imSize(2);
%         fprintf(1,'BER=%f PSNR=%f SSIM=%f err=%f\n',BER,PSNR(double(compress_I_L)/255,double(newImage2)/255),ssim((compress_I_L),newImage2),err);
%         
        
        length(d_input)
        
        for k = 1 : length(distanceThreshold)       
            [ d_input2, f_input2 ] = featurepoint_select( d_input, f_input, distanceThreshold(k) );
            [ disparityTable ] = SIFT_disparity( d_syn,d_input2,f_syn,f_input2 );
            [ disparityMap ] = disparitymap_nn( disparityTable , 1088 , 1920 );
            newImage = recoverDisparityMap( disparityMap , I2 );
            [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
            BER = norm((W-extracted)/2,1) / watermarkSize;
            err = sum( sum( (((tmpDisparityMap) - (disparityMap)) .* ((tmpDisparityMap) - (disparityMap))) )) / imSize(1) / imSize(2);
            fprintf(1,'BER=%f PSNR=%f SSIM=%f err=%f\n',BER,PSNR(double(original_I_L)/255,double(newImage)/255),ssim((original_I_L),newImage),err);
            length(d_input2)
            
            
            d_input3 = round(d_input2 / 16)*16;
            [ disparityTable ] = SIFT_disparity( d_syn,d_input3,f_syn,f_input2 );
            [ disparityMap ] = disparitymap_nn( disparityTable , 1088 , 1920 );
            newImage = recoverDisparityMap( disparityMap , I2 );
            [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
            BER = norm((W-extracted)/2,1) / watermarkSize;
            err = sum( sum( (((tmpDisparityMap) - (disparityMap)) .* ((tmpDisparityMap) - (disparityMap))) )) / imSize(1) / imSize(2);
            fprintf(1,'BER=%f PSNR=%f SSIM=%f err=%f\n',BER,PSNR(double(original_I_L)/255,double(newImage)/255),ssim((original_I_L),newImage),err);
        end
    end
    
    fprintf(1,'ground truth\n');
    newImage2 = recoverDisparityMap( tmpDisparityMap , I2 );
    
    [ extracted ] = ISSExtract( newImage2, blockSize,wmKey,watermarkSize );
    BER = norm((W-extracted)/2,1) / watermarkSize;
    
    fprintf(1,'BER=%f PSNR=%f SSIM=%f\n',BER,PSNR(double(original_I_L)/255,double(newImage2)/255),ssim((original_I_L),newImage2));
end
