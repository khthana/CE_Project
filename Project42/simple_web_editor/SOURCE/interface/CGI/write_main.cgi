sub write_main {

print <<EOF;
<html>
<head><title>Success</title></head>
<body>
<h1>Main Page</h1>
<a href="first_post.cgi?room=$room">Add Post</a>
<a href="ip_user.cgi">Add New User</a>
<a href="profile.cgi">Edit Profile</a>
<a href="ip_search.cgi">Search</a>
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
href=\"logout.cgi?login=$login\">Logout</a><br>\n";}
else {print "<a href=\"login.cgi\">Login</a><br>\n";}

#if ($flag_log eq 'y') {print "<a href=\"logout.cgi\">Log out</a><br>\n";}
#else {print "<a href=\"login.cgi\">Log in</a><br>\n";}

print <<EOF;
<a href="title2.cgi?room=1">Room 1</a>
<a href="title2.cgi?room=2">Room 2</a>
<a href="title2.cgi?room=3">Room 3</a> 
<a href="title2.cgi?room=4">Room 4</a>
EOF

print "<table>\n";

$sth = $dbh->prepare("select * from head_post where Room='$room'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
        print "<tr>\n";
        print "<th align=left><a href=\"title.cgi?title=$hash_ref->{Id_post}\">$hash_ref->{Title_post}</th>\n";
        print "<td align=left>$hash_ref->{Name_post}</td>\n";
        print "<td align=left>$hash_ref->{No_reply}</td>\n";
        print "<td align=left>$hash_ref->{Time_post}</td>\n";
        print "</tr>\n";
        }
$sth->finish;
$dbh->disconnect;
   
print <<EOF;
</table>
</body>
</html>
EOF
exit;
}
1;#return true
