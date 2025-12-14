#!/usr/bin/perl

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Choose the properties of your text</title></head>
<body bgcolor=#5ea0a0>
<center>
<h4>Please Choose the properties of your text which you want</h4>
</center>
<br>
<form action="add_text2.cgi" method=post>
<table border=0>
<tr><th align=left valign=top>Add Text:</th>
    <td align=left><textarea name=message rows=10 cols=40></textarea></td>
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
    <input type=text size=5 maxlength=5 name=size></th><td></td>
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
    <td align=left><input type=text name=url size=30 maxlength=80 value="URL which you want to link"></td>
</tr>
<tr></tr>
<tr><th align=left><input type=checkbox name=br value=y>Do you want to br?</th>
    <td align=left><input type=text name=no_br size=6 maxlength=3 value="Number"></td>
</tr>
</table>
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>
<br>
EOF
