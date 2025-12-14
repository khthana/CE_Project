<?php
class category
{
	var $callname;
	var $cat;
function setvar()
{
	$this->cat[0]=array(100,200,300,400,500);
	$this->callname[100]="a ->";
		$cat[100]=array(110,120,130,140);
			$callname[110]="a1 ->";
				$cat[110]=array(111,112,113,114,115);
					$callname[111]="1a1";
					$callname[112]="1a2";
					$callname[113]="1a3";
					$callname[114]="1a4";
					$callname[115]="1a5";
			$callname[120]="a2";
			$callname[130]="a3";
			$callname[140]="a4 ->";
				$cat[140]=array(141,142,143,144,145);
					$callname[141]="4a1";
					$callname[142]="4a2";
					$callname[143]="4a3";
					$callname[144]="4a4";
				  	$callname[145]="4a5";
	$callname[200]="b ->";
		$cat[200]=array(210,220,230,240,250);
			$callname[210]="b1 ->";
				$cat[210]=array(211,212,213,214,215);
					$callname[211]="1b1";
					$callname[212]="1b2";
					$callname[213]="1b3";
					$callname[214]="1b4";
					$callname[215]="1b5";
			$callname[220]="b2 ->";
				$cat[220]=array(221,222,223,224,225);
					$callname[221]="2b1";
					$callname[222]="2b2";
					$callname[223]="2b3";
					$callname[224]="2b4";
					$callname[225]="2b5";
			$callname[230]="b3";
			$callname[240]="b4";
			$callname[250]="b5";
	$callname[300]="c";
	$callname[400]="d";
	$callname[500]="e";
}
}//class
?>
