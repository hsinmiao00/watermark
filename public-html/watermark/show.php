
<!doctype html>
<html lang="us">
<head>
<meta charset="utf-8">
<title>watermark</title>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="css/bjqs.css">
<link rel="stylesheet" href="css/use.css">

<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
<script src="js/jquery.tools2.js"></script>
<script src="js/bjqs-1.3.min.js"></script>
<script type='text/javascript' src='js/jquery.loadmask.js'></script>
<!--<script src="http://cdn.jquerytools.org/1.2.7/all/jquery.tools.min.js"></script>-->
<script>
$(document).ready(function() {
var wmSelected = 0;
var iwmStr = 0;
		$( "#button" ).button();
		$("#navigator").scrollable().navigator();
		$('#banner-fade').bjqs({height: 544,width: 960,responsive  : true,automatic : false,showcontrols : true});
		$( "#radioset" ).buttonset();

		$( "#slider" ).slider({ value: 8, min: 1, max: 15, step: 0.1, slide: function( event, ui ) { $( "#amount" ).val( ui.value );}});
		$( "#amount" ).val(  $( "#slider" ).slider( "value" ) );

		$( "#progressbar" ).progressbar({ value: 20 });
$( "#slider2" ).slider({value: 50,min: 5,max: 200,step: 1,slide: function( event, ui ) {$( "#amount2" ).val( ui.value );}});
$( "#amount2" ).val(  $( "#slider2" ).slider( "value" ) );

$(".iwm").click(function (){

	iwmStr = this.alt.toString();
	if(iwmStr=='wm2'){
		$("#iwm2").css('border', "solid 2px");
		$("#iwm3").css('border', "0px");
		wmSelected = 1;
		$('#msg').html(iwmStr);
	}
	else if(iwmStr=='wm3'){
		$("#iwm3").css('border', "solid 2px");
		$("#iwm2").css('border', "0px");
		wmSelected = 1;
		$('#msg').html(456);
	}
});


$("#button").click(function (){
		if(iwmStr==0){
			alert("Please choose a watermark image");
		}
		else{
		$("#container").mask("Waiting...");
		$.ajax({
url: 'index.php',
cache: false,
dataType: 'html',
type:'GET',
data: { strength: $("#amount").val() ,size: $("#amount2").val() ,iwm: iwmStr },
error: function(xhr) {
alert('Ajax request ?o????~');
},
success: function(response) {
$('#msg').html( response );
var tmpStr =  response.toString() ;
var tmpStr1 = tmpStr.split(':');
tmpStr1 = tmpStr1[2];
var tmpStr2 = tmpStr1.split(',');
//$('#msg').html( tmpStr2 );
$('#msg').fadeIn();



d = new Date();
$("#wm1").attr('src', 'wm1.jpg?'+d.getTime());$("#im1").attr('src', '1.jpg?'+d.getTime());$('#ber1').html( 'View: 1<br />'+tmpStr2[0]+'%' );$('#msg1').fadeIn();$("#wm2").attr('src', 'wm2.jpg?'+d.getTime());$("#im2").attr('src', '2.jpg?'+d.getTime());$('#ber2').html( 'View: 2<br />'+tmpStr2[1]+'%' );$('#msg2').fadeIn();$("#wm3").attr('src', 'wm3.jpg?'+d.getTime());$("#im3").attr('src', '3.jpg?'+d.getTime());$('#ber3').html( 'View: 3<br />'+tmpStr2[2]+'%' );$('#msg3').fadeIn();$("#wm4").attr('src', 'wm4.jpg?'+d.getTime());$("#im4").attr('src', '4.jpg?'+d.getTime());$('#ber4').html( 'View: 4<br />'+tmpStr2[3]+'%' );$('#msg4').fadeIn();$("#wm5").attr('src', 'wm5.jpg?'+d.getTime());$("#im5").attr('src', '5.jpg?'+d.getTime());$('#ber5').html( 'View: 5<br />'+tmpStr2[4]+'%' );$('#msg5').fadeIn();$("#wm6").attr('src', 'wm6.jpg?'+d.getTime());$("#im6").attr('src', '6.jpg?'+d.getTime());$('#ber6').html( 'View: 6<br />'+tmpStr2[5]+'%' );$('#msg6').fadeIn();$("#wm7").attr('src', 'wm7.jpg?'+d.getTime());$("#im7").attr('src', '7.jpg?'+d.getTime());$('#ber7').html( 'View: 7<br />'+tmpStr2[6]+'%' );$('#msg7').fadeIn();$("#wm8").attr('src', 'wm8.jpg?'+d.getTime());$("#im8").attr('src', '8.jpg?'+d.getTime());$('#ber8').html( 'View: 8<br />'+tmpStr2[7]+'%' );$('#msg8').fadeIn();
	//$("#wm1").attr('src', 'wm1.jpg?'+d.getTime());
	$("#container").unmask();
		wmSelected = 0;
	 }

});

}

});


});

</script>

</head>
<body>

<div id="container" style=" width:90%; margin-left:5%; margin-right:5%">

<h1>Watermark DEMO</h1>

<div id="left" style="width:20%; float:left;">
<h2>Input Parameters</h2>
<!-- Button -->

<h3 class="demoHeaders">Watermark Image</h3>
<div><img src="wm2.bmp" alt="wm2" class="iwm" id="iwm2" style="width:35%"><img src="wm3.bmp" alt="wm3" class="iwm" id="iwm3" style="margin-left: 20%;width:35%"></div>


<!-- Slider -->
<h3 class="demoHeaders">Watermark Strength</h3>
<div id="slider"></div>
<input type="text" id="amount" style="border: 0; color: #f6931f; font-weight: bold; font-size:18px"/>

<h3 class="demoHeaders">Side Information Size</h3>
<div id="slider2"></div>
<input type="text" id="amount2" style="border: 0; color: #f6931f; font-weight: bold; font-size:18px; width:35px;" /><b style="font-size:18px">kB</b>


<!-- Progressbar 
<h2 class="demoHeaders">Progressbar</h2>
<div id="progressbar"></div>
-->
<h3 class="demoHeaders">Button</h3>
<button id="button">Embed and Extract</button>


<div id="msg"> </div>


</div><!-- en of left  -->

<div id="right" style="width:75%; float:right; margin-left:5%;">
<h2>Image and Extracted Watermark</h2>




<div id="banner-fade">

<!-- start Basic Jquery Slider -->
<ul class="bjqs">
<?php
$wmStrPre = "wm";
$wmStrPost = ".jpg";
for( $i=1;$i<=8;$i++ ){
	echo '<li><img src="'.$i.'.jpg" id="im'.$i.'" title="View'.$i.'"></li>';
	}

	?>
</ul>
<!-- end Basic jQuery Slider -->

</div>
<!-- End outer wrapper -->



<?php
for( $i=1;$i<=8;$i++ ){
	echo '<div style="float:left"><img src="wm'.$i.'.jpg" id="wm'.$i.'" style="width:120px;"/><br /><p id="ber'.$i.'" style="font-size:20px;">View:'.$i.'</p></div>';
	}

	?>

</div>
</div> <!--  -right  end -->


</div>

</body>
</html>
