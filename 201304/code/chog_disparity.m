function [ output ] = chog_disparity( synImage, oriImage )
%CHOG_DISPARITY Summary of this function goes here
%   Detailed explanation goes here
imwrite(synImage,'syn_image.pgm','pgm');
system('./include/chog-release -m 3 -c syn_image.pgm feature.bin');
system('./include/chog-release -d feature.bin feature_syn.ascii');
dirLs = dir('feature.bin');
dirLs.bytes

imwrite(oriImage,'ori_image.pgm','pgm');
system('./include/chog-release -m 3 -c ori_image.pgm feature.bin');
system('./include/chog-release -d feature.bin feature_ori.ascii');
dirLs = dir('feature.bin');
dirLs.bytes

chogSyn = importdata('feature_syn.ascii');
chogOri = importdata('feature_ori.ascii');

chogSize = size(chogOri);
fChogSyn = chogSyn(:,6:chogSize(2))';
fChogOri = chogOri(:,6:chogSize(2))';

[matches, scores] = vl_ubcmatch(fChogSyn, fChogOri) ;

output = [];
maxDisparity = 80;
maxScore = 0.2;
verticalThreshold = 3;

for i = 1 : length(matches)
    synIndex = matches(1,i);
    inputIndex = matches(2,i);
    
    tmp=zeros(3,1);
    tmp(1:2) = chogSyn(synIndex,1:2);
    tmp(3) = chogOri(inputIndex,1) - chogSyn(synIndex,1);
    
    if abs(tmp(3)) < maxDisparity && scores(i) < maxScore &&  abs(chogOri(inputIndex,2)- chogSyn(synIndex,2))<verticalThreshold
        output = [output,tmp];
    end
end


end
