#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';


print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Update Homepage</title></head>
<body bgcolor="#5ea0a0">
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@URL_Value2 = split(/=/,$URL_Value[0]);
$no=$URL_Value2[1];
@URL_Value2 = split(/=/,$URL_Value[1]);
$user=$URL_Value2[1];

$sth = $dbh->prepare("select * from homepage where User = '$user' and No = '$no'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
        $type=$hash_ref->{Type};
        $form=$hash_ref->{Form};
        $color=$hash_ref->{Color};
        $position=$hash_ref->{Position};
        $size=$hash_ref->{Size};
        $bold=$hash_ref->{Bold};
        $italic=$hash_ref->{Italic};
        $upderline=$hash_ref->{Underline};
        $blink=$hash_ref->{Blink};
        $link=$hash_ref->{Link};
        $no=$hash_ref->{No};
        $br=$hash_ref->{Br};
        }
if ($type eq 'background') {&back();}
if ($type eq 'pic') {&pic();}
if ($type eq 'txt') {&text();}
print "</body></html>\n";

sub back {
print <<EOF
<h4>Please Choose the color of Your Background which you want again!</h4>
</center>
<br>
<form action="update_bgcolor.cgi?No=$no&User=$user" method=post>  
<table border=0>
<tr><td><input type=radio name=bgcolor value=basic checked>Basic
Color</td>
    <td><select name=color1>
        <option value="aqua">Aqua</option>
        <option value="black">Black</option>  
        <option value="blue">Blue</option>
        <option value="fuchsia">Fuchsia</option>
        <option value="gray">Gray</option>
        <option value="green">Green</option>
        <option value="lime">Lime</option>
        <option value="maroon">Maroon</option>
        <option value="navy">Navy</option>
        <option value="olive">Olive</option>
        <option value="purple">Purple</option>
        <option value="red">Red</option>
        <option value="silver">Silver</option>
        <option value="teal">Teal</option>
        <option value="white">White</option>
        <option value="yellow">Yellow</option>
        </select></td>
<td></td>
<td></td>
</tr>
<tr></tr>
<tr><td><input type=radio name=bgcolor value=example>Example</td>
    <td><input type=radio name=color2 value="abg16.gif"><a
href="exam_pic.cgi?back=abg16.gif"><img
src="http://$base_host${background}abg16.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="abg26.gif"><a
href="exam_pic.cgi?back=abg26.gif"><img
src="http://$base_host${background}abg26.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="abg3.gif"><a
href="exam_pic.cgi?back=abg3.gif"><img
src="http://$base_host${background}abg3.gif"
border=0></a></td>
</tr>
<tr><td></td>
    <td><input type=radio name=color2 value="abg40.jpg"><a
href="exam_pic.cgi?back=abg40.jpg"><img
src="http://$base_host${background}abg40.jpg"
border=0></a></td>
    <td><input type=radio name=color2 value="abg43.jpg"><a
href="exam_pic.cgi?back=abg43.jpg"><img
src="http://$base_host${background}abg43.jpg"    
border=0></a></td>
    <td><input type=radio name=color2 value="abg9.gif"><a
href="exam_pic.cgi?back=abg9.gif"><img
src="http://$base_host${background}abg9.gif"
border=0></a></td>
</tr>
<tr><td></td>
    <td><input type=radio name=color2 value="background.jpg"><a
href="exam_pic.cgi?back=background.jpg"><img
src="http://$base_host${background}background.jpg"
border=0></a></td>
    <td><input type=radio name=color2 value="bg109.gif"><a
href="exam_pic.cgi?back=bg109.gif"><img
src="http://$base_host${background}bg109.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg112.gif"><a
href="exam_pic.cgi?back=bg112.gif"><img
src="http://$base_host${background}bg112.gif"
border=0></a></td>
</tr>
<tr><td></td>
    <td><input type=radio name=color2 value="bg114.gif"><a   
href="exam_pic.cgi?back=bg114.gif"><img
src="http://$base_host${background}bg114.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg115.gif"><a
href="exam_pic.cgi?back=bg115.gif"><img
src="http://$base_host${background}bg115.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg118.gif"><a
href="exam_pic.cgi?back=bg118.gif"><img
src="http://$base_host${background}bg118.gif"
border=0></a></td>
</tr>
<tr><td></td>
    <td><input type=radio name=color2 value="bg119.gif"><a
href="exam_pic.cgi?back=bg119.gif"><img
src="http://$base_host${background}bg119.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg123.gif"><a
href="exam_pic.cgi?back=bg123.gif"><img
src="http://$base_host${background}bg123.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg514.jpg"><a
href="exam_pic.cgi?back=bg514.gif"><img
src="http://$base_host${background}bg514.jpg"
border=0></a></td>
</tr>
<tr><td></td>
    <td><input type=radio name=color2 value="bg75.gif"><a
href="exam_pic.cgi?back=bg75.gif"><img
src="http://$base_host${background}bg75.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="bg89.gif"><a
href="exam_pic.cgi?back=bg89.gif"><img
src="http://$base_host${background}bg89.gif"
border=0></a></td>
    <td><input type=radio name=color2 value="wallpaper.gif"><a
href="exam_pic.cgi?back=wallpaper.gif"><img
src="http://$base_host${background}wallpaper.gif"
border=0></a></td>
</tr>
<tr></tr>
<tr><td><input type=radio name=bgcolor value=code>RGB Code</td>
    <td><input type=text name=color3 size=6 maxlength=6 value=FFFFFF></td>
<td></td>
<td></td>
</tr>
</table>
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>
<br> 
EOF
}

sub pic {
    print "<center>\n";
    print "<h4>Please Choose the properties of your text which you want again!</h4>\n";
    print "</center>\n";
    print "<br>\n";
    print "<form action=\"update_pic.cgi?No=$no&User=$user\" method=post>\n";
    print "<table border=0>\n";
    print "<tr><th align=left>Position:</th>\n";
    print "    <td align=left><select name=position>\n";
    print "        <option value=\"left\">Left</option>\n";
    print "        <option value=\"center\">Center</option>\n";
    print "        <option value=\"right\">Right</option>\n";
    print "        </select></td>\n";
    print "</tr>\n";
    print "<tr></tr>\n";
    print "<tr><th align=left><input type=checkbox name=link value=y>Do you want to link?</th>\n";
    print "    <td align=left><input type=text name=url size=30 maxlength=80 value=\"$link\"></td>\n";
    print "</tr>\n";  
    print "<tr></tr>\n";
    print "<tr><th align=left><input type=checkbox name=br value=y>Do you want to br?</th>\n";
    print "    <td align=left><input type=text name=no_br size=6 maxlength=3 value=\"$br\"></td>\n";
    print "</tr>\n";
    print "</table>\n";
    print "<input type=hidden name=file value=$form>\n";
    print "<p><input type=submit value=\"Submit\">\n";
    print "   <input type=reset value=\"Clear\">\n";
    print "</form><br>\n";
}

sub text {
print <<EOF;
<center>
<h4>Please Choose the properties of your text which you want again!</h4>
</center>
<br>
<form action="update_text.cgi?No=$no&User=$user" method=post>
<table border=0>
<tr><th align=left valign=top>Add Text:</th>
    <td align=left><textarea name=message rows=10 cols=40>$form</textarea></td>
</tr>
<tr></tr>
<tr><th align=left>Color of Text:</th>
    <td align=left><select name=color>
        <option value="aqua">Aqua</option>
        <option value="black">Black</option>  
        <option value="blue">Blue</option>
        <option value="fuchsia">Fuchsia</option>
        <option value="gray">Gray</option>
        <option value="green">Green</option>
        <option value="lime">Lime</option>
        <option value="maroon">Maroon</option>
        <option value="navy">Navy</option>
        <option value="olive">Olive</option>
        <option value="purple">Purple</option>
        <option value="red">Red</option>  
        <option value="silver">Silver</option>
        <option value="teal">Teal</option>
        <option value="white">White</option>
        <option value="yellow">Yellow</option>
        </select></td>
</tr>
<tr></tr>
<tr><th align=left>Position:</th>
    <td align=left><select name=position>   
        <option value="left">Left</option>
        <option value="center">Center</option>
        <option value="right">Right</option>  
        </select></td>
</tr>
<tr></tr>
<tr><th align=left>Size:
    <input type=text size=5 maxlength=5 name=size value=$size></th><td></td>
</tr>
<tr></tr>
<tr><th align=left><input type=checkbox name=bold value=y>Bold</th>
    <td></td>
</tr>
<tr><th align=left><input type=checkbox name=italic value=y>Italic</th>
    <td></td>
</tr>
<tr><th align=left><input type=checkbox name=under value=y>Underline</th>
    <td></td>
</tr>
<tr><th align=left><input type=checkbox name=blink value=y>Blink</th>
    <td></td>
</tr>
<tr></tr>
<tr><th align=left><input type=checkbox name=link value=y>Do you want to link?</th>
    <td align=left><input type=text name=url size=30 maxlength=80 value="$link"></td>
</tr>
<tr></tr>
<tr><th align=left><input type=checkbox name=br value=y>Do you want to br?</th>
    <td align=left><input type=text name=no_br size=6 maxlength=3 value="$br"></td>
</tr>
</table>
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>  
<br>
EOF
}

