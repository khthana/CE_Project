#!/usr/bin/perl

use CGI;
require 'common.pl';

read_conf();

open (FILE,"$CONFIG_DIR$LOG");
@stemp = <FILE>;
close (FILE);
$scount = @stemp;

$query = new CGI;

print	$query->header();

read_template("$RTMT_DIR"."html/dailyall.html");

begin_template();

print "<font color=green size=\"2\">";

for ($si = 0; $si < $scount; $si++) {
	@sarray = split(/ /,$stemp[$si]);
	$sname = $sarray[0];
	print "<input type=\"checkbox\" name=\"$sname\">$sname<br>\n";
}

print "</font>";

end_template();
