<?php
class next_price
{
function get_next_price($now_price){
if (($now_price>0)&&($now_price<50))
{
		$minprice = $now_price+5;
}
elseif (($now_price>49)&&($now_price<300))
{
                $minprice = $now_price+10;
}
elseif (($now_price>299)&&($now_price<1000))
{
                $minprice = $now_price+50;
}
elseif ($now_price>999)
{
                $minprice = $now_price+100;
}
return $minprice;
}// end get_next_price
}// end next_price
?>
