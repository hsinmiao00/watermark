imwrite(I2,'syn_image.pgm','pgm');
system('./include/chog-release -m 1 -c syn_image.pgm feature.bin');
system('./include/chog-release -d feature.bin feature_syn.ascii');
dirLs = dir('feature.bin');
dirLs.bytes

imwrite(original_I_L,'ori_image.pgm','pgm');
system('./include/chog-release -m 1 -c ori_image.pgm feature.bin');
system('./include/chog-release -d feature.bin feature_ori.ascii');
dirLs = dir('feature.bin');
dirLs.bytes

chogSyn = importdata('feature_syn.ascii');
chogOri = importdata('feature_ori.ascii');