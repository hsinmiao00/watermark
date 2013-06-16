% input view = 5 & 7
% virtual view = 0
% modify parameter VirtualCameraName
%[status,resultStr]= system('ViewSynVC7.exe ../data/balloons/config/VSRS/vsrs_balloons_ori.cfg');
inputWidth = 1024;
inputHeight = 768;

%oriImage = loadYUV('balloons_syn_ori.yuv',inputWidth,inputHeight);
%oriImage = rgb2ycbcr(oriImage);
%oriImage = oriImage(:,:,1);

%VSRS的cfg是寫死的, 所以需要4個cfg檔案, 裡面只有檔案io的路徑不同
%vsrsCfgPath = '../data/balloons/config/VSRS/vsrs_balloons_matlab.cfg';
%vsrsCfg2Path = '../data/balloons/config/VSRS/vsrs_balloons_matlab2.cfg';
%vsrsCfgWMPath = '../data/balloons/config/VSRS/vsrs_balloons_matlab_WMGeneration.cfg';
%load initial data

original_I_L = loadYUV('./data/balloons/balloons_ori_I_1.yuv',inputWidth,inputHeight);
original_I_L_ycbcr = rgb2ycbcr(original_I_L);
original_I_L = original_I_L_ycbcr(:,:,1);

original_I_R = loadYUV('./data/balloons/balloons_ori_I_3.yuv',inputWidth,inputHeight);
original_I_R_ycbcr = rgb2ycbcr(original_I_R);
original_I_R = original_I_R_ycbcr(:,:,1);

original_D_L = loadYUV('./data/balloons/balloons_ori_D_1.yuv',inputWidth,inputHeight);
original_D_L_ycbcr = rgb2ycbcr(original_D_L);
original_D_L = original_D_L_ycbcr(:,:,1);

original_D_R = loadYUV('./data/balloons/balloons_ori_D_3.yuv',inputWidth,inputHeight);
original_D_R_ycbcr = rgb2ycbcr(original_D_R);
original_D_R = original_D_R_ycbcr(:,:,1);


%camera parameters
A_L = [ 2241.25607 ,   0.0 ,   701.5   ;
    0.0             ,   2241.25607   ,   514.5   ;
    0.0             ,   0.0 , 1.0];
R_L = [ 1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1];
A_R = [ 2241.25607 ,   0.0 ,   701.5   ;
    0.0             ,   2241.25607   ,   514.5   ;
    0.0             ,   0.0 , 1.0];
R_R = [ 1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1];
T_L = [ 5 ; 0 ;  0];
T_R = [ 15 ; 0 ; 0];

Z_near = 448.251214;
Z_far = 11206.280350;

A_syn = [ 2241.25607 ,   0.0 ,   701.5   ;
    0.0             ,   2241.25607   ,   514.5   ;
    0.0             ,   0.0 , 1.0];
R_syn = [ 1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1];
T_syn = [ 10 ; 0 ;  0];

%要改的: io路徑, baseviewcameranumbers, camara parameter, cfg
% %initial compression
HTMString_I_L = strcat(' --InputFile_0=tmp_I_l.yuv --DepthInputFile_0=../data/balloons/balloons_ori_D_1.yuv  --ReconFile_0=tmp_I_recon_l.yuv --BaseViewCameraNumbers=1 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
HTMString_I_R = strcat(' --InputFile_0=tmp_I_r.yuv --DepthInputFile_0=../data/balloons/balloons_ori_D_3.yuv  --ReconFile_0=tmp_I_recon_r.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% HTMString_D_L = strcat(' --InputFile_0=../data/balloons/balloons_ori_D_1.yuv --DepthInputFile_0=../data/balloons/balloons_ori_D_1.yuv  --ReconFile_0=tmp_D_recon_l.yuv --BaseViewCameraNumbers=1 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% HTMString_D_R = strcat(' --InputFile_0=../data/balloons/balloons_ori_D_3.yuv --DepthInputFile_0=../data/balloons/balloons_ori_D_3.yuv  --ReconFile_0=tmp_D_recon_r.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% 
% % second compression
% HTMString2_I_L = strcat(' --InputFile_0=embed_I_l.yuv --DepthInputFile_0=embed_I_l.yuv  --ReconFile_0=embed_I_recon_l.yuv --BaseViewCameraNumbers=1 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% HTMString2_I_R = strcat(' --InputFile_0=embed_I_r.yuv --DepthInputFile_0=embed_I_r.yuv  --ReconFile_0=embed_I_recon_r.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% HTMString2_D_L = strcat(' --InputFile_0=embed_D_l.yuv --DepthInputFile_0=embed_D_l.yuv  --ReconFile_0=embed_D_recon_l.yuv --BaseViewCameraNumbers=1 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');
% HTMString2_D_R = strcat(' --InputFile_0=embed_D_r.yuv --DepthInputFile_0=embed_D_r.yuv  --ReconFile_0=embed_D_recon_r.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/balloons/config/HTM/cam_balloons.cfg -c ../data/balloons/config/HTM/HTM_cfg_balloons.cfg');


VSRSString = cell(8,1);
VSRSString{1} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v1.cfg';
VSRSString{2} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v2.cfg';
VSRSString{3} = 'cp -f tmp_I_recon_l.yuv balloons_syn_v3.yuv';
VSRSString{4} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v4.cfg';
VSRSString{5} = 'cp -f tmp_I_recon_r.yuv balloons_syn_v5.yuv';
VSRSString{6} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v6.cfg';
VSRSString{7} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v7.cfg';
VSRSString{8} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v8.cfg';

VSRSStringOri = cell(8,1);
VSRSStringOri{1} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v1_ori.cfg';
VSRSStringOri{2} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v2_ori.cfg';
VSRSStringOri{3} = 'cp -f ./data/balloons/balloons_ori_I_1.yuv balloons_syn_v3.yuv';
VSRSStringOri{4} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v4_ori.cfg';
VSRSStringOri{5} = 'cp -f ./data/balloons/balloons_ori_I_3.yuv balloons_syn_v5.yuv';
VSRSStringOri{6} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v6_ori.cfg';
VSRSStringOri{7} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v7_ori.cfg';
VSRSStringOri{8} = './code/ViewSyn ./data/balloons/config/VSRS/vsrs_balloons_v8_ori.cfg';

VSRSName = cell(8,1);
VSRSName{1} = 'balloons_syn_v1.yuv';
VSRSName{2} = 'balloons_syn_v2.yuv';
VSRSName{3} = 'balloons_syn_v3.yuv';
VSRSName{4} = 'balloons_syn_v4.yuv';
VSRSName{5} = 'balloons_syn_v5.yuv';
VSRSName{6} = 'balloons_syn_v6.yuv';
VSRSName{7} = 'balloons_syn_v7.yuv';
VSRSName{8} = 'balloons_syn_v8.yuv';

disparityName = cell(8,1);
disparityName{1} = 'disparity_v1.tmp';
disparityName{2} = 'disparity_v2.tmp';
disparityName{3} = 'disparity_v3.tmp';
disparityName{4} = 'disparity_v4.tmp';
disparityName{5} = 'disparity_v5.tmp';
disparityName{6} = 'disparity_v6.tmp';
disparityName{7} = 'disparity_v7.tmp';
disparityName{8} = 'disparity_v8.tmp';

reconsName = cell(8,1);
reconsName{1} = 'recons_v1.tmp';
reconsName{2} = 'recons_v2.tmp';
reconsName{3} = 'recons_v3.tmp';
reconsName{4} = 'recons_v4.tmp';
reconsName{5} = 'recons_v5.tmp';
reconsName{6} = 'recons_v6.tmp';
reconsName{7} = 'recons_v7.tmp';
reconsName{8} = 'recons_v8.tmp';
