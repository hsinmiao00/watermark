function [output] = wm(source, wm, alpha, siSize)
	tic
	addpath(genpath('./code/'));

	%%=============parameter setting===============
	%peakThreshold = [1,3,5,7,9,11,13];
	%distanceThreshold = [10,20,30,40,50];
	distanceThreshold = [];
	peakThreshold = [1];
	blockSize = 32;
	patternLength = 400;

	%compression parameters
	%QPColor = 25;
	%QPDepth = 34;
	output = 0;

	points = floor(siSize*1000/128);
	%%=============================================
	
	initialSource();

	imSize = size(original_I_L);

	wmKey = sign(randn(1,patternLength));
	watermarkSize = floor((imSize(1)/blockSize))*floor((imSize(2)/blockSize)) ;
	
	myWM = imread(wm);
	myWM = rgb2gray(myWM);
	
	myWM = imresize(myWM, [floor(imSize(1)/blockSize) floor(imSize(2)/blockSize)]);
	
	myWM = reshape(double(myWM),[],1);
	W = sign(myWM-128);

	%W = sign(randn(watermarkSize,1));

	%result = zeros(length(deltaArr),maxDisparity+1);

	[ embed_I_L ] = ISSEmbed( original_I_L , W , alpha , 1.5 , blockSize , wmKey , watermarkSize );
	original_I_L_ycbcr(:,:,1) = embed_I_L;
	saveYUV( ycbcr2rgb(original_I_L_ycbcr), 'tmp_I_recon_l.yuv');

	[ embed_I_R ] = ISSEmbed( original_I_R , W , alpha , 1.5 , blockSize , wmKey , watermarkSize );
	original_I_R_ycbcr(:,:,1) = embed_I_R;
	saveYUV( ycbcr2rgb(original_I_R_ycbcr), 'tmp_I_recon_r.yuv');

	%%===================================for compression=================================
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
	%%=====================================================================================
	
	
	[f_input_l , d_input_l ]= vl_sift(single(embed_I_L) ) ;
	[f_input_r , d_input_r ]= vl_sift(single(embed_I_R) ) ;
	[ d_input_l, f_input_l ] = featurepoint_select_rand( d_input_l, f_input_l, points );
	[ d_input_r, f_input_r ] = featurepoint_select_rand( d_input_r, f_input_r, points );
	
	d_input_l = round(d_input_l / 16) * 16;
	d_input_r = round(d_input_r / 16) * 16;
	toc
	%%=========================================EMBED END=======================================
	
	tic
	matlabpool open local 8
%ii=4;	
	parfor (ii= 1:8)
		output = wm_extract(ii, f_input_l, f_input_r, d_input_l, d_input_r, blockSize, wmKey, watermarkSize, W, source);
	end

	matlabpool close
	toc

%{
	[status,resultStr]= system(VSRSString_v4);

	tmpYUV = loadYUV('dancer_syn_tmp.yuv',1920,1088);
	I2 = rgb2ycbcr(tmpYUV);
	I2 = I2(:,:,1);
	toc
	tic
	[f_syn , d_syn ]= vl_sift(single(I2));
	toc
	tic
	%d_input = round(d_input / 16)*16;
	
	[ disparityTable_l ] = SIFT_disparity( d_syn,d_input_l,f_syn,f_input_l );
	[ disparityTable_r ] = SIFT_disparity( d_syn,d_input_r,f_syn,f_input_r );
	toc
	tic
	csvwrite('disparity_l.tmp',disparityTable_l');
	tmpStr = strcat('./disparitymap_nn disparity_l.tmp',{' '},num2str(length(disparityTable_l)),' 1088 1920');
	systemStr = tmpStr{1,1};
	system(systemStr);
	disparityMap_l = csvread('nn_disparity_map.tmp');
	toc
	
	tic
	csvwrite('disparity_r.tmp',disparityTable_r');
	tmpStr = strcat('./disparitymap_nn disparity_r.tmp',{' '},num2str(length(disparityTable_r)),' 1088 1920');
	systemStr = tmpStr{1,1};
	system(systemStr);
	disparityMap_r = csvread('nn_disparity_map.tmp');
	toc
%	tic	
%	[ disparityMap_l ] = disparitymap_nn( disparityTable_l , inputHeight , inputWidth );
%	toc
%	[ disparityMap_r ] = disparitymap_nn( disparityTable_r , inputHeight , inputWidth );
	
	tic
	normL = norm(reshape(disparityMap_l,1,[]).*reshape(disparityMap_l,1,[]));
	normR = norm(reshape(disparityMap_r,1,[]).*reshape(disparityMap_r,1,[]));
		        
	if normL < normR
		newImage = recoverDisparityMap( disparityMap_l , I2 );
	else
		newImage = recoverDisparityMap( disparityMap_r , I2 );
	end

	[ extracted ] = ISSExtract( newImage, blockSize,wmKey,watermarkSize );
	BER = norm((W-extracted)/2,1) / watermarkSize;
	%fprintf(1,'BER=%f PSNR=%f SSIM=%f err=%f\n',BER,PSNR(double(original_I_L)/255,double(newImage)/255),ssim((original_I_L),newImage),err);
	output = BER;
	toc
%}
	system('rm -f *.yuv *.tmp');
end


