#!/usr/bin/perl

use CGI;
require 'common.pl';

read_conf();


$query = new CGI;

print	$query->header();

read_template($RTMT_DIR."html/delete.html");

begin_template();

open(FILE, "$CONFIG_DIR$LOG");
@lines = <FILE>;
close(FILE);
$line = @lines;

for ($i = 0; $i < $line; $i++) {
	@buffer = split(/ /,$lines[$i]);
	$ip = $buffer[0];
	print  "<input type=\"radio\" value=\"$ip\" name=\"ip\"> $ip <br>";
}					#end for $ki 
  		
end_template();
