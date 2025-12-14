#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
ReadParse(*mydata);
$|=1;

$date=`/bin/date +"%a %d %h, %Y : %T"`;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

print "Content-type:text/html\n\n";
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

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
$sth = $dbh->prepare("select Id from Total_board");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $id=$field[0];
        }
$id++;
$dbh->do("update Total_board set Id='$id' where name_board='project'");

$dbh->do("insert into head_post values('$mydata{subject}','$login','$date','0','','$id','$room')");

$dbh->do("insert into Detail_post values('$mydata{subject}','$room','$mydata{detail}','$login','$id')");

$dbh->do("update room set Last_log='$date' where Room='$room'");

$sth = $dbh->prepare("select No_post from room where Room='$room'");
while (@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	}
$no_post++;
$dbh->do("update room set No_post = '$no_post'");

&write_main();
}
else {
print <<EOF;
<html>
<head><title>No Login</title></head>
<body>
<center>
<a href="login.cgi">
<h1><blink>You must log in , then you can post</blink></h1>
</a>
</center>
</body>
</html>
EOF
}
