#!/usr/bin/perl

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Input for Search</title></head>
<body bgcolor="5ea0a0">
<center>
<h1>Please fill Input for your search</h1>
</center>
<br>
<form action="search.cgi" method=post>
<table border=0>
<tr><th align=left>Search from:</th>
    <td><input type=checkbox name=input1 value=name checked>Name</td>
</tr>
<tr><th></th>
    <td><input type=checkbox name=input2 value=title>Title(Post and Reply)</td>
</tr>
<tr><th></th>
    <td><input type=checkbox name=input3 value=detail>Detail</td>
</tr>
<tr></tr>
<tr><th align=left>Room:</th>
     <td><select name = room>
EOF

$sth = $dbh->prepare("select Room,N_room from room");
$sth->execute;
while (@field = $sth->fetchrow_array)  {
         print "<option value=\"$field[0]\">$field[1]</option>\n";
	 }

print <<EOF;
	 <option value="a">All Room</option>
	 </select></td>
</tr>
<tr></tr>
<tr><th align=left>Word for Search:</th>
    <td><input type=text name=word size=20 maxlength=10></td>
</tr>
<!--<tr><th align=left>Display per Page:</th>
    <td><select name = no>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="20">20</option>
	<option value="45">45</option>
	<option value="70">70</option>
	</select></td>
</tr>-->
<tr><th align=left>Date Range:</th>
    <td><select name=date>
	<option value="1">1 Day</option>
	<option value="2">2 Days</option>
	<option value="7">1 Week</option>
	<option value="14">2 Weeks</option>
	<option value="21">3 Weeks</option>
	<option value="30">1 Month</option>
	<option value="90">3 Months</option>
	<option value="180">6 Months</option>
	<option value="365">1 Year</option>
	<option value="all">All Posts</option>
	</select></td>
</tr>
</table>
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
EOF
