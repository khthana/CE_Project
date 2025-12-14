#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
&ReadParse(*mydata);
$|=1;

use DBI;

$date=`/bin/date +"%a %d %h, 19 %Y : %T"`;

$database='webboard';
$user='web';
$password='project';

@URL = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL[1];

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

$dbh->do("insert into head_reply values('$mydata{subject_p}','$login','$date','$mydata{subject}','$mydata{title}','$room','$id')");

$dbh->do("insert into detail_reply values('$mydata{subject_p}','$mydata{detail}','$room','$login','$mydata{title}','$id')");

$dbh->do("update head_post set Last_reply='$date' where Id_post='$mydata{title}'");

print <<EOF;
<html>
<head><title>Post</title></head>
<body>
<table cellpadding=0 cellspacing=0 border=0 width=100%>
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
        print "<th align=left>$hash_ref->{Title_post}</th>\n";
        print "<td align=left>$hash_ref->{Name_post}</td>\n";
        print "<td align=left>$time</td>\n";
        print "</tr>\n";
        print "<tr bgcolor=#bee6fc>\n";
        print "<td>$hash_ref->{Detail_post}</td>\n";
        print "<td><img src=\"../picture/side_red1.gif\"></td>\n";
        print "<td><img src=\"../picture/side_red1.gif\"></td>\n";
        print "</tr>\n";
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
$sth = $dbh->prepare("select * from detail_reply where Id_post='$mydata{title}'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	print "<tr bgcolor=#98b798>\n";
	print "<th align=left>$hash_ref->{Title_reply}</th>\n";
	print "<td align=left>$hash_ref->{Name_reply}</td>\n";
	print "<td align=left>$time1[$i]</td>\n";
	print "</tr>\n";
	print "<tr bgcolor=#98e698>\n";
	print "<td align=left>$hash_ref->{Detail_reply}</td>\n";
	print "<td><img src=\"../picture/side_red1.gif\"></td>\n";
	print "<td><img src=\"../picture/side_red1.gif\"></td>\n";
	print "</tr>\n";
	$i++;
	}
$sth->finish;
$dbh->disconnect;

print <<EOF;
</table>
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
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF

exit;
}
else {
print <<EOF;
<html>
<head><title>No Login</title></head>
<body>
<center>
<a href="login.cgi">
<h1><blink>You must login ,then you can reply</blink></h1>
</a>
</center>
</body>
</html>
EOF
}
