#!/use/bin/perl
$CONFIG_DIR	= '/etc/RTMT/';
$CONFIG		= 'rtmt.conf';
$LOG		= 'rtmt.log';

$LOGIN_NAME	= 'root';
$LOGIN_PASSWD	= '';

$RTMT_DIR	= '/usr/local/rtmt/';

$INSERT_STRING	= "\<\!\-\-RTMT\-\-\>";

$template_pos	= 0;
$template_line	= 0;

return 1;

sub read_conf() {
	open(FILE, "$CONFIG_DIR$CONFIG");
	@lines = <FILE>;
	close(FILE);
	foreach (@lines) {
		chop($_);
		if ($_ =~ /^\t*RTMT_DIR\t*=\t*/i) {
			$RTMT_DIR = $';
		} elsif ($_ =~ /^\t*LOGIN_NAME\t*=\t*/i) {
			$LOGIN_NAME = $';
		} elsif ($_ =~ /^\t*LOGIN_PASSWD\t*=\t*/i) {
			$LOGIN_PASSWD = $';
		}
	}
}

sub read_template() {
	my ($file_name) = @_;
	my ($line, $i) = (0);
	
	open(FILE, $file_name);
	@template = <FILE>;
	close(FILE);
	
	$template_line = @template;
	
	for ($i=0; $i<$template_line; $i++) {
		if ($template[$i] =~ /$INSERT_STRING/i) {
			$template_pos = $i;
			$i = $template_line;
		}
	}
}

sub begin_template() {
	my ($i) = (0);
	
	for ($i=0; $i<$template_pos; $i++) {
		print $template[$i];
	}
}

sub end_template() {
	my ($i) = (0);
	
	for ($i=$template_pos+1; $i<$template_line; $i++) {
		print $template[$i];
	}
}
