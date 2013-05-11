peakThreshold = [5,7,9,11,13,15];
blockSize = 16;
patternLength = 100;

for i = 1 : length(peakThreshold)
[f_syn , d_syn ]= vl_sift(single(oriImage), 'PeakThresh', peakThreshold(i)) ;
[f_input , d_input ]= vl_sift(single(original_I_L), 'PeakThresh', peakThreshold(i)) ;

[ disparityTable ] = SIFT_disparity( d_syn,d_input,f_syn,f_input );
[ disparityMap ] = disparitymap_nn( disparityTable , 1088 , 1920 );
DIBR_watermark_test();

%length(f_syn)
%length(f_input)
%length(disparityTable)
end