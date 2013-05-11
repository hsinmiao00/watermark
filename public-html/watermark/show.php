
<!doctype html>
<html lang="us">
<head>
<meta charset="utf-8">
<title>watermark</title>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="css/bjqs.css">

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
<?php	
	for($i=1;$i<=8;$i++){
		echo '$("#wm'.$i.'").attr(\'src\', \'wm'.$i.'.jpg?\'+d.getTime());';
		echo '$("#im'.$i.'").attr(\'src\', \''.$i.'.jpg?\'+d.getTime());';
		echo 'var tmpStr3 = tmpStr2['.($i-1).'].split(\',\')';
				echo '$(\'#ber'.$i.'\').html( \'View: '.$i.'<br />\'+tmpStr3[0]+\'%\')' ;
					echo '$(\'#msg'.$i.'\').fadeIn();';
					}
					?>
					//$("#wm1").attr('src', 'wm1.jpg?'+d.getTime());
					$("#container").unmask();
					wmSelected = 0;
					}

					});

				}

				});


});

/*
   $(document).ready(function() {
// initialize scrollable together with the autoscroll plugin
$("#scrollable").scrollable().autoscroll(2000000);
// $("#scrollable").scrollable();
// provide scrollable API for the action buttons
window.api = root.data("scrollable");
api.stop();
});
 */

</script>
<style>
body{
font: 62.5% "Trebuchet MS", sans-serif;
margin: 50px;
}
h1 {
color: #000;
       font-size: 35px;
}

h2 {
color: #000;
       font-size: 27px;
       letter-spacing: 0px;
       font-weight: normal;
padding: 0 0 5px;
margin: 0;
}
h3 {

	font-size: 20px;
}

.demoHeaders {
	margin-top: 2em;
}
#dialog-link {
padding: .4em 1em .4em 20px;
	 text-decoration: none;
position: relative;
}
#dialog-link span.ui-icon {
margin: 0 5px 0 0;
position: absolute;
left: .2em;
top: 50%;
     margin-top: -8px;
}
#icons {
margin: 0;
padding: 0;
}
#icons li {
margin: 2px;
position: relative;
padding: 4px 0;
cursor: pointer;
float: left;
       list-style: none;
}
#icons span.ui-icon {
float: left;
margin: 0 4px;
}
.fakewindowcontain .ui-widget-overlay {
position: absolute;
}



.scrollable { position:relative; overflow:hidden; width: 200px; height: 102px;} 
.scrollable .items { width: 20000em; position:absolute;}
.scrollable .items div { float:left;} 
.scrollable .items .item { overflow:hidden;}

.navi { width:auto; height:20px;  margin:5px 0; padding-left: 35%;} 
.navi a { width: 20px; cursor:pointer; height: 20px; float:left; margin:0 0 0 3px; background:url(webim/opencircle.png) no-repeat scroll top; display:block; font-size:1px;} 
.navi a:hover, .navi a.active { background-position:left top; margin:0 0 0 3px;  background:url(webim/closedcircle.png) no-repeat scroll top}


#banner-fade,
#banner-slide{
	margin-bottom: 60px;
}

ul.bjqs-controls.v-centered li a{
display:block;
padding:10px;
background:#fff;
color:#000;
      text-decoration: none;
}

ul.bjqs-controls.v-centered li a:hover{
background:#000;
color:#fff;
}

ol.bjqs-markers li a{
padding:5px 10px;
background:#000;
color:#fff;
margin:5px;
       text-decoration: none;
}

ol.bjqs-markers li.active-marker a,
	ol.bjqs-markers li a:hover{
background: #999;
	}

p.bjqs-caption{
background: rgba(255,255,255,0.5);
	    font-size: 16px;
}


.loadmask {
	z-index: 100;
position: absolute;
top:0;
left:0;
     -moz-opacity: 0.5;
opacity: .50;
filter: alpha(opacity=50);
	background-color: #CCC;
width: 100%;
height: 100%;
zoom: 1;
}
.loadmask-msg {
	z-index: 20001;
position: absolute;
top: 0;
left: 0;
border:1px solid #6593cf;
background: #c3daf9;
padding:2px;
}
.loadmask-msg div {
padding:5px 10px 5px 25px;
background: #fbfbfb url('webim/loading.gif') no-repeat 5px 5px;
	    line-height: 16px;
border:1px solid #a3bad9;
color:#222;
font:normal 20px tahoma, arial, helvetica, sans-serif;
cursor:wait;
}
.masked {
overflow: hidden !important;
}
.masked-relative {
position: relative !important;
}
.masked-hidden {
visibility: hidden !important;
}

</style>
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

<li><img src="1.jpg" id="im1" title="View1"></li><li><img src="2.jpg" id="im2" title="View2"></li><li><img src="3.jpg" id="im3" title="View3"></li><li><img src="4.jpg" id="im4" title="View4"></li><li><img src="5.jpg" id="im5" title="View5"></li><li><img src="6.jpg" id="im6" title="View6"></li><li><img src="7.jpg" id="im7" title="View7"></li><li><img src="8.jpg" id="im8" title="View8"></li></ul>
<!-- end Basic jQuery Slider -->

</div>
<!-- End outer wrapper -->

<script class="secret-source">
jQuery(document).ready(function($) {

		$('#banner-fade').bjqs({
height      : 544,
width       : 960,
responsive  : true,
automatic : false,
showcontrols : true
});

		});
</script>


<!--
<div class="scrollable" id="navigator">
<div class="items">
-->
<div style="float:left"><img src="wm1.jpg" id="wm1" style="width:120px;"/><br /><p id="ber1" style="font-size:20px;">View:1</p></div><div style="float:left"><img src="wm2.jpg" id="wm2" style="width:120px;"/><br /><p id="ber2" style="font-size:20px;">View:2</p></div><div style="float:left"><img src="wm3.jpg" id="wm3" style="width:120px;"/><br /><p id="ber3" style="font-size:20px;">View:3</p></div><div style="float:left"><img src="wm4.jpg" id="wm4" style="width:120px;"/><br /><p id="ber4" style="font-size:20px;">View:4</p></div><div style="float:left"><img src="wm5.jpg" id="wm5" style="width:120px;"/><br /><p id="ber5" style="font-size:20px;">View:5</p></div><div style="float:left"><img src="wm6.jpg" id="wm6" style="width:120px;"/><br /><p id="ber6" style="font-size:20px;">View:6</p></div><div style="float:left"><img src="wm7.jpg" id="wm7" style="width:120px;"/><br /><p id="ber7" style="font-size:20px;">View:7</p></div><div style="float:left"><img src="wm8.jpg" id="wm8" style="width:120px;"/><br /><p id="ber8" style="font-size:20px;">View:8</p></div><!--
</div> 
</div>
<div class="navi"></div>
-->

</div>
</div> <!--  -right  end -->

<script  language="JavaScript">
$(function() {
		// initialize scrollable
		$("#navigator").scrollable().navigator();

		});
</script>

</div>

</body>
</html>
