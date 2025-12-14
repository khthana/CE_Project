#!/usr/local/bin/perl
# 
##############################################################
# Program By: Thammanoon Wongtheeres (s8013273@@kmitl.ac.th)
# KMIT'L Computer Engineering 3P
# program displays data entries.
##############################################################
#
# config data file.

require "reg-config.pl";
####################################################

&GetData;
&Translate;
&WhatToDo;

################
# sub routines #
################
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
$loginname = $FORM{'loginname'};
$usrpassword = $FORM{'usrpassword'};
$new_loginname = $FORM{'new_loginname'};
$new_password = $FORM{'new_password'};

$action = $FORM{'action'};

$new_base_url = $FORM{'new_base_url'};
$new_cgi_url = $FORM{'new_cgi_url'};
$new_show_url = $FORM{'new_show_url'};
$new_admin_cgi_url = $FORM{'new_admin_cgi_url'};
$new_admin_name = $FORM{'new_admin_name'};
$new_admin_email = $FORM{'new_admin_email'};
$new_notify = $FORM{'new_notify'};
$new_thanks = $FORM{'new_thanks'};
$new_thanks_message = $FORM{'new_thanks_message'};
$new_notify_message = $FORM{'new_notify_message'};

$pid = $FORM{'pid'};
	}
sub WhatToDo {
if (! $action) {
	&PrintLogin;
		}
	elsif ($action =~ /check/) {
		&Check;
		   }
	elsif ($action =~ /edit/) {
		&Edit;
		   }
	elsif ($action =~ /showconfig/) {
		&ShowConfig;
			}
		elsif ($action =~ /remove/) {
			&PrintRemove("Remove entries");
				}
		elsif ($action =~ /Delete/) {
			&DeleteEntry;
				}
else { &Error("Sorry, unspecified action"); }
		}
sub PrintLogin {

if ($chpass cmp 1) {
print "Content-type: text/html\n\n";}
print "<html><head><title>Login</title></head>\n";
print "<body background=bg2.gif link=Navy vlink=Maroon>\n";
print "<font size=+2 face=Arial><b> Please Login...</b></font><p>\n";
print "<form action=\"reg-admin.pl\" method=post>\n";
print "<font size=2 face=Arial><b>User name:<br>\n";
print "<input type=text name=\"loginname\" size=40 ><br>\n";
print "Password:<br>\n";
print "<input type=password name=\"usrpassword\" size=40 >\n";
print "<p><input type=submit value=\" Submit \">\n";
print "<input type=reset value=\" Reset \">\n";
print "<br><br><a href=\"$show_url\">HOME</a>\n";
print "<input type=hidden name=\"action\" value=\"check\">\n";
print "</form>\n";
&PrintBottom;
	}
sub Check {
if ($loginname eq $usrname && $usrpassword eq $password) {
	&PrintRemove("Test Remove");
		}
else {  &Incorrect;
		&PrintLogin;  }
		}
sub ShowConfig {
print "Content-type: text/html\n\n";
print "<html><head><title>Remove Suggestion...</title></head>\n";
print "<body background=\"bg2.gif\">\n";
print "<table width=600 cellpadding=3 cellspacing=0 border=0>\n";
print "<font size=+2 face=Arial><b>Edit Configuration.</b></font><br>\n";
print "<hr><form action=\"reg-admin.pl\" method=post>\n";
print "<input type=submit value=\" Remove Entries. \">\n";
print "<input type=hidden name=\"action\" value=\"remove\">\n";
print "</form><hr>\n";
print "<tr><td colspan=2 bgcolor=blue><font size=+2 color=White face=Arial>
		<b>Configuration</font></b></td></tr>\n";
print "<form action=\"reg-admin.pl\" method=post>\n";
print "<tr><td width=150><b> Base URL: </b></td>\n";
print "<td width=350><input type=text name=\"new_base_url\" size=50 value=\"$base_url\"></td></tr>\n";
print "<tr><td width=150><b> CGI URL: </b></td>\n";
print "<td width=350><input type=text name=\"new_cgi_url\" size=50 value=\"$cgi_url\"></td></tr>\n";
print "<tr><td width=150><b> Show CGI URL: </b></td>\n";
print "<td width=350><input type=text name=\"new_show_url\" size=50 value=\"$show_url\"></td></tr>\n";
print "<tr><td width=150><b> Admin CGI URL: </b></td>\n";
print "<td width=350><input type=text name=\"new_admin_cgi_url\"size=50  value=\"$admin_cgi_url\"></td></tr>\n";
print "<tr><td colspan=2 bgcolor=Blue><font size=+2 color=White face=Arial>
		<b>User Preferences</b></font></td></tr>\n";
print "<tr><td width=150><b> Admin. Name: </b></td>\n";
print "<td width=350><input type=text name=\"new_admin_name\" size=50 value=\"$admin_name\"></td></tr>\n";
print "<tr><td width=150><b> Admin. E-mail: </b></td>\n";
print "<td width=350><input type=text name=\"new_admin_email\"size=50  value=\"$admin_email\"></td></tr>\n";
print "<tr><td width=150><b> User Name: </b></td>\n";
print "<td width=350><input type=text name=\"new_loginname\" size=50  value=\"$usrname\"></td></tr>\n";
print "<tr><td width=150><b> Password: </b></td>\n";
print "<td width=350><input type=password name=\"new_password\" size=50 value=\"$password\"></td></tr>\n";
print "<tr><td colspan=2 bgcolor=Blue><font size=+2 color=White face=Arial>
		<b>Mail Options</b></font></td></tr>\n";
print "<tr><td width=150><b> Notify me of each new entry? </b></td>\n";
print "<td width=350>\n";

if($notify eq "yes") {
#print "<input type="radio" name=\"new_notify\" value=\"yes\"> Yes\n";
#print "<input type="radio" name=\"new_notify\" value=\"yes\"> Yes\n";
#print "<input type="radio" name=\"new_notify\" value=\"no\"> No</td></tr>\n";
		}
else {
print "<input type=checkbox name=\"new_notify\" value=\"yes\"> Yes\n";
print "<input type=checkbox checked name=\"new_notify\" value=\"no\"> No</td></tr>\n";
		}
print "<tr><td width=150> <b> Send automated Thanks message? </b></td>\n";

if($thanks eq "yes") {
print "<td width=350><input type=checkbox checked name=\"new_thanks\" value=\"yes\">$font Yes\n";
print "<input type=checkbox name=\"new_thanks\" value=\"no\"> No</td></tr>\n";
		}
else {
print "<td width=350><input type=checkbox name=\"new_thanks\" value=\"yes\">$font Yes\n";
print "<input type=checkbox checked name=\"new_thanks\" value=\"no\"> No</td></tr>\n";
		}

if($thanks eq "yes") {
print "<td width=150> <b> Thanks message: </b></td>\n";
print "<td width=350><textarea name=\"new_thanks_message\" cols=40 rows=3 wrap=on>$thanks_message</textarea></td></tr>\n";
	}
if($notify eq "yes") {
print "<td width=150> <b> Notify message: </b></td>\n";
print "<td width=350><textarea name=\"new_notify_message\" cols=40 rows=3 wrap=on>$notify_message</textarea></td></tr>\n";
	}
	
print "</table><br><input type=hidden name=\"action\" value=\"edit\">\n";
print "<input type=submit value=\" Save Changes \">\n";
print "</form>\n";
&PrintBottom;
		}
		
sub PrintTop {
print "Content-type: text/html\n\n";
print "<html><head><title>Registry Admin - $_[0]</title></head>\n";
print "<body bgcolor=White>\n";
print "<font size=+3 face=Arial><b>Registry Administration</b><br></font>\n";
print "<form action=\"reg-admin.pl\" method=post>\n";
print "<input type=submit value=\" remove entries \">\n";
print "<input type=hidden name=\"action\" value=\"remove\">\n";
print "</form>\n";
print "<form action=\"reg-admin.pl\" method=post>\n";
print "<input type=submit value=\" edit registry config. \">\n";
print "<input type=hidden name=\"action\" value=\"showconfig\">\n";
print "<hr noshade size=1>\n";
print "<font size=2 ><b> $_[0] </b></font><p>\n";
print "<hr noshade size=1>\n";
	}
sub PrintBottom {
print "</body></html>\n";
	}
sub Error {
&PrintTop($_[0]);
&PrintBottom;
exit;
	}
	
# Incorrect Password #	
sub Incorrect  {
print "Content-type: text/html\n\n";
print "<html><head><title>Incorrect Password</title></head>\n";
print "<body bgcolor=pink>\n";
print "<font size=+2 ><b>รหัสไม่ถูกต้องกรุณาป้อนใหม่อีกครั้ง!!!</b></font><p>\n";
print "<hr noshade size=1>\n";
$chpass = 1;
	}	
	
### Remove Suggestion ###
	
sub PrintRemove {

print "Content-type: text/html\n\n";
print "<html><head><title>Remove Suggestion...</title></head>\n";
print "<body background=\"bg2.gif\">\n";
print "<table width=450 cellpadding=3 cellspacing=1 border=0>\n";
print "<font size=+2 face=Arial><b>Remove Suggestion...</b></font>";
print "<hr><form action=\"reg-admin.pl\" method=post>\n";
print "<input type=submit value=\" Edit Config. \">\n";
print "<input type=hidden name=\"action\" value=\"showconfig\">\n";
print "</form><hr>\n";
open(DATA, "reg-data.txt") || die;
while(<DATA>) {
chop;
@all = split(/\n/);
foreach $line (@all) {
($id, $data) = split(/=/, $line);
($fname, $lname, $email, $url, $book, $service, $date ,$time) = split(/&&/, $data);
print "<form action=\"$admin_cgi_url\" method=post>\n";
print "<tr><td><img src=\"sb_yel.gif\" border=0 >\n";
print "<a href=\"mailto:$email\">$fname $lname</a><br>\n";
if($book) {print "หนังสือที่แนะนำ: $book<br>\n";		}
if($service) {	print "บริการที่แนะนำ: $service<br>\n";	  }
if($url) {print "Homepage : <a href=\"$url\" target=\"_top\">$url</a><BR>\n";}
print "วันที่ $date เวลา $time น.<br></td>\n";		 
print "<td><input type=submit value=\"Delete\" name=\"action\"></tr>
       <input type=hidden name=\"pid\" value=\"$id\">\n</form>";
print "<tr><td><hr></td></tr>\n";
		}
	}
print "</table>\n";
print "<a href=\"$base_url\">Back</a>\n";
&PrintBottom;
	}
		
sub DeleteEntry {
open(DATA, "reg-data.txt") || &Error("Cannot find your database");
while(<DATA>) {
chop;
@all = split(/\n/);
foreach $line (@all) {
($id, $data) = split(/=/, $line);
$ENTRY{$id} = $data;
	}
  }
close(DATA);
delete($ENTRY{$pid});
open(DATA, ">reg-data.txt") || &Error("Cannot find your database");
foreach $key (sort(keys %ENTRY)) {
print DATA "$key = $ENTRY{$key}\n";
	}
close(DATA);
&PrintRemove;
	}

### Edit Config ####	
sub Edit {
open(CONFIG, ">reg-config.pl") || &Error("Can't open config file");
print CONFIG "# Configuration file\n";
print CONFIG "# Program by Thammanoon Wongtheeres\n";
print CONFIG "# KMIT'L Computer Engineering\n\n";

print CONFIG "\$base_url = \"$new_base_url\"\;\n";
print CONFIG "\$cgi_url = \"$new_cgi_url\"\;\n";
print CONFIG "\$show_url = \"$new_show_url\"\;\n";
print CONFIG "\$admin_cgi_url = \"$new_admin_cgi_url\"\;\n";
print CONFIG "\$admin_name = \'$new_admin_name\'\;\n";
print CONFIG "\$admin_email = \'$new_admin_email\'\;\n";
print CONFIG "\$notify = \"$new_notify\"\;\n";
print CONFIG "\$thanks = \"$new_thanks\"\;\n";
print CONFIG "\$usrname = \'$new_loginname\'\;\n";
print CONFIG "\$password = \'$new_password\'\;\n";

if(! $new_thanks_message) {
print CONFIG "\$thanks_message = \"1\"\;\n";
		}
else {
print CONFIG "\$thanks_message = \"$new_thanks_message\"\;\n";
		}
if(! $new_notify_message) {
print CONFIG "\$notify_message = \"1\"\;\n";
		}
else {
print CONFIG "\$notify_message = \"$new_notify_message\"\;\n";
		}
	close(CONFIG);
&ShowConfig;
		}
