#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
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
<body bgcolor="#4cb5a0">
<form method="post" action="del_reply.cgi">
<center>
<table cellpadding=0 cellspacing=0 border=0 height=20% width=50%>
<tr><td>
<table cellpadding=0 cellspacing=0 border=0 height=100% width=100%?
EOF

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

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
	print "<th align=left valign=top width30%>&nbsp;$hash_ref->{Title_post}<br>\n";
	print "<a
href=\"show_profile.cgi?user=$hash_ref->{Name_post}\">&nbsp;$hash_ref->{Name_post}</a><br>\n";
	print "&nbsp;$time</th>\n";
	print "</tr>\n";
	print "<tr bgcolor=#68b8c4>\n";
	print "<td align=left valign=top>&nbsp;$hash_ref->{Detail_post}<br>\n";
	print "</td></tr>\n";
	print "</table></td></tr></table></center><br>\n";
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
$j=1;
print "<table cellpadding=0 cellspacing=5 border=0 width=100%>\n";
$sth = $dbh->prepare("select * from detail_reply where Id_post='$title'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
        print "<tr>\n";
        print "<th align=left width=20% bgcolor=#98b798><input type=\"checkbox\" name=$j
value=$hash_ref->{Id_reply}>\n";
	print "&nbsp;$hash_ref->{Title_reply}<br>\n";
        print "<a
href=\"show_profile.cgi?user=$hash_ref->{Name_reply}\">&nbsp;$hash_ref->{Name_reply}</a>\n";
        print "<br>&nbsp;$time1[$i]</th>\n";
        print "<td bgcolor=#98e698 align=left valign=top>&nbsp;$hash_ref->{Detail_reply}</td>\n";
        print "</td></tr>\n";
	$i++;
	$j++;
        }
$sth->finish;
$dbh->disconnect;

print <<EOF;
</table>
<input type="hidden" name=title value="$title">
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
<br>
<br>
<a href="title2.cgi?room=$room">Back to Main Page</a>
</body>
</html>
EOF

exit;
