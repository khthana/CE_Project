#!/usr/bin/perl

push(@INC,"/usr/local/DBI-1.13/");

use DBI;

$database='mysql';
$user='root';
$password='hornacek66';
$table='user';
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
$sth = $dbh->prepare("SELECT* FROM $table");
$sth->execute;
while ( @field = $sth->fetchrow_array ) {
	print "Name: $field[0]\n";
	print "Address: $field[1]\n";
}
$sth->finish;
$dbh->disconnect;
exit
