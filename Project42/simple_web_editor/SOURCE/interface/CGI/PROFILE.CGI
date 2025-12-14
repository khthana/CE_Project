#!/usr/bin/perl
push(INC,"/cgi-bin");
require('cgi_lib2.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Edit Profile</title></head>
<body>
<center>
<h1> Edit Your Profile</h1>
EOF

$ip=$ENV{'REMOTE_ADDR'};
$sth = $dbh->prepare("select Ip,Login from user");
$sth->execute;
#$row = $sth->mysql_num_rows;
$y='n';
$n='n';
while (@field = $sth->fetchrow_array) {
        $ip2=$field[0];
        if ($ip2 eq $ip) {$y = 'y';
                          $login = $field[1];
                          }
        else {$n = 'y';}
        }
if ($y eq 'y') {

$sth = $dbh->prepare("select * from user where Login='$login'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
	
print <<EOF;
<form action="edit_pro.cgi" method="post">
<table border=0>
<tr><th align=left>Name:</th>
    <td><input type=text size=30 maxlength=60 name="name"
value="$hash_ref->{Name}"></td>
</tr>
<tr><th align=left>E-mail:</th>
    <td><input type=text size=30 maxlength=60 name="email"
value="$hash_ref->{Email}"></td>
</tr>
<tr><th align=left>Telephone:</th>
    <td><input type=text size=20 maxlength=20 name="tel"
value="$hash_ref->{Tel}"></td>
</tr>
<tr><th align=left>Pager:</th>
    <td><input type=text size=20 maxlength=20 name="page"
value="$hash_ref->{Page}"></td>
</tr>
<tr><th align=left>Address:</th>
    <td><textarea rows=5 cols=60
name="add">$hash_ref->{Address}</textarea></td>
</tr>   
<tr><th align=left>Occupation:</th>
    <td><input type=text size=20 maxlength=20 name="job"
value="$hash_ref->{Occuppation}"></td>
</tr>
<tr><th align=left>Homepage:</th>
    <td><input type=text size=30 maxlength=40 name="home"
value="$hash_ref->{Homepage}"></td>
</tr>  
<tr><th align=left>ICQ Number:</th>
    <td><input type=text size=20 maxlength=15 name="icq"
value="$hash_ref->{Icq}"></td>
</tr>
</table>
<input type="hidden" name="login"  value="$login">
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF
}}

else  {
print <<EOF;
<h3> You must login ,then you can edit your profile </h3><br>
</body>
</html>
EOF
}

                            
