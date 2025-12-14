#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('in_out.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';         

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@value1 = split(/=/,$URL_Value[0]);
$room = $value1[1];
@value2 = split(/=/,$URL_Value[1]);
$range = $value2[1];

if ($range eq '') {$range = 1;}

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$sth = $dbh->prepare("select Room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $d_room = $field[0];
        }

if ($room eq '') {$room = $d_room;}

if ($ENV{'HTTP_VIA'} eq '') {
        $ip = $ENV{'REMOTE_ADDR'};
        }
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select Login from user where Ip='$ip'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $user = $field[0];
        }

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head>
<STYLE TYPE="text/css">
A:link, A:visited, A:active, A:hover { text-decoration: none; font-weight: bold }
      A:HOVER { color: "ffffff"; }

      BODY {
         font-size: 14pt; 
         font-family: helvetica,arial; 
         }  
      P {
         font-size: 14pt; 
         font-family: helvetica,arial; 
         }  
      TD {
         font-size: 14pt; 
         font-family: helvetica,arial; 
         }
      TD.header {
         font-size: 16pt; 
         font-family: helvetica,arial; 
         color: ffc000;
         }
      H3 {
         font-family: helvetica,arial;
         } 
  </STYLE><title>Main Post
Page</title></head>
<body bgcolor="#5ea0a0">
<center><img
src="http://${base_host}${background}logo2.GIF"></center><br><br>
<table border=0 width=100% cellspacing=0>
<tr>
<td align=right><a href="first_post.cgi?room=$room">Add
Post</a>|
<a href="ip_user.cgi">Add New User</a>|
<a href="profile.cgi">Edit Profile</a>|
<a href="ip_search.cgi">Search</a>|
<a href="admin.cgi">Adminstrator</a>|
<a href="forgot.cgi">Forgot Password</a>| 
EOF

$sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$id_home = $field[0];
	}

if ($id_home eq '0') {
	print "<a
href=\"bgcolor.cgi\">Create
Homepage</a>|";
	}
else {
        print "<a
href=\"add_object.cgi\">Create
Homepage</a>|";
	}

&in_out();
print "</tr></table><br>\n";

print <<EOF;
<table border=1 width=100% cellspacing=0>
<tr bgcolor="5db9ee">
EOF

$sth = $dbh->prepare("select N_room,Room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	print "<td align=center><a
href=\"title2.cgi?room=$field[1]\">$field[0]</a></td>\n";
	}
print "</tr></table>\n";
#print "<br>\n";

print "<table cellpadding=0 cellspacing=0 border=0 width=100%>\n";

$sth = $dbh->prepare("select No_post from room where Room='$room'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	$no_post++;
	}

$sth = $dbh->prepare("select width from Total_board");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$width = $field[0];
	}

$range = $range*$width;
$range++;

$c=0;
$i=$range-$width;
while ($i != $range) {
$sth = $dbh->prepare("select * from head_post where Room='$room' and no='$i'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	if ($c eq 0) {print "<tr bgcolor=\"4ab265\">\n";
		      $c++;}
	else {print "<tr bgcolor=\"52ce72\">\n";
	      $c--;}
	print "<th align=left width=40%><a
href=\"title.cgi?title=$hash_ref->{Id_post}\">&nbsp;$hash_ref->{Title_post}</a></th>\n";
	print "<td align=center width=25%><a
href=\"show_profile.cgi?user=$hash_ref->{Name_post}\">$hash_ref->{Name_post}</a></td>\n";
	print "<td aling=right width=5%>$hash_ref->{No_reply}</td>\n";
	print "<td align=center width=30%>$hash_ref->{Time_post}</td>\n";
	print "</tr>\n";
	}
$i++;
}

$no_post--;
$b = $no_post % $width;
$no_post = $no_post - $b;
$no_post = $no_post / $width;
if ($b ne '0' ) {$no_post++;}

$sth->finish;
$dbh->disconnect;
 
print "</table><br><br><br><br>\n";
$i=0;
while ($i < $no_post) {
	$i++;
	print "<a href=\"title2.cgi?room=$room&range=$i\">$i</a>\n";
	}
print <<EOF;
</body>
</html>
EOF

exit;
