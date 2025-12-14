#!/usr/bin/perl -w
use Getopt::Long;

$BaseDir = "/etc/logrt.d";

# Default config here...
$Config{'logdir'} = "/tmp";
$Config{'debug'} = 0;
$Config{'tmpdir'} = "/tmp";

#############################################################################

sub Usage {
    # Show usage for this program
    print "\nUsage: $0 [--logfile <name>]  [--debug <level>]\n".
	  "            [--help|--usage]    [--service <name>]\n\n";
    print "--logfile <name>: *Name of a logfile definition to report on.\n";
    print "--service <name>: *Name of a service definition to report on.\n";
    print "--debug <level>: Debug Level - High, Med, Low or any #.\n";
    print "--usage or --help: This message.\n";
    print "* = Switch can be specified multiple times...\n\n";
    exit (99);
}

sub PrintStdArray {
    my @ThisArray = @_;
    my $i;
    for ($i=0;$i<=$#ThisArray;$i++) {
	print "[" . $i . "] = " . $ThisArray[$i] . "\n";
    }
}

sub PrintConfig {
    # for debugging, print out config...
    my $ThisKey;
    foreach $ThisKey (keys %Config) {
	print $ThisKey . ' -> ' . $Config{$ThisKey} . "\n";
    }
    print "Service List:\n";
    PrintStdArray @ServiceList;
    print "\n";
    print "LogFile List:\n";
    PrintStdArray @LogFileList;
    print "\n\n";
}

sub PrintServiceData {
    # for debugging...
    my ($ThisKey1,$ThisKey2,$i);
    foreach $ThisKey1 (keys %ServiceData) {
	print "\nService Name: " . $ThisKey1 . "\n";
	foreach $ThisKey2 (keys %{$ServiceData{$ThisKey1}}) {
	    print "   " . $ThisKey2 . " = " . $ServiceData{$ThisKey1}{$ThisKey2} . "\n";
	}
	for ($i=0;$i<=$#{$ServiceData{$ThisKey1}{'logfiles'}};$i++) {
	    print "   Logfile = " . $ServiceData{$ThisKey1}{'logfiles'}[$i] . "\n";
	}
    }
    #@TempArray = $ServiceData{$ThisService}{'logfiles'};
}

sub PrintLogFileData {
    # for debugging...
    my ($ThisKey1,$ThisKey2,$i);
    foreach $ThisKey1 (keys %LogFileData) {
	print "\nLogfile Name: " . $ThisKey1 . "\n";
	foreach $ThisKey2 (keys %{$LogFileData{$ThisKey1}}) {
	    print "   " . $ThisKey2 . " = " . $LogFileData{$ThisKey1}{$ThisKey2} . "\n";
	}
	for ($i=0;$i<=$#{$LogFileData{$ThisKey1}{'logfiles'}};$i++) {
	    print "   Logfile = " . $LogFileData{$ThisKey1}{'logfiles'}[$i] . "\n";
	}
	for ($i=0;$i<=$#{$LogFileData{$ThisKey1}{'archives'}};$i++) {
	    print "   Archive = " . $LogFileData{$ThisKey1}{'archives'}[$i] . "\n";
	}
    }
}

sub ReadConfigFile {
    my $FileName = $_[0];
    my ($ThisLine,$ThisValue,$ThisName);
    while (defined(pop @ReadConfigNames)) {}
    while (defined(pop @ReadConfigValues)) {}
    if ($Config{'debug'} > 5) {
	print "ReadConfigFile: Opening " . $FileName . "\n";
    }
    open (READCONFFILE, $FileName) or die "Cannot open file: " . $FileName . "\n";
    while (defined($ThisLine = <READCONFFILE>)) {
	if ($Config{'debug'} > 9) {
	    print "ReadConfigFile: Read Line: " . $ThisLine;
	}
	$ThisLine =~ s/#.*$//;
	if ( $ThisLine =~ /=/ ) {
	    chomp ($ThisLine);
	    ($ThisName,$ThisValue) = split /=/,$ThisLine;
	    $ThisName =~ s/^\s+//;
	    $ThisName =~ s/\s+$//;
	    $ThisValue =~ s/^\s+//;
	    $ThisValue =~ s/\s+$//;
	    $ThisName = lc($ThisName);
	    $ThisValue = lc($ThisValue);
	    push @ReadConfigNames, $ThisName;
	    push @ReadConfigValues, $ThisValue;
	    if ($Config{'debug'} > 7) {
		print "ReadConfigFile: Name=" . $ThisName . ", Value=" . $ThisValue . "\n";
	    }
	}
    }
    close (READCONFFILE);
}

#############################################################################

# Add / to BaseDir
unless ($BaseDir =~ m=/$=) {
    $BaseDir = $BaseDir . "/";
}

# Load main config file...
if ($Config{'debug'} > 8) {
    print "\nDefault Config:\n";
    PrintConfig;
}


ReadConfigFile ($BaseDir . "conf/rtcheck.conf");
for ($i = 0; $i <= $#ReadConfigNames; $i++) {
    if ($ReadConfigNames[$i] eq "logfile") {
	push @LogFileList, $ReadConfigValues[$i];
    }
    elsif ($ReadConfigNames[$i] eq "service") {
	push @ServiceList, $ReadConfigValues[$i];
    }
    else {
	$Config{$ReadConfigNames[$i]} = $ReadConfigValues[$i];
    }
}

if ($Config{'debug'} > 8) {
    print "\nConfig After Config File:\n";
    PrintConfig;
}

# Options time...

@TempLogFileList = ();
@TempServiceList = ();
$Usage = 0;
$Help = 0;

GetOptions ("l|logfile=s@" => \@TempLogFileList,
	    "s|service=s@" => \@TempServiceList,
	    "D|debug=s"    => \$Config{'debug'},
	    "h|help"       => \$Help,
	    "u|usage"      => \$Usage
	    ) or Usage();

( $Usage or $Help ) and Usage();

if ($Config{'debug'} > 8) {
    print "\nCommand Line Parameters:\n   Log File List:\n";
    PrintStdArray @TempLogFileList;
    print "\n   Service List:\n";
    PrintStdArray @TempServiceList;
    print "\nConfig After Command Line Parsing:\n";
    PrintConfig;
}

if ($#TempLogFileList > -1) {
    @LogFileList = @TempLogFileList;
    for ($i = 0; $i <= $#LogFileList; $i++) {
	$LogFileList[$i] = lc($LogFileList[$i]);
    }
    @ServiceList = ();
}

if ($#TempServiceList > -1) {
    @ServiceList = @TempServiceList;
    for ($i = 0; $i <= $#ServiceList; $i++) {
	$ServiceList[$i] = lc($ServiceList[$i]);
    }
}

if ( ($#ServiceList == -1) and ($#LogFileList == -1) ) {
    push @ServiceList,"all";
}

if ($Config{'debug'} > 5) {
    print "\nConfig After Everything:\n";
    PrintConfig;
}

#############################################################################

# Find out what services are defined...
opendir(SERVICESDIR,$BaseDir . "conf/services") or die $BaseDir . "conf/services/, no such directory.";
while (defined($ThisFile = readdir(SERVICESDIR))) {
    unless (-d $BaseDir . "conf/services/" . $ThisFile) {
	$ThisService = $ThisFile;
	if ($ThisService =~ s/\.conf$//i) { 
	    $ThisService = lc($ThisService);
	    push @AllServices, $ThisService;
	    ReadConfigFile($BaseDir . "conf/services/" . $ThisFile);
	    $NumLogs = 0;
	    for ($i = 0; $i <= $#ReadConfigNames; $i++) {
		if ($ReadConfigNames[$i] eq "logfile") {
		    $ServiceData{$ThisService}{'logfiles'}[$NumLogs] = $ReadConfigValues[$i];
		    $NumLogs++;
		}
		else {
		    $ServiceData{$ThisService}{$ReadConfigNames[$i]} = $ReadConfigValues[$i];
		}
	    }
	}
    }
}
closedir(SERVICESDIR);

# Find out what logfiles are defined...
opendir(LOGFILEDIR,$BaseDir . "conf/logfiles") or die $BaseDir . "conf/logfiles/, no such directory.";
while (defined($ThisFile = readdir(LOGFILEDIR))) {
    unless (-d $BaseDir . "conf/logfiles/" . $ThisFile) {
	$ThisLogFile = $ThisFile;
	if ($ThisLogFile =~ s/\.conf$//i) { 
	    push @AllLogFiles, $ThisLogFile;
	    ReadConfigFile($BaseDir . "conf/logfiles/" . $ThisFile);
	    $LogFiles = 0;
	    for ($i = 0; $i <= $#ReadConfigNames; $i++) {
		if ($ReadConfigNames[$i] eq "logfile") {
		    $LogFileData{$ThisLogFile}{'logfiles'}[$LogFiles] = $ReadConfigValues[$i];
		    $LogFiles++;
		}
	    }
	}
    }
}
closedir(LOGFILEDIR);

# Find out what shared functions are defined...
opendir(SHAREDDIR,$BaseDir . "scripts/shared") or die $BaseDir . "scripts/shared/, no such directory.";
while (defined($ThisFile = readdir(SHAREDDIR))) {
    unless (-d $BaseDir . "scripts/shared/" . $ThisFile) {
	push @AllShared, lc($ThisFile);
    }
}
closedir(SHAREDDIR);

if ($Config{'debug'} > 5) {
    print "\nAll Services:\n";
    PrintStdArray @AllServices;
    print "\nAll Log Files:\n";
    PrintStdArray @AllLogFiles;
    print "\nAll Shared:\n";
    PrintStdArray @AllShared;
}

#############################################################################

# Time to expand @ServiceList, using @LogFileList if defined...

# 'all' *only* works if no others are specified...
if ( ($ServiceList[0] eq "all") and ($#ServiceList == 0) ) {
    # This means we are doing *all* services...
    @ServiceList = @AllServices;
    while (defined(pop @LogFileList)) {};
}
else {
    while (defined($ThisOne = pop @LogFileList)) {
	foreach $ThisService (keys %ServiceData) {
	    for ($i = 0; $i <= $#{$ServiceData{$ThisService}{'logfiles'}}; $i++) {
		if ( $ServiceData{$ThisService}{'logfiles'}[$i] eq $ThisOne ) {
		    push @ServiceList,$ThisService;
		}
	    }
	}
    }
    @TempServiceList = sort @ServiceList;
    @ServiceList = ();
    $LastOne = "";
    while (defined($ThisOne = pop @TempServiceList)) {
	unless ( ($ThisOne eq $LastOne) or ($ThisOne eq "all") ) {
	    push @ServiceList,$ThisOne;
	}
	$LastOne = $ThisOne;
    }
}

# Now lets fill up @LogFileList again...
foreach $ServiceName (@ServiceList) {
   foreach $LogName ( @{$ServiceData{$ServiceName}{'logfiles'} } ) {
       unless ( grep m/$LogName/, @LogFileList ) { 
	   push @LogFileList, $LogName;
       }
   }
}

if ($Config{'debug'} > 7) {
    print "\n\nAll Service Data:\n";
    PrintServiceData;
    print "\nServices that will be processed:\n";
    PrintStdArray @ServiceList;
    print "\n\n";
    print "\n\nAll LogFile Data:\n";
    PrintLogFileData;
    print "\nLogFiles that will be processed:\n";
    PrintStdArray @LogFileList;
    print "\n\n";
}

#############################################################################

# Create the temporary directory...
unless ($Config{'tmpdir'} =~ m=/$=) {
    $Config{'tmpdir'} .= "/";
}
$TempDir = $Config{'tmpdir'} . "rtcheck." . $$ . "/";
if ( -d $TempDir ) {
    rmdir ($TempDir);
}
if ( -e $TempDir ) {
    unlink ($TempDir);
}
if ($Config{'debug'}>7) {
    print "\nMaking Temp Dir: " . $TempDir . "\n";
}
mkdir ($TempDir,0700);

#############################################################################

# Set up the environment...

$ENV{'RTCHECK_TEMP_DIR'} = $Config{'tmpdir'};
$ENV{'RTCHECK_DEBUG'} = $Config{'debug'};
$ENV{'RTCHECK_BASEDIR'} = $BaseDir; 

#############################################################################

unless ($Config{'logdir'} =~ m=/$=) {
    $Config{'logdir'} .= "/";
}

# Okay, now it is time to do pre-processing on all the logfiles...

foreach $LogFile (@LogFileList) {
    @FileList = @{$LogFileData{$LogFile}{'logfiles'}};
    $FileText = "/bin/cat ";
    foreach $ThisFile (@FileList) {
	if ($ThisFile =~ m=^/=) {
	    $FileText .= ($ThisFile . " ");
	}
	else {
	    $FileText .= ( $Config{'logdir'} . $ThisFile . " ");
	}
    }
    $FilterText = " 2>/dev/null ";
    opendir (LOGDIR,$BaseDir . "scripts/logfiles/" . $LogFile);
    @DirectoryList = readdir(LOGDIR);
    closedir (LOGDIR);
    foreach $ThisDir (sort @DirectoryList) {
	unless ( -d $BaseDir . "scripts/logfiles/" . $LogFile . "/" . $ThisDir) {
	    $FilterText .= ("| " . $BaseDir . "scripts/logfiles/" . $LogFile . "/" . $ThisDir);
	}
    }
    $Command = $FileText . $FilterText . ">" . $TempDir . $LogFile;
    if ($Config{'debug'} > 4) {
	print "\nPreprocessing LogFile: " . $LogFile . "\n" . $Command . "\n";
    }
    `$Command`;
}

#############################################################################

foreach $Service (@ServiceList) {
    $FilterText = "";
    @FileList = @{$ServiceData{$Service}{'logfiles'}};
    $FileText = " ( /bin/cat ";
    foreach $ThisFile (@FileList) {
	$FileText .= ( $TempDir . $ThisFile . " ");
    }
    if ( -f $BaseDir . "scripts/services/" . $Service ) {
	$FilterText .= ("| " . $BaseDir . "scripts/services/" . $Service );
    }
    else {
	die "Can't open: " . $BaseDir . "scripts/services/" . $Service;
    }
    $Command = $FileText . $FilterText . " ) 2>&1 "; 
    if ($Config{'debug'}>4) {
	print "\nProcessing Service: " . $Service . "\n" . $Command . "\n";
    }
    `$Command`;
}

#############################################################################

# Get rid of temp directory...
if ($Config{'debug'}<100) {
   `rm -rf $TempDir`;
}

exit(0);
