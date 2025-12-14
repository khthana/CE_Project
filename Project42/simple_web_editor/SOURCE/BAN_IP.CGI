#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);

$|=1;
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<body bgcolor="#5ea0a0">
<head><title>Ban ip for this board</title></head>
<center><h1>Ban ip For This Board</h1></center>
<br>
<form action="ban_ip2.cgi" method=post>
<table border=0>
<tr><td><input type=radio name=type value=add><b>Add</b></td>
    <th></th>
    <td></td>
</tr>
<tr><td><input type=radio name=type value=remove><b>Remove</b></td>
    <th>IP Address :</th>
    <td><input type=text name=ip size=20 maxlength=20></td>
</tr>
</table>
<p><input type=submit value=Submit>
   <input type=reset value=Clear>
</form>
</body>
</html>
EOF


