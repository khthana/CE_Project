<?php
echo "
<html>
<body bgcolor='#FFFFFF' text='#3333ff'>
<center><h2><font color='#ff333'>ค้นหาจาก ชื่อสินค้า</font></h2></center>
<form action='http://161.246.5.146/auction1/search/result.php3'
method=post>
<table width='100%' border='1' height='420'>
  <tr>
    <td height='400'> 
      <center>
        <table width='100%' height='300' bgcolor='#ffffcc'>
          <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>ชื่อสินค้า: </b></div>
            </td>
            <td width='57%' height='34'>
              <input type='hidden' name='search_type' value='title' >
              <input type='text' name='title'>
            </td>
          </tr>

         <tr> 
            <td width='43%' height='34'> 
            </td>
            <td width='57%' height='34'>
               <input type='radio' name='descrip' value=0 checked>
              <font color='#00009C'>จากชื่อสินค้า </font>
               <input type='radio' name='descrip' value=1>
              <font color='#00009C'>จากชื่อสินค้าและรายละเยียดสินค้า 
</font> 
          </tr>

         <tr> 
            <td width='43%' height='34'>
              <div align='right'><b>สินค้า :</b> </div>
            </td>
            <td width='57%' height='34'>
               <select name='status'>
  <option value='0' selected>ทั้งหมด</option>
  <option value='1'>ยังไม่ปิดประมูล</option>
  <option value='2'>ปิดประมูลแล้ว 1 วัน</option>
  <option value='3'>ปิดประมูลแล้ว 2 วัน</option>
  <option value='4'>ปิดประมูลแล้ว 1 สัปดาห์</option>
  <option value='5'>ปิดประมูลแล้ว 2 สัปดาห์</option>
</select> 
          </tr>

	   <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>ประเภทสินค้า : </b></div>
            </td>
            <td width='57%' height='34'> 
              <select name='category'>
		<option value=''>ทุกประเภท</option>
                <option value='01'>ของโบราณ</option>
                <option value='03'>เพลงและภาพยนต์</option>
                <option value='05'>คอมพิวเตอร์</option>
                <option value='07'>อิเล็กทรอนิกส์</option>
                <option value='09'>กล้องถ่ายรูป</option>
                <option value='11'>เครื่องประดับ</option>
                <option value='13'>เฟอร์นิเจอร์</option>
                <option value='15'>บ้านและที่ดิน</option>
                <option value='02'>หนังสือ</option>
                <option value='04'>ของสะสม</option>
                <option value='06'>ของเล่น</option>
                <option value='08'>อุปกรณ์สื่อสาร</option>
                <option value='10'>อุปกรณ์กิฬา</option>
                <option value='12'>เสื้อผ้า</option>
                <option value='14'>ยานพาหนะ</option>
                <option value='16'>อื่น ๆ</option>  
              </select>
            </td>
          </tr>

          <tr>
            <td width='43%' height='34'>
              <div align='right'><b>ชนิดการประมูล : </b></div>
            </td>
            <td width='57%' height='34'>
              <select name='auction_type'>
                <option value='0' selected>ทั้งหมด</option>
                <option value='1'>Normal auction</option>
                <option value='2'>Reserveprice auction</option>
                <option value='3'>Duch auction</option>
              </select>
            </td>
          </tr>    

          <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>ช่วงราคา : </b></div>
            </td>
            <td width='57%' height='34'> <font color='#000099'>ระหว่าง
	      <select name='minprice'>	 
                <option value='0' selected>0</option>
                <option value='100' >100</option> 
                <option value='500' >500</option>
                <option value='1000' >1,000</option> 
                <option value='5000' >5,000</option>
                <option value='10000' >10,000</option>
                <option value='50000' >50,000</option>
                <option value='100000' >100,000</option>    
              </select>
              และ
	      <select name='maxprice'>
                <option value='100' >100</option>
                <option value='500' >500</option>
                <option value='1000' >1,000</option>
                <option value='5000' >5,000</option>
                <option value='10000' >10,000</option>
                <option value='50000' >50,000</option>
                <option value='100000' >100,000</option>
                <option value='999999999' selected >ไม่จำกัดราคา 
</option>     
              </select>
              บาท </font></td>
          </tr>

          <tr> 
            <td width='43%' height='32'> 
              <div align='right'><b>เรียงสินค้าโดย : </b></div>
            </td>
            <td width='57%' height='32'> 
              <select name='sort1'>
                <option value='now_pri' selected >ราคาปัจจุบัน</option>
                <option value='stop_date' >วันปิดประมูล</option>
                <option value='start_date' >วันเข้าประมูล</option>   
                <option value='item_id'>หมายเลขสินค้า</option>
                <option value='bid_num'>จำนวนผู้ประมูล</option> 
              </select>
		    </td>
          </tr>

         <tr> 
            <td width='43%' height='30'> 
            </td>
            <td width='57%' height='30'>
              <input type='radio' name='sort2' value='asc'
checked='checked'>
              <font color='#00009C'> จากน้อยไปมาก
              <input type='radio' name='sort2' value='desc'>
              จากมากไปน้อย</font></td>
          </tr>

        </table>

        <p>
          <input type='submit' name='Submit' value='ค้นหา'>
        </p>
      </center>
    </td>
  </tr>
</table>
</form>
</body>
</html>";
?>
