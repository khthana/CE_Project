#!/usr/bin/perl
push(@INC,"../tmp/");
require('path.cgi');  

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {
        $ip=$ENV{'REMOTE_ADDR'};
        }
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select
Ip,Login from user");
$sth->execute;
$y='n';
$n='n';
while (@field = $sth->fetchrow_array) {
        $ip2=$field[0];
        if ($ip2 eq $ip) {$y = 'y';
                          $login = $field[1];
                          }
        else {$n = 'y';}
        }

print "Content-type:text/html\n\n";

print <<EOF;
<html>
<head><title>Choose the background color</title></head>
<body bgcolor=#5ea0a0>
EOF
 
if ($y eq 'y') {
print <<EOF;
<center>
<h4>Please Choose the color of Your Background which you want</h4>
</center>
<br>
<form action="bgcolor2.cgi" method=post>
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
else {
	print "	<center><h1><a href=\"login.cgi\">Please
Login!!!</a></h1></center>\n";
	}

print "</body></html>\n";
