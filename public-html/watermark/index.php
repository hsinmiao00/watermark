<?php
//	echo "test!\n";


	$tmp = 0;
	$tmp = $_GET['strength'];
	echo $tmp.':';
	$tmp2 = $_GET['size'];
	echo $tmp2.':';
	$tmp3 = $_GET['iwm'];
	$tmp4 = $_GET['cover'];
	
	$cover = 0;
	if(strcmp($tmp4,'cover1')==0){
		$cover = 'dancer';
	}
	else if(strcmp($tmp4,'cover2')==0){
		$cover = 'poznanstreet';
	}
	else if(strcmp($tmp4,'cover3')==0){
		$cover = 'poznanhall';
	}
	else if(strcmp($tmp4,'cover4')==0){
		$cover = 'balloons';
	}
//	echo $tmp3.':';
	/*
	$command = "matlab -nojvm -nodesktop -nodisplay -r \"out=test1(".$tmp.");fprintf(1,'%d',out);exit\"";
	$output = exec($command,$output2);
	echo($output);
	echo "<br />";
	print_r($output2[13]);
	echo "=======================<br />";
*/



//=========================WATERMARK EXECUTION============================
	system('rm -f *.jpg');
	$command = "matlab -nodesktop -nodisplay -r \"out = wm('".$cover."','".$tmp3.".bmp',".$tmp.",".$tmp2.");exit\"";
	$output = exec($command,$output3,$status);
	//system($command);
	//print_r($output);
	//echo '<br /><br/>';
	//print_r($output3);
	for($i=29;$i<=36;$i++){
		echo $output3[$i].'|';
	}
	//print_r($status);
//=======================================================================


/*
	$wmStrPre = "wm";
	$wmStrPost = ".jpg";
	for( $i=1;$i<=8;$i++ ){	
		echo '<img width="480px" src="'.$i.'.jpg">';
		echo '<img width="180px" src="wm'.$i.'.jpg">';
		echo '<br />';
	}
	*/


?>
