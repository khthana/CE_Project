#!/usr/bin/perl

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add new user</title></head>
<body>
<h1>Please </h1>
<form method="post" action="new_user2.cgi">
<table>
<tr><th>Name:</th>
    <td><input type="text" name="name" size=30 maxlength=40></td>
</tr>
<tr><th>Password:(max=8)</th>
    <td><input type="password" name="passw" size=30 maxlength=8></th>
</tr>
<tr><th>E-mail:</th>
    <td><input type="text" name="mail" size=30 maxlength=40></td>
</tr>
<tr><th>Homepage:</th>
    <td><input type="text" name="homepage" size=30 maxlength=40></td>
</tr>
<tr><th>Telephone:</th>
    <td><input type="text" name="tel" size=30 maxlength=15></td>
</tr>
</table>
<p><input type="submit" value="ADD">
   <input type="reset" value="CLEAR">
</form>
</body>
</html>
EOF
