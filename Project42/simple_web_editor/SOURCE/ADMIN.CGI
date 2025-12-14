#!/usr/bin/perl

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Adminstrator</title></head>
<body bgcolor="5ea0a0">
<center><h1>Please Enter Your Login and Password</h1></center>
<form method=post action="check_admin.cgi">
<table>
<tr><th>Login:</th>
    <td><input type=text size=20 maxlength=20 name="login"></td>
</tr>
<tr><th>Password:</th>
    <td><input type=password size=20 maxlength=20 name="pwd"></td>
</tr>
</table>
<p><input type="submit" value="submit">
   <input type="reset" value="Clear">
</form>
<br>
</body>
</html>
EOF

