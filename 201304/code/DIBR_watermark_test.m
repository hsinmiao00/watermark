%deltaArr = [1,3,6];
%qualityArr = [1];

%imSize = size(original_I_L);
%patternLength = 100;
%blockSize = 16;
%wmKey = sign(randn(1,patternLength));
%watermarkSize = floor((imSize(1)/blockSize))*floor((imSize(2)/blockSize)) ;
%W = sign(randn(watermarkSize,1));
%maxDisparity = 0;
%result = zeros(length(deltaArr),maxDisparity+1);

for ii = 1 : length(deltaArr)
    %for jj = 1 : length(qualityArr)
    [ output ] = ISSEmbed( original_I_L , W , deltaArr(ii) , 1.5 , blockSize , wmKey , watermarkSize );
    original_I_L_ycbcr(:,:,1) = output;
    saveYUV( ycbcr2rgb(original_I_L_ycbcr), 'tmp_I_l.yuv');
    
    %[ output ] = ISSEmbed( original_I_R , W , deltaArr(ii) , 1.5 , blockSize , wmKey , watermarkSize );
    %original_I_R_ycbcr(:,:,1) = output;
    %saveYUV( ycbcr2rgb(original_I_R_ycbcr), 'tmp_I_r.yuv');
    
    [status,resultStr]= system('ViewSynVC7.exe vsrs_dancer_tmp.cfg');
    
    tmpYUV = loadYUV('dancer_syn_tmp.yuv',1920,1088);
    I2 = rgb2ycbcr(tmpYUV);
    I2 = I2(:,:,1);
    
    for kk = 0 : maxDisparity
        newImage = zeros(imSize(1),imSize(2));
        offset = kk;
        
        for u = 1 : imSize(1)
            for v = 1 : imSize(2)
                tmpIndex = round(v-disparityMap(u,v));
                if tmpIndex > imSize(2)
                    tmpIndex = imSize(2);
                end
                if tmpIndex < 1
                    tmpIndex = 1;
                end
                newImage(u,v) = I2(u,tmpIndex);
            end
        end
        [ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
        BER = norm((W-extracted)/2,1) / watermarkSize;
        
        %result(ii,kk+1);
        %PSNR(double(output)/255,double(newImage)/255);
        %ssim((output),newImage);
        fprintf(1,'shift=%d BER=%f PSNR=%f SSIM=%f\n',kk,BER,PSNR(double(compress_I_L)/255,double(newImage)/255),ssim((compress_I_L),newImage));
    end
    %end
end

