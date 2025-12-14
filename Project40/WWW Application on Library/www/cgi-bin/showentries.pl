#!/usr/local/bin/perl
# 
##############################################################
# Program By: Thammanoon Wongtheeres (s8013273@@kmitl.ac.th)
# KMIT'L Computer Engineering 3P
# program displays data entries.
##############################################################
print "Content-type: text/html\n\n";

require "reg-config.pl";
print "<TITLE>Library Guestbook</TITLE>";
print "<BODY BGCOLOR=00FFFF>";
print "<table width=450 cellpadding=3 cellspacing=1 border=0>\n";
print "<tr><td>\n";
print "หอสมุดกลางพระจอมเกล้า ลาดกระบัง";
print "<BR>";
open(DATA, "reg-data.txt") || die;
while(<DATA>) {
chop;
@all = split(/\n/);
foreach $line (@all) {
($id, $data) = split(/=/, $line);
($fname, $lname, $email, $url, $book, $service, $date ,$time) = split(/&&/, $data);
print "<a href=\"mailto:$email\">$fname $lname</a><br>\n";

if($book) {
print "หนังสือที่แนะนำ: $book<br>\n";
		}

if($service) {		
print "บริการที่แนะนำ: $service<br>\n";
			  }
if($url) {
print "Homepage : <a href=\"$url\" target=\"_top\">$url</a><BR>\n";
	     }
print "วันที่ $date เวลา $time น.<br>\n";		 
print "<HR><p>\n";
		}
	}
print "<a href=\"$base_url\">Back</a>\n";
print "</tr></td></table>\n";