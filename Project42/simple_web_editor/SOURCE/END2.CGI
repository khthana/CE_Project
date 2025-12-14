sub end2 {

$sth = $dbh->prepare("select * from homepage where User = '$user' and No =  
'1'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
        $type=$hash_ref->{Type};
        $form=$hash_ref->{Form};
        $color=$hash_ref->{Color};
        $position=$hash_ref->{Position};
        $size=$hash_ref->{Size};
        $bold=$hash_ref->{Bold};
        $italic=$hash_ref->{Italic};
        $upderline=$hash_ref->{Underline};
        $blink=$hash_ref->{Blink};
        $link=$hash_ref->{Link};
        $no=$hash_ref->{No};
        $br=$hash_ref->{Br};
        }
        
open(file,">/home/httpd/htdocs/$tmp$user.html");
print file <<EOF;
<html>
<head><title>$user Homepage</title></head>
EOF
&background();
        
$i=2;
while ($i <= $no_homepage) {
        $sth = $dbh->prepare("select * from homepage where User = '$user'
and No = '$i'");
        $sth->execute;
        while ($hash_ref = $sth->fetchrow_hashref) {
                $type=$hash_ref->{Type};
                $form=$hash_ref->{Form};
                $color=$hash_ref->{Color};
                $position=$hash_ref->{Position};
                $size=$hash_ref->{Size};
                $bold=$hash_ref->{Bold};
                $italic=$hash_ref->{Italic};
                $upderline=$hash_ref->{Underline};
                $blink=$hash_ref->{Blink};
                $link=$hash_ref->{Link};
                $no=$hash_ref->{No};
                $br=$hash_ref->{Br};
                }
if ($type eq 'txt') {&txt();}
if ($type eq 'pic') {&pic();}
$i++;
}
                
print  file <<EOF;
<form method=post
action="http://$base_host${cgi}update_home.cgi?user=$user">
<br><p><input type=submit value="Update Homepage">
</form><br>
EOF
                
print file "</body>\n</html>\n";
close(file);

&write_main();
                

sub background {
if ($form eq 'basic') {
        print file "<body bgcolor=\"$color\">";
        }
if ($form eq 'example') {
        print file "<body
background=\"http://$base_host$background$color\">";
        }
if ($form eq 'code') {
        print file "<body bgcolor=\"#$color\">";
        }
}
                
sub txt {
print file "<p align = $position>\n";
if ($link ne '') {
        print file "<a href=\"http://$link\">\n";
        }
print file "<font color=$color size=$size>";
if ($bold eq 'y') {print file "<b>"};
if ($italic eq 'y') {print file "<i>"};
if ($upderline eq 'y') {print file "<u>"};
if ($blink eq 'y') {print file "<blink>"};
print file "$form";
if ($bold eq 'y') {print file "</b>"};
if ($italic eq 'y') {print file "</i>"};
if ($upderline eq 'y') {print file "</u>"};
if ($blink eq 'y') {print file "</blink>"};
print file "</font>\n";
if ($link ne '') {print file "</a>\n"};
print file "</p>\n";
while ($br != 0) {
        print file "<br>\n";
        $br--;
        }
}

sub pic {
if ($position eq 'center') {print file "<center>\n";}
if ($link ne '') {
        print file "<a href=\"http://$link\">\n";
        }
print file "<img src=\"http://$base_host$tmp$form\"  ";
if ($position ne 'center') {print file  "align=$position \n";}
print file "border=0>\n";   
if ($link ne '') {print file "</a>\n"};
if ($position eq 'center') {print file "</center>\n";}
while (br != 0) {
        print file "<br>\n";
        $br--;
        }
}
}
1;
