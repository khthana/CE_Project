#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
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

if (($mydata{subject} ne '') && ($mydata{detail} ne '')) {
$time=`/bin/date +"%k%M%S"`;

print "Content-type:text/html\n\n";
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {$ip=$ENV{'REMOTE_ADDR'};}
else {$ip=$ENV{'HTTP_X_FORWARDED_FOR'};}

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

$check_ban = 'n';
$check_ban2 = 'n';
$sth = $dbh->prepare("select * from ban");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	if (($ip ne $field[0]) && ($login ne $field[1])) {	
		$check_ban = 'y';
		}
	else {$check_ban2 = 'y';}
	}

if ($check_ban2 ne 'y') {
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

for ($i=$no_post;$i>=1;$i--) {
	$j = $i;
	$j++;
	$dbh->do("update head_post set no='$j' where no='$i' and Room='$room'");
	}

$dbh->do("insert into head_post
values('$mydata{subject}','$login','$date','0','','$id','$room','1','$new','$time','$ip')");

$dbh->do("insert into Detail_post values('$mydata{subject}','$room','$mydata{detail}','$login','$id')");

$sth = $dbh->prepare("select No_post from room where Room='$room'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	}
$no_post++;
$dbh->do("update room set No_post = '$no_post' where Room='$room'");

$dbh->do("update room set Last_post = '$date' where Room='$room'");

$sth = $dbh->prepare("select No_post from user where Login='$login'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_post2=$field[0];
	}

$no_post2++;
$dbh->do("update user set No_post = '$no_post2' where Login='$login'");

&write_main();
}

else {
print <<EOF;
<html>
<head><title>No Login</title></head>
<body bgcolor=#5ea0a0>
<center>
<a href="login.cgi">
<h1><blink>You must log in , then you can post</blink></h1>
</a>
</center>
</body>
</html>
EOF
}
}
else {
print <<EOF;
<html>
<head><title>Can't Login</title></head>
<body bgcolor=#5ea0a0>
<center>
<h1>You can't post!!</h1>
</center>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF
}
}
else { print "Content-type:text/html\n\n";
       print <<EOF;
<html>
<head><title>Not complete</title></head>
<body bgcolor=#5ea0a0>
<center>
<h1><blink>Your Information not complete</blink></h1>
</center>
</body>
</html>
EOF
}
