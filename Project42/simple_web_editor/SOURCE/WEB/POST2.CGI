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

$year=`/bin/date +"%Y"`;
$new=`/bin/date +"%j"`;
$year=$year*366;
$new=$year+$new;

$time=`/bin/date +"%k%M%S"`;

print "Content-type:text/html\n\n";
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

$ip=$ENV{'REMOTE_ADDR'};
$sth = $dbh->prepare("select Ip,Login from user");
$sth->execute;
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

$sth = $dbh->prepare("select No_post from room where Room='$room'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	}

#$i=1;
#$no_post++;
for ($i=$no_post;$i>=1;$i--) {
	$j = $i;
	$j++;
	$dbh->do("update head_post set no='$j' where no='$i' and Room='$room'");
	}

$dbh->do("insert into head_post values('$mydata{subject}','$login','$date','0','','$id','$room','1','$new','$time')");

$dbh->do("insert into Detail_post values('$mydata{subject}','$room','$mydata{detail}','$login','$id')");

$sth = $dbh->prepare("select No_post from room where Room='$room'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	}
$no_post++;
$dbh->do("update room set No_post = '$no_post' where Room='$room'");

$dbh->do("update room set Last_post = '$date' where Room='$room'");

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
