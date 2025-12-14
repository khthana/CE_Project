#!/usr/bin/perl

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Input for Search</title></head>
<body>
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
         <option value="1">Room 1</option>
	 <option value="2">Room 2</option>
	 <option value="3">Room 3</option>
	 <option value="4">Room 4</option>
	 </select></td>
</tr>
<tr></tr>
<tr><th align=left>Word for Search:</th>
    <td><input type=text name=word size=20 maxlength=10></td>
</tr>
</table>
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
EOF
