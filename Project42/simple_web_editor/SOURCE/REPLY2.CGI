#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);
$|=1;

use DBI;

$date=`/bin/date +"%a %d %h, %Y : %T"`;

$database='webboard';
$user='web';
$password='project';

@URL = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL[1];

$year=`/bin/date +"%Y"`;
$new=`/bin/date +"%j"`;
$year=$year*366;
$new=$year+$new;

if (($mydata{subject_p} ne '') && ($mydata{detail} ne '')) {

$time=`/bin/date +"%k%M%S"`;

print "Content-type:text/html\n\n";

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {
	$ip=$ENV{'REMOTE_ADDR'};
	}
else {$ip=$ENV{'HTTP_X_FORWARDED_FOR'};}

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
$sth = $dbh->prepare("select No_reply from head_post where Id_post='$mydata{title}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $no=$field[0];
        }
$no++;
$dbh->do("update head_post set No_reply='$no' where Id_post='$mydata{title}'");

$sth = $dbh->prepare("select Id from Total_board");
$sth->execute;
while (@field = $sth->fetchrow_array) {   
        $id=$field[0];
        }
$id++;
$dbh->do("update Total_board set Id='$id' where name_board='project'");

$dbh->do("insert into head_reply
values('$mydata{subject_p}','$login','$date','$mydata{subject}','$mydata{title}','$room','$id','$new','$time','$ip')");

$dbh->do("insert into detail_reply values('$mydata{subject_p}','$mydata{detail}','$room','$login','$mydata{title}','$id')");

$dbh->do("update head_post set Last_reply='$date' where Id_post='$mydata{title}'");

$sth = $dbh->prepare("select no from head_post where Id_post='$mydata{title}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_change = $field[0];
	}

$i=$no_change;
$i--;
for ($i;$i>=1;$i--) {
	$j=$i;
	$j++;
	$dbh->do("update head_post set no='$j' where no='$i' and Room='$room'");
	}
	
$dbh->do("update head_post SET no='1' where Id_post='$mydata{title}' and Room='$room'");

$sth = $dbh->prepare("select No_post from user where Login='$login'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $no_post2=$field[0];
        }

$no_post2++;
$dbh->do("update user set No_post = '$no_post2' where Login='$login'");

print <<EOF;
<html>
<head><title>Post</title></head>
<body bgcolor="#4cb5a0">
<center>
<table cellpadding=0 cellspacing=0 border=1 height=20% width=50%>
<tr><td>
<table cellpadding=0 cellspacing=0 border=0 height=100% width=100%>
EOF

$sth = $dbh->prepare("select Time_post from head_post where Id_post='$mydata{title}'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$time=$field[0];
	}

$sth = $dbh->prepare("select * from Detail_post where Id_post='$mydata{title}'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
        print "<tr bgcolor=#46b7f8>\n";
        print "<th align=left width=30%>&nbsp;$hash_ref->{Title_post}<br>\n";
        print "<a
href=\"show_profile.cgi?user=$hash_ref->{Name_post}\">&nbsp;$hash_ref->{Name_post}</a><br>\n";
        print "&nbsp;$time</th>\n";
	print "</tr><tr bgcolor=#68b8c4>\n";
        print "<td align=left valign=top>&nbsp;$hash_ref->{Detail_post}<br>\n";
        print "</td></tr>\n";
        print "</table></td></tr></table></center><br>\n";
	}
$subject=$hash_ref->{Title_post};

$i=0;
$sth = $dbh->prepare("select Time_reply from head_reply where Id_post='$mydata{title}'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$time1[$i] = $field[0];
	$i++;
	}

$i=0;
print "<table cellpadding=0 cellspacing=5 border=0 width=100%>\n";
$sth = $dbh->prepare("select * from detail_reply where Id_post='$mydata{title}'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	print "<tr>\n";
	print "<th align=left width=20% bgcolor=#98b798>&nbsp;$hash_ref->{Title_reply}<br>\n";
	print "<a
href=\"show_profile.cgi?user=$hash_ref->{Name_reply}\">&nbsp;$hash_ref->{Name_reply}</a>\n";
	print "<br>&nbsp;$time1[$i]</th>\n";
	print "<td align=left bgcolor=#98e698 valign=top>&nbsp;$hash_ref->{Detail_reply}</td>\n";
	print "</td></tr>\n";
	$i++;
	}
$sth->finish;
$dbh->disconnect;

print <<EOF;
</table>
<br><br>
<form method="post" action="reply.cgi?id=$mydata{'title'}">
<table>
<tr><th>Subject:</th><td><input type="text" name="subject_p" size=20
maxlength=30</td></tr>
<tr><th>Detail:</th><td><textarea name="detail" rows=10
cols=40></textarea></td></tr>
</table>
<input type="hidden" name="subject" value="$subject">
<input type="hidden" name="room" value="$room">
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
<br>
<a href="title2.cgi?room=$room">Back to Main Page</a>
</body>
</html>
EOF

exit;
}
else {
print <<EOF;
<html>
<head><title>No Login</title></head>
<body bgcolor="#5ea0a0">
<center>
<a href="login.cgi">
<h1><blink>You must login ,then you can reply</blink></h1>
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
else {print "Content-type:text/html\n\n";
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
