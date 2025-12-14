#!/usr/bin/perl

open (FILE,"/etc/RTMT/RTMT.conf");
@stemp = <FILE>;
close (FILE);
$scount = @stemp;

print "Content-type:text/html\n\n";
print "<html><head><title>test select </title></head>";
print "<body backgroung=\"bg3.jpg\">";

print " <form method=\"post\" action=\"/cgi-bin/yearselect.pl\">\n";
print " <h1>	Select your IP Adddress </h1>\n";

for ($si = 0; $si < $scount; $si++) {
	@sarray = split(/ /,$stemp[$si]);
	$sname = $sarray[0];
print "<input type = radio value = \"$sname\" name = \"ip\">$sname<br>";
}				#end for $si
print "<hr>";
print "<h3> type of oid to monitor </h3><br>";

#************ type of oid to monitor ******************************

print"<input type = radio value = \"1\"name = \"oid\" checked>In Out Packet<br>";
print"<input type = radio value = \"2\"name = \"oid\">In Out Error<br>";	


	
print "<input type = submit >";
print "</form>";	
print "</body>";
print "</html>\n";
