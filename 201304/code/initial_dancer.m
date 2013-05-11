% input view = 3 & 5
% virtual view = 8
% modify parameter VirtualCameraName
[status,resultStr]= system('ViewSynVC7.exe ../data/dancer/config/VSRS/vsrs_dancer_ori.cfg');
inputWidth = 1920;
inputHeight = 1088;

oriImage = loadYUV('dancer_syn_ori.yuv',1920,1088);
oriImage = rgb2ycbcr(oriImage);
oriImage = oriImage(:,:,1);

%VSRS的cfg是寫死的, 所以需要4個cfg檔案, 裡面只有檔案io的路徑不同
vsrsCfgPath = '../data/dancer/config/VSRS/vsrs_dancer_matlab.cfg';
vsrsCfg2Path = '../data/dancer/config/VSRS/vsrs_dancer_matlab2.cfg';
vsrsCfgWMPath = '../data/dancer/config/VSRS/vsrs_dancer_matlab_WMGeneration.cfg';
%load initial data

original_I_L = loadYUV('../data/dancer/dancer_ori_I_l.yuv',1920,1088);
original_I_L_ycbcr = rgb2ycbcr(original_I_L);
original_I_L = original_I_L_ycbcr(:,:,1);

original_I_R = loadYUV('../data/dancer/dancer_ori_I_r.yuv',1920,1088);
original_I_R_ycbcr = rgb2ycbcr(original_I_R);
original_I_R = original_I_R_ycbcr(:,:,1);

original_D_L = loadYUV('../data/dancer/dancer_ori_D_l.yuv',1920,1088);
original_D_L_ycbcr = rgb2ycbcr(original_D_L);
original_D_L = original_D_L_ycbcr(:,:,1);

original_D_R = loadYUV('../data/dancer/dancer_ori_D_r.yuv',1920,1088);
original_D_R_ycbcr = rgb2ycbcr(original_D_R);
original_D_R = original_D_R_ycbcr(:,:,1);


%camera parameters
A_L = [ 2302.852541609168 ,   0.0 ,   960.0   ;
    0.0             ,   2302.852541609168   ,   540.0   ;
    0.0             ,   0.0 , 1.0];
R_L = [ 1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1];
A_R = [ 2302.852541609168 ,   0.0 ,   960.0   ;
    0.0             ,   2302.852541609168   ,   540.0   ;
    0.0             ,   0.0 , 1.0];
R_R = [ 1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1];
T_L = [ -40 ; 0 ;  0];
T_R = [ 0 ; 0 ; 0];

A_syn = [2302.852541609168 ,   0.0 ,   960.0   ;
    0.0             ,   2302.852541609168   ,   540.0   ;
    0.0             ,   0.0 , 1.0  ];
R_syn = [1 , 0 , 0;
    0 , 1 , 0;
    0 , 0 , 1  ];
T_syn = [-20 ; 0 ;  0];

Z_near = 2289;
Z_far = 213500;

%要改的: io路徑, baseviewcameranumbers, camara parameter, cfg
% %initial compression
HTMString_I_L = strcat(' --InputFile_0=tmp_I_l.yuv --DepthInputFile_0=../data/dancer/dancer_ori_D_l.yuv  --ReconFile_0=tmp_I_recon_l.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
HTMString_I_R = strcat(' --InputFile_0=tmp_I_r.yuv --DepthInputFile_0=../data/dancer/dancer_ori_D_r.yuv  --ReconFile_0=tmp_I_recon_r.yuv --BaseViewCameraNumbers=5 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
%HTMString_D_L = strcat(' --InputFile_0=../data/dancer/dancer_ori_D_l.yuv --DepthInputFile_0=../data/dancer/dancer_ori_D_l.yuv  --ReconFile_0=tmp_D_recon_l.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
%HTMString_D_R = strcat(' --InputFile_0=../data/dancer/dancer_ori_D_r.yuv --DepthInputFile_0=../data/dancer/dancer_ori_D_r.yuv  --ReconFile_0=tmp_D_recon_r.yuv --BaseViewCameraNumbers=5 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');

% second compression
% HTMString2_I_L = strcat(' --InputFile_0=embed_I_l.yuv --DepthInputFile_0=embed_I_l.yuv  --ReconFile_0=embed_I_recon_l.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
% HTMString2_I_R = strcat(' --InputFile_0=embed_I_r.yuv --DepthInputFile_0=embed_I_r.yuv  --ReconFile_0=embed_I_recon_r.yuv --BaseViewCameraNumbers=5 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
% HTMString2_D_L = strcat(' --InputFile_0=embed_D_l.yuv --DepthInputFile_0=embed_D_l.yuv  --ReconFile_0=embed_D_recon_l.yuv --BaseViewCameraNumbers=3 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
% HTMString2_D_R = strcat(' --InputFile_0=embed_D_r.yuv --DepthInputFile_0=embed_D_r.yuv  --ReconFile_0=embed_D_recon_r.yuv --BaseViewCameraNumbers=5 --CameraParameterFile=../data/dancer/config/HTM/cam_HTM_dancer.cfg -c ../data/dancer/config/HTM/HTM_cfg_dancer.cfg');
VSRSString = 'ViewSynVC7.exe vsrs_dancer_tmp.cfg';
VSRSName = 'dancer_syn_tmp.yuv';