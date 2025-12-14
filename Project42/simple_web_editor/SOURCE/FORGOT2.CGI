#!/usr/bin/perl

push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$sth = $dbh->prepare("select answer from user where
Login='$mydata{login}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$answer = $field[0];
	}
print "Content-type:text/html\n\n";   

if ($answer eq $mydata{answer}) {

print <<EOF;
<html>
<head><title>Forgot Password</title></head>
<body bgcolor="#5ea0a0">
<h1><center>Your New Password will be send to your E-Mail !!
</center></h1>
<br>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF

$sth = $dbh->prepare("select Email from user where
Login='$mydata{login}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$email = $field[0];
	}
$i = rand(9);
$i=($i*10000000);
($password1,$del) = split(/\./,$i);

$dbh->do("update user set Password=password('$password1') where
Login='$mydata{login}'");

$mailprog="/usr/lib/sendmail";       

open( MAIL , "|$mailprog -t") || die("<h2>Can't open $mailprog</h2><br>");
print MAIL "To: $email\n";
print MAIL "From: Project Webboard\n";
print MAIL "Subject: Your Password\n";
print MAIL "Thank you for register our Webboard\n
                    Please try to login on our Webboard\n
                    Your login is \"$mydata{login}\"\n
                    Your password is \"$password1\"\n\n
                    Caution! After you can login, please try to change your password
                    Goodbye :P ";               
close( MAIL );              
}

else {
print <<EOF;
<html>
<head><title>Incorrect</title></head>
<body bgcolor=#5ea0a0>
<h1><center>Your answer is incorrect !!</center></h1>
</body>
</html>
EOF
}
