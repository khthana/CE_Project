<?php

class bid_item
{

function display_detail($id,$title,$category,$description,$picture,$quantity,
        $start_bid,$auction_type,$start_date,$stop_date,$owner,$payment,
        $shipping,$now_price,$num_bid,$location,$rating,$highest_bidder)

{                       
echo"
<p><font size='+2' color='#339900'><U><b><font size='+3'>Preview Post
item</font></b></u></font></p>
<table width='100%' border='0' height='895'>
  <tr bgcolor='#FFCC99'> 
    <td> 
      <table width='100%' border='0' height='68'>
        <tr bgcolor='#CC66FF'> 
          <td height='31'> 
            <div align='center'> <b><font
color='#FFFF66'>$title</font></b> </div>
          </td>
        </tr>
        <tr bgcolor='#9999FF'> 
          <td height='29'> 
            <div align='center'> <b><font
color='#99FF00'>Item id = $id</font></b> </div>
          </td>
        </tr>
      </table>
      <table width='100%' border='0' bgcolor='#FFCC99' height='303'>
        <tr> 
          <td width='20%' height='31'> 
            <div align='right'><font color='#6600FF'>currently price 
:</font></div>
          </td>
          <td width='4%' height='31'>&nbsp;</td>
          <td width='17%' height='31'><font
color='#FF3300'>$now_price</font></td>
          <td width='26%' height='31'> 
            <div align='right'><font color='#6300FF'>first bid :</font></div>
          </td>
          <td width='3%' height='31'>&nbsp;</td>
          <td width='30%' height='31'><font
color='#FF3300'>$star_bid</font></td>
        </tr>
        <tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'>quantity :</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='17%' height='29'><font
color='#FF3300'>$quantity</font></td>
          <td width='26%' height='29'> 
            <div align='right'><font color='#6300FF'>number of bid :</font></div>
          </td>
          <td width='3%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$num_bid</font></td>
        </tr>
        <tr> 
          <td width='20%' height='19'> 
            <div align='right'><font color='#6600FF'>started :</font></div>
          </td>
          <td width='4%' height='19'>&nbsp;</td>
          <td width='17%' height='19'><font
color='#FF3300'>$start_date</font></td>
          <td width='26%' height='19'> 
            <div align='right'></div>
          </td>
          <td width='3%' height='19'>&nbsp;</td>
          <td width='30%' height='19'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%'> 
            <div align='right'><font color='#6600FF'>end :</font></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'><font color='#FF3300'>$stop_date</font></td>
          <td width='26%'> 
            <div align='right'></div>
          </td>
          <td width='3%'>&nbsp;</td>
          <td width='30%'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%'> 
            <div align='right'></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'>&nbsp;</td>
          <td width='26%'> 
            <div align='right'></div>
          </td>
          <td width='3%'>&nbsp;</td>
          <td width='30%'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%' height='21'> 
            <div align='right'><font color='#6600FF'><font color='#6600FF'>seller 
              :</font></font></div>
          </td>
          <td width='4%' height='21'>&nbsp;</td>
          <td width='17%' height='21'><font
color='#FF3300'>$owner</font></td>
          <td width='26%' height='21'> 
            <div align='right'></div>
          </td>
          <td width='3%' height='21'>&nbsp;</td>
          <td width='30%' height='21'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%'> 
            <div align='right'><font color='#6600FF'><font color='#6600FF'><font color='#6600FF'>payment</font> 
              :</font></font></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'><font color='#FF3300'>$payment</font></td>
          <td width='26%'> 
            <div align='right'></div>
          </td>
          <td width='3%'>&nbsp;</td>
          <td width='30%'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%'> 
            <div align='right'><font color='#6600FF'><font color='#6600FF'>shipping 
              :</font></font></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'><font color='#FF3300'>$shipping</font></td>
          <td width='26%'> 
            <div align='right'></div>
          </td>
          <td width='3%'>&nbsp;</td>
          <td width='30%'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%'> 
            <div align='right'><font color='#6600FF'><font color='#6600FF'><font color='#6600FF'>high 
              bider :</font> </font></font></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'><font
color='#FF3300'>$nickname_bider</font></td>
          <td width='26%'> 
            <div align='right'></div>
          </td>
          <td width='3%'>&nbsp;</td>
          <td width='30%'>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor='#FFCC99'> 
    <td height='192'> 
      <table width='100%' border='0' height='31'>
        <tr bgcolor='#CE65FF'> 
          <td height='31'> 
            <div align='center'> <font color='#FFFF66'>Description</font> </div>
          </td>
        </tr>
      </table>
      <p align='center'><font color='#000000'>$description</font></p>
      <p align='center'>&nbsp;</p>
    </td>
  </tr>
  <tr bgcolor='#FFCC99'> 
    <td> 
      <table width='100%' border='0' height='34'>
        <tr bgcolor='#CE65FF'> 
          <td> 
            <div align='center'> <font color='#FFFF63'>Bidding</font> </div>
          </td>
        </tr>
      </table>
      </form>
      <p><br>
      </p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
    </td>
  </tr>
</table>";
}
}
?>
