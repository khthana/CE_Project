#!/usr/bin/perl
push(@INC,"../cgi");
require "cgi_lib2.cgi";
print "Content-type:text/html\n\n";   
print "<html><body>";

$mailprog="/usr/lib/sendmail";

&ReadParse(*input);

print "<h2>Thank you</h2><br>";

open( MAIL , "|$mailprog -t") || die("<h2>Can't open $mailprog</h2><br>");
#print MAIL "To: $input{Target}\n";
print MAIL "To: pop\@csqbbs.kmitl.ac.th\n";
#print MAIL "From: $input{Email}\n";
print MAIL "From: tong\n";
#print MAIL "Subject: $input{Subject}\n";
print MAIL "ha..ha...\n";
#print MAIL "$input{Comments}\n";
print MAIL "content ha.ha\n";
close( MAIL );
