sub write_main {

print <<EOF;
<html>
<head>
<STYLE TYPE="text/css">
A:link, A:visited, A:active, A:hover { text-decoration: none; font-weight: bold
}
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
  </STYLE><title>Success</title></head>
<body bgcolor="5ea0a0">
<center><img src="http://hardware07.ce.kmitl.ac.th/logo2.GIF"></center><br><br>
<table border=0 width=100% cellspacing=0>
<tr bgcolor="#02e4dc"> 
<a href="http://hardware07.ce.kmitl.ac.th/cgi-bin/first_post.cgi?room=$room">Add Post</a>
<a href="http://hardware07.ce.kmitl.ac.th/cgi-bin/ip_user.cgi">Add New User</a>
<a href="http://hardware07.ce.kmitl.ac.th/cgi-bin/profile.cgi">Edit Profile</a>
<a href="http://hardware07.ce.kmitl.ac.th/cgi-bin/ip_search.cgi">Search</a>
<a href="http://hardware07.ce.kmitl.ac.th/cgi-bin/admin.cgi">Adminstrator</a>
EOF

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
if ($y eq 'y') {print "<a
href=\"http://hardware07.ce.kmitl.ac.th/cgi-bin/logout.cgi?login=$login\">Logout</a><br>\n";}
else {print "<a href=\"http://hardware07.ce.kmitl.ac.th/cgi-bin/login.cgi\">Login</a><br>\n";}
print "</tr></table>\n";


print <<EOF;
<table border=0 width=100% cellspacing=0>
<tr bgcolor="e2abc3">
EOF

$sth = $dbh->prepare("select N_room,Room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	print "<td><a
href=\"http://hardware07.ce.kmitl.ac.th/cgi-bin/title2.cgi?room=$field[1]\">$field[0]</a></td>\n";
	}
print "</tr></table><br>\n";

print "<table cellpadding=0 cellspacing=0 border=0 width=100%>\n";

$sth = $dbh->prepare("select Room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$d_room = $field[0];
	}

if ($room eq '') {$room=$d_room;}

$sth = $dbh->prepare("select No_post from room where Room='$room'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_post = $field[0];
	$no_post++;
	}

$sth = $dbh->prepare("select width from Total_board");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $width = $field[0];
        }

$width++;
$i=1;
while ($i != $width) {
$sth = $dbh->prepare("select * from head_post where Room='$room' and no='$i'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
        print "<tr>\n";
        print "<th align=left><a
href=\"http://hardware07.ce.kmitl.ac.th/cgi-bin/title.cgi?title=$hash_ref->{Id_post}\">$hash_ref->{Title_post}</th>\n";
        print "<td align=left>$hash_ref->{Name_post}</td>\n";
        print "<td align=left>$hash_ref->{No_reply}</td>\n";
        print "<td align=left>$hash_ref->{Time_post}</td>\n";
        print "</tr>\n";
        }
$i++;
}

$width--;
$no_post--;
$b = $no_post % $width;
$no_post = $no_post - $b;
$no_post = $no_post / $width;
if ($b ne '0') {$no_post++;}

$sth->finish;
$dbh->disconnect;
   
print "</table>\n";
$i=0;
while ($i < $no_post) {
	$i++;
	print "<a href=\"http://hardware07.ce.kmitl.ac.th/cgi-bin/title2.cgi?room=$room&range=$i\">$i</a>\n";
	}
print <<EOF;
</body>
</html>
EOF
exit;
}
1;#return true
