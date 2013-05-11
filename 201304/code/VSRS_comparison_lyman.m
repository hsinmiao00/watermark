deltaArr = [1,3,6];
%peakThreshold = [5,7,9,11,13,15];
peakThreshold = [1,2,3,6,8];
blockSize = 64;
patternLength = 800;
QPColor = 25;
QPDepth = 34;
tx = 50;
tx_extract = 134;
lamda = 1.2;

imSize = size(original_I_L);

wmKey = sign(randn(1,patternLength));
watermarkSize = floor((imSize(1)/blockSize))*floor((imSize(2)/blockSize)) ;
W = sign(randn(watermarkSize,1));
W2 = sign(randn(watermarkSize,1));
W_L = sign(randn(1,patternLength));
W_R = sign(randn(1,patternLength));
%result = zeros(length(deltaArr),maxDisparity+1);

for i = 1 : length(deltaArr)
    
   
    %%
    %LYMAN
    [markedfile] = DIBR_SpreadSpectrumEmbed(original_I_L,  wmKey, W_L, W_R, W, deltaArr(i), lamda, blockSize, original_D_L, tx, 1);
    original_I_L_ycbcr(:,:,1) = markedfile;
    saveYUV( ycbcr2rgb(original_I_L_ycbcr), 'tmp_I_recon_l.yuv');
    PSNR(double(original_I_L)/255,double(markedfile)/255)
    %[ output ] = ISSEmbed( original_I_R , W , deltaArr(i) , lamda , blockSize , wmKey , watermarkSize );
    %original_I_R_ycbcr(:,:,1) = output;
    %saveYUV( ycbcr2rgb(original_I_R_ycbcr), 'tmp_I_r.yuv');
    
%     systemStr = strcat('TAppEncoder.exe  --QP=',num2str(QPColor),HTMString_I_L);
%     [status,resultStr] = system( systemStr );
%     
%     %systemStr = strcat('TAppEncoder.exe  --QP=',num2str(QPColor),HTMString_I_R);
%     %[status,resultStr] = system( systemStr );
%     
%     compress_I_L = loadYUV('tmp_I_recon_l.yuv',inputWidth,inputHeight);
%     compress_I_L_ycbcr = rgb2ycbcr(compress_I_L);
%     compress_I_L = compress_I_L_ycbcr(:,:,1);
%     
%     %compress_I_R = loadYUV('tmp_I_recon_r.yuv',inputWidth,inputHeight);
%     %compress_I_R_ycbcr = rgb2ycbcr(compress_I_R);
%     %compress_I_R = compress_I_R_ycbcr(:,:,1);
%     
%     DIBR_SS_Detect(compress_I_L, wmKey, W_L, W_R, W,blockSize, 1);
%     
%     I2 = Render(compress_I_L, original_D_L, tx_extract, 'l', 1);
%     I2 = I2(:,:,1);
%     
%     DIBR_SS_Detect(I2,wmKey, W_L, W_R, W,blockSize, 1);
    
    %no compression
    [status,resultStr]= system(VSRSString);
    
    tmpYUV = loadYUV(VSRSName,inputWidth,inputHeight);
    I2 = rgb2ycbcr(tmpYUV);
    I2 = I2(:,:,1);
    
    DIBR_SS_Detect(I2,wmKey, W_L, W_R, W,blockSize, 1);
    
     %% MY METHOD
    [ output ] = ISSEmbed( original_I_L , W , deltaArr(i) , lamda , blockSize , wmKey , watermarkSize );
    original_I_L_ycbcr(:,:,1) = output;
    saveYUV( ycbcr2rgb(original_I_L_ycbcr), 'tmp_I_recon_l.yuv');
    PSNR(double(original_I_L)/255,double(output)/255)
    
    %[ output ] = ISSEmbed( original_I_R , W , deltaArr(i) , lamda , blockSize , wmKey , watermarkSize );
    %original_I_R_ycbcr(:,:,1) = output;
    %saveYUV( ycbcr2rgb(original_I_R_ycbcr), 'tmp_I_r.yuv');
    
%     systemStr = strcat('TAppEncoder.exe  --QP=',num2str(QPColor),HTMString_I_L);
%     [status,resultStr] = system( systemStr );
%     %systemStr = strcat('TAppEncoder.exe  --QP=',num2str(QPColor),HTMString_I_R);
%     %[status,resultStr] = system( systemStr );
%     
%     compress_I_L = loadYUV('tmp_I_recon_l.yuv',inputWidth,inputHeight);
%     compress_I_L_ycbcr = rgb2ycbcr(compress_I_L);
%     compress_I_L = compress_I_L_ycbcr(:,:,1);
%     
%     %compress_I_R = loadYUV('tmp_I_recon_r.yuv',inputWidth,inputHeight);
%     %compress_I_R_ycbcr = rgb2ycbcr(compress_I_R);
%     %compress_I_R = compress_I_R_ycbcr(:,:,1);
%     
%     [ extracted ] = ISSExtract( compress_I_L, blockSize,wmKey,watermarkSize );
%     BER = norm((W-extracted)/2,1) / watermarkSize;
%     fprintf(1,'compression BER=%f\n',BER);
%     
%     I2 = Render(compress_I_L, original_D_L, tx_extract, 'l', 1);
%     I2 = I2(:,:,1);
%     
%     for j = 1 : length(peakThreshold)
%         [f_syn , d_syn ]= vl_sift(single(I2), 'PeakThresh', peakThreshold(j)) ;
%         [f_input , d_input ]= vl_sift(single(original_I_L), 'PeakThresh', peakThreshold(j)) ;
%         
%         [ disparityTable ] = SIFT_disparity( d_syn,d_input,f_syn,f_input );
%         [ disparityMap ] = disparitymap_nn( disparityTable , imSize(1) , imSize(2) );     
%         %disparityMap = bilateralFilter(double(disparityMap)/20, double(I2)/255, 0, 1, 3,0.1 );
%         %disparityMap = disparityMap*20;
%         newImage = recoverDisparityMap( disparityMap , I2 );
%         
%         [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
%         BER = norm((W-extracted)/2,1) / watermarkSize;
%         
%         fprintf(1,'BER=%f PSNR=%f SSIM=%f\n',BER,PSNR(double(compress_I_L)/255,double(newImage)/255),ssim((compress_I_L),newImage));       
%     end
    
    %no compression
    [status,resultStr]= system(VSRSString);
    
    tmpYUV = loadYUV(VSRSName,inputWidth,inputHeight);
    I2 = rgb2ycbcr(tmpYUV);
    I2 = I2(:,:,1);
    
    for j = 1 : length(peakThreshold)
        [f_syn , d_syn ]= vl_sift(single(I2), 'PeakThresh', peakThreshold(j)) ;
        [f_input , d_input ]= vl_sift(single(original_I_L), 'PeakThresh', peakThreshold(j)) ;
        
        [ disparityTable ] = SIFT_disparity( d_syn,d_input,f_syn,f_input );
        [ disparityMap ] = disparitymap_nn( disparityTable , imSize(1) , imSize(2) );     
        %disparityMap = bilateralFilter(double(disparityMap)/20, double(I2)/255, 0, 1, 3,0.1 );
        %disparityMap = disparityMap*20;
        newImage = recoverDisparityMap( disparityMap , I2 );
        
        [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
        BER = norm((W-extracted)/2,1) / watermarkSize;
        
%         fprintf(1,'BER=%f PSNR=%f SSIM=%f\n',BER,PSNR(double(compress_I_L)/255,double(newImage)/255),ssim((compress_I_L),newImage));   
        fprintf(1,'BER=%f\n',BER);
    end
end
