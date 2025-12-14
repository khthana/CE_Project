<?php
echo "
<html>
<body bgcolor='#FFFFFF' text='#3333ff'>
<form action='http://161.246.5.146/auction1/search/result.php3'
method=post>
<center>
  <h2><font color='#FF3333'>ค้นหาจาก ชื่อเล่นผู้ขาย</font> </h2>
  <table width='100%' border='1'>
    <tr>
      <td height='288'> 
        <table width='100%' height='210' border='0' bgcolor='#ccffff'>
          <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>ชื่อเล่นผู้ขาย : 
                </b></div>
            </td>
            <td width='57%' height='34'> 
              <input type='hidden' name='search_type' value='seller' >
              <input type='text' name='nickname'>
            </td>
          </tr>
          <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>สินค้า : </b></div>
            </td>
            <td width='57%' height='34'> 
              <select name='status'>
                <option value='0'>ทั้งหมด</option>
                <option value='1'>ยังไม่ปิดประมูล</option>
                <option value='2'>ปิดประมูลแล้ว 1 วัน</option>
                <option value='3'>ปิดประมูลแล้ว 2 วัน</option>
                <option value='4'>ปิดประมูลแล้ว 1 สัปดาห์</option>
                <option value='5'>ปิดประมูลแล้ว 2 สัปดาห์</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width='43%' height='34'> 
              <div align='right'><b>ประเภทสินค้า : </b></div>
            </td>
            <td width='57%' height='34'> 
              <select name='category'>
                <option value=''>ทั้งหมด</option>
                <option value='01'>ของโบราณ</option>
                <option value='03'>เพลงและภาพยนต์</option>
                <option value='05'>คอมพิวเตอร์</option>
                <option value='07'>อุปกรณ์อิเล็กทรอนิกส์</option>
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
              <div align='right'><b>เรียงสินค้าโดย: </b></div>
            </td>
            <td width='57%' height='34'> 
              <select name='sort1'>
                <option value='now_pri' selected >ราคาปัจจุบัน</option>
                <option value='stop_date' >วันปิดประมูล</option>
                <option value='start_date' >วันนำสินค้าเข้าประมูล</option>
                <option value='item_id' >หมายเลขสินค้า</option>
                <option value='bid_num'>จำนวนผู้ประมูล</option>  
              </select>
            </td>
          </tr>
          <tr> 
            <td width='43%' height='34'>&nbsp;</td>
            <td width='57%' height='34'> 
              <font color='#00009c'><input type='radio' name='sort2'
value='asc' checked='checked'>
              จากน้อยไปมาก
              <input type='radio' name='sort2' value='desc'>
              จากมากไปน้อย</font></td>
          </tr>
        </table>
          <center><input type='submit' name='Submit'
value='ค้นหา'></center>
      </td>
    </tr>
  </table>
</center>
</form>
</body>
</html>";
?>
