function [output] = wm_extract(view, f_input_l, f_input_r, d_input_l, d_input_r, blockSize, wmKey, watermarkSize, W, source)
%	tic
	initialSource();
%	toc
%	tic
	imW = inputWidth;
	imH = inputHeight;

	%original syn image
%	VSRSStringOri{view}
	[status,resultStr]= system(VSRSStringOri{view});
	oriYUV = loadYUV(VSRSName{view},imW,imH);
	oriIm = rgb2ycbcr(oriYUV);
	oriIm = oriIm(:,:,1);
	

	[status,resultStr]= system(VSRSString{view});
	
	tmpYUV = loadYUV(VSRSName{view},imW,imH);
	I2 = rgb2ycbcr(tmpYUV);
	I2 = I2(:,:,1);
%	toc
%	tic
	[f_syn , d_syn ]= vl_sift(single(I2));
%	toc
%	tic
	[ disparityTable_l ] = SIFT_disparity( d_syn,d_input_l,f_syn,f_input_l );
	[ disparityTable_r ] = SIFT_disparity( d_syn,d_input_r,f_syn,f_input_r );
%	toc
%	tic
	csvwrite(disparityName{view},disparityTable_l');
%	toc
%	tic
	tmpStr = strcat('./disparitymap_nn',{' '},disparityName{view},{' '},num2str(length(disparityTable_l)),' 1088 1920',{' '},reconsName{view});
	systemStr = tmpStr{1,1};
	system(systemStr);
%	toc
%	tic
	disparityMap_l = csvread(reconsName{view});
%	toc
	csvwrite(disparityName{view},disparityTable_r');
	tmpStr = strcat('./disparitymap_nn',{' '},disparityName{view},{' '},num2str(length(disparityTable_r)),' 1088 1920',{' '},reconsName{view});
	systemStr = tmpStr{1,1};
	system(systemStr);
	disparityMap_r = csvread(reconsName{view});
%	tic
	normL = norm(reshape(disparityMap_l,1,[]).*reshape(disparityMap_l,1,[]),1);
	normR = norm(reshape(disparityMap_r,1,[]).*reshape(disparityMap_r,1,[]),1);
		        
	if normL < normR
		newImage = recoverDisparityMap( disparityMap_l , I2 );
	else
		newImage = recoverDisparityMap( disparityMap_r , I2 );
	end

	[ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
	BER = norm((W-extracted)/2,1) / watermarkSize;
	output = BER;
	if oriIm == I2
		psnrVal = 'Inf';
	else
		psnrVal = num2str(PSNR(double(oriIm)/255,double(I2)/255),'%.2f');
	end
	fprintf(2,'%.3f,%s',output*100,psnrVal);
	
%	tic
	recoverWM = reshape(extracted,floor(inputHeight/blockSize),floor(inputWidth/blockSize));
	
	
	recoverWM = uint8((recoverWM + 1) * 127);
	
	%recoverWM = imresize(recoverWM,[34 60],'nearest');
	
	outputName = strcat(num2str(view),'.jpg');
	outputOriName = strcat('ori',num2str(view),'.jpg');
	wmOutName = strcat('wm',num2str(view),'.jpg');
	imwrite(tmpYUV,outputName,'jpg');
	imwrite(oriYUV,outputOriName,'jpg');
	imwrite(recoverWM,wmOutName,'jpg');
%	toc
end


