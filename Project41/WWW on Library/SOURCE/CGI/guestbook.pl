#!/usr/bin/perl
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

@pairs = split(/&/, $buffer);
$size = @pairs;

foreach $pair (@pairs) {
   ($name, $value) = split(/=/, $pair);

   # Un-Webify plus signs and %-encoding
   $value =~ tr/+/ /;
   $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

   $FORM{$name} = $value;
}

  print "Content-Type: text/html\n\n";
  print "<html>\n";
  print "<body>\n";
  

$guestbook = "/dsk/home/esl_lib/lib/guestbook.html";

open (FILE,"$guestbook");
@LINES=<FILE>;
close(FILE);
$SIZE=@LINES;

# Open Link File to Output
open (HTMLF,">$guestbook");
 for ($i=0;$i<=$SIZE;$i++){
   $_ = $LINES[$i];       
   if (/<!-- begin -->/) { 
     print HTMLF "$FORM{'name'}<br>\n";
     print HTMLF "<a href=mailto:$FORM{'email'}>$FORM{'email'}</a> $FORM{'Comment'}<i>$ENV{'REMOTE_HOST'}</i><hr>\n";
     print HTMLF "\n<!-- begin -->\n";
     print  "$FORM{'name'}<br>\n";
     print  "<a href=mailto:$FORM{'email'}>$FORM{'email'}</a> $FORM{'Comment'}<i>$ENV{'REMOTE_HOST'}</i><hr>\n";
   }
   else {
      print HTMLF $_;
      print $_;
   }
}

close (HTMLF);
  print "</body></html>\n";

