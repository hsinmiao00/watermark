<?php
//	echo "test!\n";


	$tmp = 0;
	//strength of watermark (alpha in ISS)
	$tmp = $_GET['strength'];
	echo $tmp.':';

	//side information size
	$tmp2 = $_GET['size'];
	echo $tmp2.':';

	//which watermark(bmpfile)
	$tmp3 = $_GET['iwm'];

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
	$command = "matlab -nodesktop -nodisplay -r \"out = wm('dancer','".$tmp3.".bmp',".$tmp.",".$tmp2.");exit\"";
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
