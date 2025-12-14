#!/usr/bin/perl
push(INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$year=`/bin/date +"%Y"`;
$new=`/bin/date +"%j"`;
$year=$year*366;
$new=$year+$new;

#@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
#$range = $URL_Value[1];

#if ($range eq '') {$range = 1;}

if ($mydata{date} eq 'all') {$new = 0;}
else {$new = $new-$mydata{date};}

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Result of Search</title></head>
<body bgcolor="#5ea0a0">
<center>Result of Search</center>
<table>
EOF

 
$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$ip1=$mydata{input1};
$ip2=$mydata{input2};
$ip3=$mydata{input3};
$ip4=$mydata{input4};
$sel_room=$mydata{room};
$word=$mydata{word};
$match=false;
$no=1;
$no2=1;
#$range = $range*$width;
#$range++;

#$r=$range-$width;

if ($ip1 eq 'name') {
#	while ($r != $range) {
	if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select * from head_post where Name_post LIKE '%$word%' and Room='$sel_room' 
and Day >= $new");
	$sth->execute;
	&write_match();
	}
	if ($sel_room eq 'a') {
        $sth = $dbh->prepare("select * from head_post where Name_post LIKE '%$word%' and Day >= $new");
        $sth->execute;  
        &write_match();
        }
#	$r++;
#	}       
	
#	while ($r != $range) {
	if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select * from head_reply where Name_reply LIKE '%$word%' and
Room='$sel_room' and Day >= $new");
	$sth->execute;
	&write_match2();
        }       
        if ($sel_room eq 'a') {
        $sth = $dbh->prepare("select * from head_reply where Name_reply LIKE '%$word%'
and Day >= $new");    
        $sth->execute;
        &write_match2();
        }
#	$r++;
#	}
	}

if ($ip2 eq 'title') {
#	while ($r != $range) {
	if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select * from head_post where Title_post LIKE '%$word%' and
Room='$sel_room' and Day >= $new");
	$sth->execute;
	&write_match();
        }       
        else {
        $sth = $dbh->prepare("select * from head_post where Title_post LIKE '%$word%' and Day >= $new");    
        $sth->execute;
        &write_match();
        }
#	$r++;
#	}

#	while ($r != $range) {
        if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select * from head_reply where Title_reply LIKE '%$word%' and
Room='$sel_room' and Day >= $new");
	$sth->execute;
	&write_match2();
        }
        else {
        $sth = $dbh->prepare("select * from head_reply where Title_reply LIKE '%$word%' and Day >=
$new");
        $sth->execute;
        &write_match2();
        }
#	$r++;
#	}
	}

if ($ip3 eq 'detail') {
#	while ($r != $range) {
	if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select Id_post from Detail_post where Detail_post LIKE '%$word%' and Room='$sel_room'");
	$sth->execute;
	$p=0;
	while (@field = $sth->fetchrow_array) {
		$id[$p] = $field[0];
		$p++;
		}
	$m=0;
	while ($m < $p) {
	$sth = $dbh->prepare("select * from head_post where Id_post='$id[$m]' and Day >= $new");
	$sth->execute;
	$m++;
	&write_match();}
	}
	else {
        $sth = $dbh->prepare("select Id_post from Detail_post where Detail_post LIKE '%$word%'");
        $sth->execute;
	$p=0;
        while (@field = $sth->fetchrow_array) {
                $id[$p] = $field[0];
		$p++;
                }
	$m=0;
	while ($m < $p) {
        $sth = $dbh->prepare("select * from head_post where Id_post='$id[$m]' and Day >= $new");
        $sth->execute;
	$m++;
        &write_match();}
        }
#	$r++;
#	}
	
#	while ($r != $range) {
	if ($sel_room ne 'a') {
	$sth = $dbh->prepare("select Id_post,Id_reply from detail_reply
where Detail_reply LIKE '%$word%' and Room_reply='$sel_room'");
	}
	else {
        $sth = $dbh->prepare("select Id_post,Id_reply from detail_reply
where Detail_reply LIKE '%$word%'");
	}
	$sth->execute;
	$j = 0;
	while (@field = $sth->fetchrow_array) {
		$id1[$j] = $field[0];
		$id2[$j] = $field[1];
		$j++;
	 	}
	$i=0;
	while ($i < $j) {
	$sth = $dbh->prepare("select * from head_reply where Id_post='$id1[$i]' and Id_reply='$id2[$i]' 
and Day >= $new");
	$sth->execute;
	$i++;
	&write_match2();
#	}
#	$r++;
	}}	
$no--;
print "The word <b><i>$word</i></b> found $no matches\n";

print <<EOF;
</table>
</body>
</html>
EOF

sub write_match {
        while ($hash_ref = $sth->fetchrow_hashref) {
		$i = 0;
		while ($i != $no) {
		$i++;
		if ($array[$i] ne $hash_ref->{Id_post}) {
		$flag = 'true';
		}
		else {
		$flag = 'false';
		$i = $no;
		}}
		if ($flag eq 'true') { 
                print "<tr>\n";
                print "<th align=left><a href=\"title.cgi?title=$hash_ref->{Id_post}\">$no.$hash_ref->{Title_post}</a></th>\n";
                print "<td align=left>$hash_ref->{Name_post}</td>\n";
                print "<td align=left>$hash_ref->{No_reply}</td>\n"; 
                print "<td align=left>$hash_ref->{Time_post}</td>\n";
		print "</tr>\n";
		$array[$no] = $hash_ref->{Id_post};
                $match=true;
                $no++;
		}
                }
}

sub write_match2 {
	while ($hash_ref = $sth->fetchrow_hashref) {
		$i = 0;
		while ($i != $no2) {
		$i++;
		if ($array2[$i] ne $hash_ref->{Id_reply}) {
		$flag = 'true';
		}
		else {
		$flag = 'false';
		$i = $no2;
		}}
		if ($flag eq 'true') {
		print "<tr>\n";
		print "<th align=left><a href=\"title.cgi?title=$hash_ref->{Id_post}#$hash_ref->{Id_reply}\">$no.$hash_ref->{Title_reply}</a></th>\n";
                print "<td align=left>$hash_ref->{Name_reply}</td><td></td>\n";
                print "<td align=left>$hash_ref->{Time_reply}</td>\n";
		print "<td></td>\n";
         	print "</tr>\n";
		$array2[$no2] = $hash_ref->{Id_reply};
                $match=true;
                $no2++;
                }
		}
}










