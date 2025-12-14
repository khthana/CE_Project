#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
&ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$title=$URL_Value[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Post</title></head>
<body>
<table cellpadding=0 cellspacing=0 border=0 width=100%>
EOF

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
$sth = $dbh->prepare("select Time_post,Room from head_post where Id_post='$title'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$time = $field[0];
	$room = $field[1];
	}

$sth = $dbh->prepare("select * from Detail_post where Id_post='$title'");
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
	print "</table>\n";
	}
$subject=$hash_ref->{Title_post};

$i=0;
$sth = $dbh->prepare("select Time_reply from head_reply where Id_post='$title'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$time1[$i] = $field[0];
	$i++;
	}
$i=0;
print "<table cellpadding=0 cellspacing=0 border=0 width=100%>\n";
$sth = $dbh->prepare("select * from detail_reply where Id_post='$title'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
        print "<tr bgcolor=#98b798>\n";
        print "<a name=\"$hash_ref->{Id_reply}\">\n";
        print "<th align=left>$hash_ref->{Title_reply}</th>\n";
	print "</a>\n";
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
<form method="post" action="reply.cgi?id=$title">
<table>
<tr><th>Subject:</th><td><input type="text" name="subject_p" size=20 maxlength=30></td></tr>
<tr><th>Detail:</th><td><textarea name="detail" rows=10 cols=40></textarea></td></tr>
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
