#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$mailprog="/usr/sbin/sendmail";

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Result Add Login</title></head>
<body bgcolor=#5ea0a0>
EOF

if ($mydata{name} eq '' || $mydata{login} eq '' || $mydata{email} eq '' || $mydata{add} eq '') {
	print "<center>\n";
	print "<h1>Your Information is not Complete</h1>\n";
	print "</center>\n";
	print "</body>\n";
	print "</html>\n";
	}
else {
	$i = rand(9);
	$i=($i*10000000);
	($password1,$del) = split(/\./,$i);

	$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
	&pathy();

	$ch_user=0;
	$sth = $dbh->prepare("select Login from user");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		if ($mydata{login} eq $field[0]) {
			$ch_user++;
			}
	 	}
	if ($ch_user ne 0) {
		print "<h1>Please change your login because your login in used</h1><br>\n";
		}
	else { 
	$dbh->do("insert into user
values('$mydata{login}',password('$password1'),'$mydata{email}','$mydata{tel}','$mydata{page}','$mydata{add}','$mydata{job}','0','','$mydata{home}','$mydata{icq}','$mydata{name}','','','0','$mydata{question}','$mydata{answer},'')");

	$sth = $dbh->prepare("select No_user from Total_board");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		$no_user = $field[0];
		}
	$no_user++;
	$dbh->do("update Total_board set No_user='$no_user'");

	$dbh->disconnect;

        open( MAIL , "|$mailprog -t") || die("<h2>Can't open $mailprog</h2><br>");
        print MAIL "To: $mydata{email}\n";
        print MAIL "From: Project Webboard\n";
        print MAIL "Subject: Your Password\n";
        print MAIL "Thank you for register our Webboard\n
                    Please try to login on our Webboard\n
                    Your login is \"$mydata{login}\"\n
                    Your password is \"$password1\"\n\n
                    Caution! After you can login, please try to change your password  
                    Goodbye :P ";
        close( MAIL );

	print "<h3>Please login</h3><br>\n";
	print "<form action=\"check_login.cgi\" method=\"post\">\n";
	print "<table>\n";
	print "<tr><th align=left>Login:</th>\n";
	print "    <td><input  type=text size=20 maxlength=20 name=\"login\"></td>\n";
	print "</tr>\n";
	print "<tr><th align=left>Password:</th>\n";
	print "    <td><input type=password size=20 maxlength=20 name=\"pwd\"></td>\n";
	print "</tr>\n";
	print "</table>\n";
	print "<p><input type=\"submit\" values=\"Submit\">\n";
	print "   <input type=\"reset\" values=\"Clear\">\n";
	print "</form>\n";
	print "</body>\n";
	print "</html>\n"; 

	exit;
	} }
