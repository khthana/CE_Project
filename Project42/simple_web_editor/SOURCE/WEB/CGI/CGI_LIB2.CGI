#!/usr/bin/perl

sub ReadParse {
	local (*input) = @_ if @_;
	local ($form_data,$length,$c,$start,$name,$value,$num);

#Get form data
if ($ENV{'REQUEST_METHOD'} eq "get"){# Using GET METHOD
	# Save data to FORM_DATA
	$form_data = $ENV{'QUERY_STRING'};
} else { # Using Post
	# How much data to read?
	$length = $ENV{'CONTENT_LENGTH'};
	if ($length > "32768"){
		die "major network spam,stopped";
	}
	while ($length--){
		$c .= getc(STDIN); # Get next character
		if ($c eq "=" || $c eq "&") { # Check for start/end of
					      # value
			$start = "0";
			} else {
				$start++
			}
			if ($start <= "8192") { # 8k should be enough !
				$form_data = $c;
			}
	} # End While
}# End Else

# Parse data into NAME=VALUE pairs and jam into an associative array

foreach (split(/&/,$form_data)) {
	($name,$value) = split(/=/,$_);
	$name =~ s/\+/ /g;
	$name =~ s/%([0-9|A-F]{2})/pack(c,hex($1))/eg;
	$value =~ s/\+/ /g;
	$value =~ s/%([0-9|A-F]{2})/pack(c,hex($1))/eg;
	# Find Unique Name
	$num = 0;
	while ($input{$name} ne "") {
		$num++;
		$name =~ s/\.([0-9]+$)|$/\.$num/;
	}
	# Store name=value pair
	$input{$name} = $value;
}
return scalar(@input);
}
 
1; # return true
