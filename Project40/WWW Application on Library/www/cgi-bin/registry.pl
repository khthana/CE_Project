#!/usr/local/bin/perl
# ##########################################################
# Program By: Thammanoon Wongtheeres (s8013273@kmitl.ac.th)
# KMIT'L Computer Engineering 3P
# program add new the entry to the database. 
############################################################
#
# Get Config file
require "reg-config.pl";

########################################################

&GetData;
&Translate;
&GetDate;
&WhatToDo;


sub GetData {
read(STDIN, $input, $ENV{'CONTENT_LENGTH'});
	@pairs = split(/&/, $input);
		foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		
		$name =~ tr/+/ /;
		$name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ tr/+/ /;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
			$FORM{$name} = $value;
			}
   	}
sub Translate {
$fullname = $FORM{'fullname'};
($fname, $lname) = split(/ /, $fullname);
$email = $FORM{'email'};
$url = $FORM{'url'};
$book = $FORM{'book'};
$service = $FORM{'service'};
$action = $FORM{'action'};

if(! $fullname) {
	&Error("กรุณาใส่ชื่อของท่านด้วย"); 		
			    }

if(! $email) {
	&Error("กรุณาใส่ E-mail Address ของท่านที่ทางเราสามารถจะติดต่อกลับด้วย");
   		     }

if( $service)  { }
elsif (! $book)
    {
	&Error("กรุณาเพิ่มเติมความคิดเห็นของท่านให้ทางสำนักหอสมุดกลาง");
				}
$comments =~ s/\cM//g;
$comments =~ s/\n/  /g;
	}
sub WhatToDo {
	if($action =~ /add/) {
		&AddEntry;
			}
		else { &Error("Sorry, unspecified action"); }

if($notify eq "yes") {
	&Notify;
	    }
	if($thanks eq "yes") {
		&Thanks;
			}
	}
sub AddEntry {
open(NUMBERS, "id.txt") || &Error("Sorry, couldn't find id file");
$number = <NUMBERS>;
	close(NUMBERS);
	++$number;
open(NUMBERS, ">id.txt") || &Error("no id file found");
	print NUMBERS "$number\n";
		close(NUMBERS);

## New Entry ###
open(DATA, "reg-data.txt");
@FILE = <DATA>;
close(DATA);		
open(DATA, ">reg-data.txt") || &Error("no database found");
print DATA "$number=$fname&&$lname&&$email&&$url&&$book&&$service&&$date&&$time\n";
print DATA @FILE; 
close(DATA);
	
#### HTML ####

### Display Thank you ###
print "Content-type: text/html\n\n";
print "<html><head><title>ขอบคุณคุณ $fname!</title>\n";
print "<body bgcolor=00FFFF vlink=Maroon link=Navy>\n";
print "<font size=+1 >ขอบคุณคุณ $fname เป็นอย่างมาก ทางสำนักหอสมุดกลางจะนำความคิดเห็นของท่านไปปรับปรุงการบริการต่อไป</font><p>\n";
print "<HR><font size=3 ><a href=\"$show_url\">ดูข้อเสนอแนะ</a>\n";
print "</body></html>\n";
}
sub GetDate {
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
	if ($hour < 10) { $hour = "0$hour"; }
	if ($min < 10) { $min = "0$min"; }
	if ($sec < 10) { $sec = "0$sec"; }
$date = "$mday/$mon/$year";
$time = "$hour:$min";
			}
### Mail: Admin ###
sub Notify {
open(MAIL, "| $mailprog -t") || die;
print MAIL "To: $admin_name <$admin_email>\n";
print MAIL "From: $admin_email\n";
print MAIL "Subject: New entry\n";
print MAIL "$notify_message\n";
	close(MAIL);
		}
### Mail: Thank you ###
sub Thanks {
open(MAIL, "| $mailprog -t") || die;
print MAIL "To: $fullname <$email>\n";
print MAIL "From: $admin_name <$admin_email>\n";
print MAIL "Subject: Thanks!\n";
print MAIL "----this is an automated response----\n\n";
print MAIL "$thanks_message\n";
	close(MAIL);
		}
### Display Error ###		
sub Error {
print "Content-type: text/html\n\n";
print "<html><head><title>ข้อมูลผิดพลาด</title></head>\n";
print "<body bgcolor=White>\n";
print "<font size=+2 face=Arial><b>Sorry!</b></font><p>\n";
print "<font size=+1>$_[0]</font></p>\n";
print "</body></html>\n";
exit;
		}
