<?php
//-----------------------------------------------
class message {
    
var $empty_nickname	="ชื่อเล่น";	      
var $empty_firstname	="ชื่อจริง";       
var $empty_lastname	="นามสกุล";
var $empty_password	="รหัสผ่าน";
var $empty_email	="e-mail"; 	     
var $empty_address	="ที่อยู่"; 	     
var $empty_bound	="อำเภอ/เขต"; 	     
var $empty_phone	="โทรศัพท์"; 	     
var $empty_page		="เพจ";
var $empty_postal	="รหัสไปรษณีย์"; 	     
var $incorrect_password	="รหัสผ่านทั้งสองครั้งไม่ตรงกัน";	
var $incorrect_login	="ชื่อเล่นหรือรหัสผ่านไม่ถูกต้อง";
 }
class post_message extends message{
var $empty_title	="		    ชื่อสินค้า";
var $empty_quantity	="		    จำนวนสินค้า";
var $empty_startprice	="		    ราคาเริ่มต้น";
var $empty_minprice	="		    ราคาต่ำสุด";
var $empty_category	="		    หมวดหมู่สินค้า";	
}
//-----------------------------------------------
class bid_message extends post_message{
var $empty_bid_price	="		    ราคาประมูล";
}
//-----------------------------------------------
class regis_message {
var $regis_message=
"การสมัครสมาชิกถูกต้อง และเรียบร้อย!
คุณสามารถนำสินค้าเข้ามาประมูลหรือจะประมูลสินค้าในเว็บไซต์";

var $regis_welcome = "welcome to BK-auction";

}
//-----------------------------------------------
?>
