#!/usr/bin/perl

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><titleAdd Room</title></head>
<body bgcolor="#5ea0a0">
<center><h1>Please Entet This Information</h1></center>
<form method=post action="add_room2.cgi">
<table>
<tr><th>Name of Room:</th>
    <td><input type=text size=20 maxlength=75 name="name"></td>
</tr>
</table>
<p><input type="submit" value="submit">
   <input type="reset" value="Clear">
</form>
<br>
</body>
</html>
EOF

