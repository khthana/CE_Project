#!/usr/bin/perl

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$login=$URL_Value[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Check Login update homepage</title></head>
<body bgcolor="#5ea0a0">
<center><h1>Please Enter Your Password</h1></center>
<form method=post action="check_update.cgi?user=$login">
<table>
<tr><th>Password:</th>
    <td><input type=password size=20 maxlength=20 name="pwd"></td>
</tr>
</table>
<p><input type="submit" value="submit">
   <input type="reset" value="Clear">
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF

