#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('end2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';


print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Update Homepage</title></head>
<body bgcolor="#5ea0a0">
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@URL_Value2 = split(/=/,$URL_Value[0]);
$no=$URL_Value2[1];
@URL_Value2 = split(/=/,$URL_Value[1]);
$user=$URL_Value2[1];

if ($no eq '1')  {
	$dbh->do("update homepage set Color='' where No='1' and User='$user'");
	}
else { $sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
       $sth->execute;
       while (@field = $sth->fetchrow_array) {
		$max = $field[0];
		}
	
	$dbh->do("delete from homepage where No='$no' and User='$user'");
	$i=$no;
	$i++;
	while ($i <= $max) {
		$j=$i;
		$j--;
		$dbh->do("update homepage set No='$j' where No='$i' and User='$user'");
		$i++;
		}
	$max--;
	$dbh->do("update user set Id_homepage='$max' where Login='$user'");
	}
	
$sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_homepage = $field[0];
        }
&end2();
