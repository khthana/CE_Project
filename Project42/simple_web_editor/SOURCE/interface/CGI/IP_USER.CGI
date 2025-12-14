#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
&ReadParse(*mydata);

$|=1;
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<body>
<head><title>Add New User</title></head>
<center><h1>Add New User</h1></center>
<form action="add_user.cgi" method="post">
<table border=0>
<tr><th align=left>Name:</th>
    <td><input type=text size=30 maxlength=60 name="name"></td>
</tr>
<tr><th align=left>Login:</th>
    <td><input type=text size=20 maxlength=15 name="login"></td>
</tr>
<tr><th align=left>E-mail:</th>
    <td><input type=text size=30 maxlength=60 name="email"></td>
</tr>
<tr><th align=left>Telephone:</th>
    <td><input type=text size=20 maxlength=20 name="tel"></td>
</tr>  
<tr><th align=left>Pager:</th>
    <td><input type=text size=20 maxlength=20 name="page"></td>
</tr>
<tr><th align=left>Address:</th>
    <td><textarea rows=5 cols=60 name="add"></textarea></td>
</tr>
<tr><th align=left>Occupation:</th>
    <td><input type=text size=20 maxlength=20 name="job"></td>
</tr>
<tr><th align=left>Homepage:</th>
    <td><input type=text size=30 maxlength=40 name="home"></td>
</tr>
<tr><th align=left>ICQ Number:</th>
    <td><input type=text size=20 maxlength=15 name="icq"></td>
</tr>
</table>
<br><b>*** I will send your password by E-mail, Please fill your correct E-mail ***<b>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF


