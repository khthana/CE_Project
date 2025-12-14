<?PHP

CLASS POST_INTERFACE
{
	FUNCTION post()
	{
$hour = (date('h'));
$minute = (date('i'));
$second = (date('s'));
$ampm = (date('A'));
$date = (date('d'));
$t = (date('S'));
$mount = (date('F'));
$year = (date('Y'));

ECHO "
<body bgcolor = '#ffffff' link ='#0077ff' vlink = '#0077ff' alink =
'#0077ff'><p><font size='+2' color='#339900'><u><b><font
		size='+2'>นำสินค้าเข้ารับการประมูล</font></b></u> <font color='#FF0000'>(* 
  = ต้องการ)</font></font></p>
<p></p>
<form name=a action
='http://161.246.5.146/auction1/post/post_preview.php3' method = post>
  <script language='javascript'>
	callname=new Array;
	cat =new Array;
	cat['0']=new
Array('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16');
	
callname['01']=' ของโบราณ ->';
		cat['01']=new Array('0101','0102','0103','0104','0105');
			callname['0101']='เซรามิก';
			callname['0102']='เครื่องแก้ว';
			callname['0103']='งานไม้';
			callname['0104']='งานปั้น';
			callname['0105']='อื่น ๆ';
	
callname['02']='หนังสือ ->';
		cat['02']=new Array('0201','0202','0203','0204','0205');
			callname['0201']='แมกกาซีน';
			callname['0202']='นวนิยาย';
			callname['0203']='เรื่องสั้น';
			callname['0204']='การศึกษา ->';
				cat['0204']=new Array('020401','020402');
					callname['020401']='วิทยาศาสตร์และเทคโนโลยี';
					callname['020402']='สังคม';
			callname['0205']='อื่น ๆ';
	
callname['03']='เพลงและภาพยนต์ ->';
		cat['03']=new Array('0301','0302','0303','0304');
			callname['0301']='VDO ->';
				cat['0301']=new Array('030101','030102','030103','030104','030105');
					callname['030101']='ภาพยนต์ไทย';
					callname['030102']='ภาพยนต์ต่างประเทศ';
					callname['030103']='Music video ไทย';
					callname['030104']='Music video ต่างประเทศ';
					callname['030105']='อื่น ๆ';
			callname['0302']='VCD ->';
				cat['0302']=new Array('030201','030202','030203','030204','030205');
					callname['030201']='ภาพยนต์ไทย';
					callname['030202']='ภาพยนต์ต่างประเทศ';
					callname['030203']='Music video ไทย';
					callname['030204']='Music video ต่างประเทศ';
					callname['030205']='อื่น ๆ';
			callname['0303']='DVD ->';
				cat['0303']=new Array('030301','030302','030303','030304','030305');
					callname['030301']='ภาพยนต์ไทย';
					callname['030302']='ภาพยนต์ต่างประเทศ';
					callname['030303']='Music video ไทย';
					callname['030304']='Music video ต่างประเทศ';
					callname['030305']='อื่น ๆ';
			callname['0304']='เทปเพลง ->';
				cat['0304']=new Array('030401','030402');
					callname['030401']='เทปเพลงไทย';
					callname['030402']='เทปเพลงสากล';
	
callname['04']='ของสะสม ->';
		cat['04']=new Array('0401','0402','0403');
			callname['0401']='เหรียญ';
			callname['0402']='แสตมป์';
			callname['0403']='อื่น ๆ';
	
callname['05']='คอมพิวเตอร์ ->';
		cat['05']=new Array('0501','0502','0503','0504');
			callname['0501']='Hardware ->';
				cat['0501']=new
Array('050101','050102','050103','050104','050105','050106','050107','050108','050109','050110','050111','050112');
					callname['050101']='Hardware full system';
					callname['050102']='CPU';
					callname['050103']='Mainboard';
					callname['050104']='RAM';
					callname['050106']='Cumputer Display card';
					callname['050107']='Storage device';
					callname['050108']='MODEM';
					callname['050109']='Network Interface Card';
					callname['050110']='Printer';
					callname['050111']='Scanner';
					callname['050112']='อื่น ๆ';
			callname['0502']='Software ->';
	cat['0502']=new Array('050201','050202','050203','050204');
					callname['050201']='Programming';
					callname['050202']='Utillity';
					callname['050203']='Game';
					callname['050204']=' อื่น ๆ';
			callname['0503']='Domain Name';
			callname['0504']='อื่น ๆ';
 	
callname['06']='ของเล่น ->';
		cat['06']=new Array('0601','0602','0603','0604');
			callname['0601']='ตุ๊กตา';
			callname['0602']='บาร์บี้';
			callname['0603']='ตัวต่อ';
			callname['0604']='อื่น ๆ';

callname['07']='อุปกรณ์อิเล็กทรอนิกส์ ->';
		cat['07']=new Array('0701','0702','0703','0704','0705','0706','0707','0708');
			callname['0701']='วิทยุ, เครื่องเสียง';
			callname['0702']='โทรทัศน์';
			callname['0703']='walkman';
			callname['0704']='เครื่องเล่น VDO';
			callname['0708']='ชิ้นส่วนอิเล็กทรอนิกส์ ->';
				cat['0708']=new Array('070801','070802','070803','070804');
					callname['070801']='IC';
					callname['070802']='Resistor';
					callname['070803']='หม้อแปลง';
					callname['070804']='สายไฟ';
			callname['0706']='เครื่องเล่น DVD';
			callname['0707']='เครื่องเล่น Laser Disc';
			callname['0705']='เครื่องเล่น VCD';
	
callname['08']='อุปกรณ์สื่อสาร ->';
		cat['08']=new Array('0801','0802','0803','0804','0805');
			callname['0801']='โทรศัพท์';
			callname['0802']='โทรศัพท์มือถือ';
			callname['0803']='วิทยุติดตามตัว (เพจ)';
			callname['0804']='แฟกซ์';			
			callname['0805']='อื่น ๆ';			
	
callname['09']='กล้องถ่ายรูปและอูปกรณ์ ->';
		cat['09']=new Array('0901','0902','0903','0904','0905','0906','0907','0908');
			callname['0901']='กล้องถ่ายรูป';
			callname['0902']='เลนส์';
			callname['0903']='Filter';
			callname['0904']='Flash';			
			callname['0905']='ขาตั้งกล้อง';
			callname['0906']='สาย run shutter';
			callname['0908']='Hood';
	
callname['10']='อุปกรณ์การกิฬา ->';
		cat['10']=new Array('1001','1002','1003');
			callname['1001']='ฟุตบอล ->';
				cat['1001']=new Array('100101','100102','100103','100104','100105','100106','100107');
					callname['100101']='รองเท้า สตั๊ด';
					callname['100102']='รองเท้าวิ่ง';
					callname['100103']='เสื้อฟุตบอล';
					callname['100104']='ถุงเท้าฟุตบอล';
					callname['100105']='ลูกฟุตบอล';
					callname['100106']='สนับแข้ง';
					callname['100107']='อื่น ๆ';
			callname['1002']='บาสเก็ตบอล ->';
				cat['1002']=new Array('100201','100202');
					callname['100201']='รองเท้าบาสเก็ตบอล';
					callname['100202']='ลูกบาส';
			callname['1003']='ว่ายน้ำ ->';
				cat['1003']=new Array('100301','100302','100303');
					callname['100301']='แว่นตากันน้ำ';
					callname['100302']='ชุดว่ายน้ำผู้ชาย';
					callname['100303']='ชุดว่ายน้ำผู้หญิง';
	
callname['11']='เครื่องประดับและอัญมณี ->';
		cat['11']=new Array('1101','1102','1103','1104','1105','1106');
			callname['1101']='เข็มกลัด';
			callname['1102']='กำไล';
			callname['1103']='สร้อย';
			callname['1104']='แหวน';
			callname['1105']='นาฬิกา ->';
				cat['1105']=new Array('110501','110502');
					callname['110501']='นาฬิกาผู้ชาย';

callname['110502']='นาฬิกาผู้หญิง';
			callname['1106']='ต่างหู';
	
callname['12']='เครื่องแต่งกาย ->';
		cat['12']=new Array('1201','1202','1203','1204','1205');
			callname['1201']='เครื่องแต่งกายบุรุษ ->';
				cat['1201']=new Array('120101','120102','120103','120104','120105','120106');
					callname['120101']='เสื้อ';
					callname['120102']='กางเกง';
					callname['120103']='รองเท้า';
					callname['120104']='ถุงเท้า';
					callname['120105']='หมวก';
					callname['120106']='อื่น ๆ';
			callname['1202']='เครื่องแต่งกายสตรี ->';
				cat['1202']=new Array('120201','120202','120203','120204','120205','120206','120207');
					callname['120201']='เสื้อ';
					callname['120202']='กางเกง';
					callname['120203']='กระโปรง';
					callname['120205']='รองเท้า';
					callname['120204']='ถุงเท้า';
					callname['120206']='หมวก';
					callname['120207']='อื่น ๆ';
			callname['1203']='เครื่องแต่งกายเด็กผู้ชาย';
			callname['1204']='เครื่องแต่งกายเด็กผู้หญิง';
			callname['1205']='อื่น ๆ';			
	
callname['13']='เฟอร์นิเจอร์ ->';
		cat['13']=new Array('1301','1302','1303','1304','1305','1306');
			callname['1301']='โต๊ะ';
			callname['1302']='เก้าอี้';
			callname['1303']='ตู้';
			callname['1304']='เตียง';
			callname['1305']='ชุดรับแขก';
			callname['1306']='อื่น ๆ';
	
callname['14']='ยานพาหนะ ->';
		cat['14']=new Array('1401','1402','1403','1404');
			callname['1401']='รถยนต์';
			callname['1402']='รถจักรยานยนต์';
			callname['1403']='จักรยาน';
			callname['1404']='อื่น ๆ';
	
callname['15']='บ้านและที่ดิน';
	
callname['16']='อื่น ๆ';

function add(t)
{
	var c,b,i;
	c=0;
	t.khing2.length=0;
	t.khing2.length=0;
	t.khing3.length=0;
	i=0;
	t.khing2.options[i]=new Option('------------');
	t.khing3.options[i]=new Option('------------');
	if (cat[c]!=null)
	{
		for(i=0;i<cat[c].length;i++)
		{	
			b=cat[c][i];
			t.khing2.options[i]=new Option(callname[b]); 
			t.khing2.options[i].value=b; 
		}
	}
	t.khing2.options[i]=new Option('------------');
}

function showid(t,id)
{
	t.callnameid.value=id;
//	alert('ไทย not english');
}

function add1(t)
{
	var c,b,i;
	c=(t.khing1.options[t.khing1.selectedIndex].value);
	t.khing2.length=0;
	t.khing3.length=0;
	i=0;
	t.khing3.options[i]=new Option('------------');
	if (cat[c]!=null)
	{
		for(i=0;i<cat[c].length;i++)
		{	
			b=cat[c][i];
			t.khing2.options[i]=new Option(callname[b]); 
			t.khing2.options[i].value=b; 
		}
	}
	t.khing2.options[i]=new Option('------------');
	showid(t,c);
}
function add2(t)
{
	var c,b,i;
	c=(t.khing2.options[t.khing2.selectedIndex].value);
	t.khing3.length=0;
	i=0;
	if (cat[c]!=null)
	{
		for(i=0;i<cat[c].length;i++)
		{	
			b=cat[c][i];
			t.khing3.options[i]=new Option(callname[b]); 
			t.khing3.options[i].value=b; 
		}
	}
	t.khing3.options[i]=new Option('------------');
	showid(t,c);
}
function pay_check(t)
{

if ((t.payment.selectedIndex == 0) && (t.shipment.selectedIndex != 0) ) 
{
t.shipment.selectedIndex = 0;
alert('ขออภัย การจ่ายเงินแบบ พ.ก.ง. ต้องส่งสินค้าทางไปรษณีย์เท่านั้น');
}
}
</script>
  <table width='656' border='1' align=center>
    <tr> 
      <td width='100%'> 
        <center>
          <br>
          <table width='100%' border='0'
bgcolor='#FFCCFF'>
            <tr> 
              <td width='100%'> 
                <table width='97%'
border='0'>
                  <tr> 
                    <td
height='40' width='95' align=right>ชื่อเล่น :</td>
                    <td
height='40' width='319' >
                      <input type='TEXT'

name='nickname'>
                      <font color='#FF0000'>*</font> </td>
                  </tr>
                  <tr> 
                    <td
height='40' width='95' align=right>รหัสผ่าน :</td>
                    <td
height='40' width='319'>
                      <input type='password'

name='password'>
                      <font color='#FF0000'>*</font> </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <br>
          <table width='100%' border='0'
bgcolor='#FFFFCC'>
            <tr> 
              <td width='100%'> 
                <table width='97%'
border='0'>
                  <tr> 
                    <td
height='41' width='95' align=right>ชื่อสินค้า :</td>
                    <td height='41' width='319'> 
                      <input type='TEXT'

name='title' size='30'>
                      <font color='#FF0000'>*</font> </td>
                  </tr>
                  <tr> 
                    <td
height='40' width='95' align=right>ประเภทสินค้า :</td>
                    <td
height='40' width='315'> 
                      <select  name=khing1 size=5 onChange=add1(document.a) >
                        <option value='01'>ของโบราณ -></option>
                        <option value='02'>หนังสือ -></option>
                        <option value='03'>เพลงและภาพยนต์ -></option>
                        <option value='04'>ของสะสม -></option>
                        <option value='05'>คอมพิวเตอร์ -></option>
                        <option value='06'>ของเล่น -></option>
                        <option value='07'>อุปกรณ์ไฟฟ้าและอิเล็กทรอนิกส์ -></option>
                        <option value='08'>อุปกรณ์สื่อสาร -></option>
                        <option value='09'>อุปกรณ์ถ่ายภาพ -></option>
                        <option value='10'>อุปกรณ์กีฬา -></option>
                        <option value='11'>เครื่องประดับและอัญมณี -></option>
                        <option value='12'>เครื่องแต่งกาย -></option>
                        <option value='13'>เฟอร์นิเจอร์-></option>
                        <option value='14'>ยานพาหนะ -></option>
                        <option value='15'>บ้านและที่ดิน</option>
                        <option value='16'>อื่น ๆ</option>
                        <option>------------</option>
                      </select>
                      <select  name=khing2 size=5 onChange=add2(document.a) >
                        <option>------------</option>
                      </select>
                      <select  name=khing3 size=5  onChange=showid(document.a,document.a.khing3.options[a.khing3.selectedIndex].value)>
                        <option>------------</option>
                      </select>
                      <input type=text name=callnameid size=6 value=' '>
                      <font color='#FF0000'>*</font> </td>
                  </tr>
                  <tr> 
                    <td height='40'
width='95' align=right><a
href='http://161.246.5.146/auction1/help.php3#5'>URL              
         ของภาพ :</a></td>                     <td height='40' width='319'>
                      <input type='text' value=http:// 	 name='userfile' size=50>
                      <a
href='http://161.246.5.146/auction1/interface/help.php3#picture_url'>       
                </a></td>                   </tr>
                  <tr> 
                    <td
height='40' width='95' align=right>รายละเอียดสินค้า :</td>
                    <td
height='40' width='319'> 
                      <textarea name='description' rows='6'
cols='60'></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td
height='40' width='95' align=right>ที่อยู่สินค้า :</td>
                    <td height='40' width='319'> 
                      <select  name = location size='1'>
                        <option value=1>เชียงใหม่</option>
                        <option value=2>เชียงราย</option>
                        <option value=3>กำแพงเพชร</option>
                        <option value=4>ลำปาง</option>
                        <option value=5>ลำพูน</option>
                        <option value=6>แม่ฮ่องสอน</option>
                        <option value=7>นครสวรรค์</option>
                        <option value=8>น่าน</option>
                        <option value=9>พะเยา</option>
                        <option value=10>เพชรบูรณ์</option>
                        <option value=11>พิจิตร</option>
                        <option value=12>พิษณุโลก</option>
                        <option value=13>แพร่</option>
                        <option value=14>สุโขทัย</option>
                        <option value=15>ตาก</option>
                        <option value=16>อุทัยธานี</option>
                        <option value=17>อุตรดิตถ์</option>
                        <option value=18>อำนาจเจริญ</option>
                        <option value=19>บุรีรัมย์</option>
                        <option value=20>ชัยภูมิ</option>
                        <option value=21>กาฬสินธุ์</option>
                        <option value=22>ขอนแก่น</option>
                        <option value=23>แลย</option>
                        <option value=24>มหาสารคาม</option>
                        <option value=25>มุกดาหาร</option>
                        <option value=26>นครราชสีมา</option>
                        <option value=27>นครพนม</option>
                        <option value=28>หนองบัวลำภู</option>
                        <option value=29>หนองคาย</option>
                        <option value=30>ร้อยเอ็ด</option>
                        <option value=31>สกลนคร</option>
                        <option value=32>ศรีสะเกษ</option>
                        <option value=33>สุรินทร์</option>
                        <option value=34>อุบลราชธานี</option>
                        <option value=35>อุดรธานี</option>
                        <option value=36>ยโสธร</option>
                        <option value=37 selected>กรุงเทพมหานคร</option>
                        <option value=38>นนทบุรี</option>
                        <option value=39>ปทุมธานี</option>
                        <option value=40>นครนายก</option>
                        <option value=41>ปราจีนบุรี</option>
                        <option value=42>สระแก้ว</option>
                        <option value=43>ฉะเชิงเทรา</option>
                        <option value=44>พระนครศรีอยุธยา</option>
                        <option value=45>ลพบุรี</option>
                        <option value=46>สระบุรี</option>
                        <option value=47>สิงห์บุรี</option>
                        <option value=48>อ่างทอง</option>
                        <option value=49>ชัยนาท</option>
                        <option value=50>สมุทรปราการ</option>
                        <option value=51>สมุทรสาคร</option>
                        <option value=52>สมุทรสงคราม</option>
                        <option value=53>นครปฐม</option>
                        <option value=54>สุพรรณบุรี</option>
                        <option value=55>ราชบุรี</option>
                        <option value=56>กาญจนบุรี</option>
                        <option value=57>เพชรบุรี</option>
                        <option value=58>ประจวบคิรีขันธ์</option>
                        <option value=59>ชลบุรี</option>
                        <option value=60>ระยอง</option>
                        <option value=61>จันทบุรี</option>
                        <option value=62>ตราด</option>
                        <option value=63>ชุมพร</option>
                        <option value=64>ระนอง</option>
                        <option value=65>สุราษฎร์ธานี</option>
                        <option value=66>พังงา</option>
                        <option value=67>ภูเก็ต</option>
                        <option value=68>กระบี่</option>
                        <option value=69>นครศรีธรรมราช</option>
                        <option value=70>ตรัง</option>
                        <option value=71>พัทลุง</option>
                        <option value=72>สงขลา</option>
                        <option value=73>สตูล</option>
                        <option value=74>ปัตตานี</option>
                        <option value=75>ยะลา</option>
                        <option value=76>นราธิวาส</option>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td height='40' width='95' align=right>จำนวนสินค้า :</td>
                    <td height='40' width='319'>
                      <input type='TEXT'
value=1  								 
name='quantity'>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <br>
          <table
width='100%' border='0' bgcolor='#FFCCFF'>
            <tr> 
              <td width='100%'> 
                <table width='97%' border='0'>
                  <tr bgcolor='#FFCCFF'> 
                    <td width='140' height=40 bgcolor='#9999FF'> 
                      <div align='right'>ชนิดการประมูลสินค้า :</div>
                    </td>
                    <td width='426' height='40'><font color='#FF3333'>*</font></td>
                  </tr>
                  <tr> 
                    <td width='130' height='44' bgcolor='#FFCCCC' bordercolor='#000033' bordercolordark='#0066CC'> 
                      <div align='center'><font color='#FFCCCC'> 
                        <input type='radio' name='auctiontype' value='1'
checked  >                          </font></div>                     </td>
                    <td height='40' width='426' bgcolor='#FFCCCC'><font
color='#FF33FF'><a
href='http://161.246.5.146/auction1/help.php3#normal''>การประมูลสินค้าแบบธรรมดา</a></font></td> 
                 </tr>                   <tr bgcolor='#FF9999'>             
        <td width='130' height='34' bordercolor='#000033'
bordercolordark='#0066CC'>                        <div align='center'><font
color='#FFCCCC'>                          <input type='radio'
name='auctiontype' value='3'>                         </font></div>         
           </td>                     <td height='40' width='426'><font
color='#FF33FF'><a
href='http://161.246.5.146/auction1/help.php3#dutch'>การประมูลสินค้าแบบหลายชิ้น                        </a></font></td>                   </tr>
                  <tr bgcolor='#FF6699'> 
                    <td width='130' height='34' bordercolor='#000033' bordercolordark='#0066CC'> 
                      <div align='center'><font color='#FFCCCC'> 
                        <input type='radio' name='auctiontype' value='2'>
                        </font></div>
                    </td>
                    <td
height='40' width='426'><font color='#FF33FF'><a
href='http://161.246.5.146/auction1/help.php3#reserve1'>                    
   การประมูลสินค้าแบบกำหนดราคาขั้นต่ำ</a><br>                      
</font><font color='#000000'>ราคาขั้นต่ำ &nbsp;&nbsp;                       
<input type='text' name='minprice'>                      
&nbsp;&nbsp;บาท</font><font color='#000000'> </font></td>                  
</tr>                   <tr bgcolor='#9999FF'> 
                    <td width='130' height='40'> 
                      <div align='right'>ราคาประมูลเริ่มต้น :</div>
                    </td>
                    <td width='426' height='40'> 
                      <input type='text' name='startprice' maxlength='10'>
                      บาท <font color='#FF3366'>*</font></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <br>
          <table
width='100%'
border='0' bgcolor='#FFFFCC'>
            <tr> 
              <td width='100%'> 
                <table width='97%' border='0'>
                  <tr> 
                    <td
height='40' width='95' align=right>ระยะเวลาการประมูล :</td>
                    <td height='40' width='319'> 
                      <select name='period' size='1'>
                        <option value = 1 selected>1 สัปดาห์</option>
                        <option value = 2>2 สัปดาห์</option>
                        <option value = 3>3 สัปดาห์</option>
                        <option value = 4>4 สัปดาห์</option>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td height='40' width='95' align=right>การจ่ายเงิน :</td>
                    <td height='40' width='319'> 
                      <select name='payment' size='1' onChange=pay_check(document.a)>
                        <option value =1 selected>พ.ก.ง</option>
                        <option value =2>ทางธนาคาร</option>
                        <option value =3>นัดพบ</option>
                        <option value =4>วิธีอื่น ๆ</option>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td height='40' width='95' align=right>การส่งสินค้า :</td>
                    <td height='40' width='319'> 
                      <select name='shipment' size='1' onChange=pay_check(document.a)>
                        <option value='2' selected>ส่งทางไปรษณีย์</option>
                        <option value='3'>นัดพบ</option>
                        <option value='4'>อื่นๆ</option>
                      </select>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          <p>
            <input
type='SUBMIT' name='Preview' value='แสดงตัวอย่าง'>
            <input type='RESET' name='  Clear  ' value='ลบข้อมูล'>
          </p>
        </center>
      </td>
    </tr>
  </table>
</form>
</body>
";
	}	//function post
}	//class post interface
?>


