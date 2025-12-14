#!/usr/bin/perl

&div(35);
print "$a\n";

sub div($a) {
#$a= 35;
$b= $a % 10;
$a= $a - $b;
$b= $a / 10;
#return $b;
}
