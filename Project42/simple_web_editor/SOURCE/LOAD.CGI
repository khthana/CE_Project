#!/usr/bin/perl
push(@INC,"../tmp/"); 
require('path.cgi');

&pathy();

$thisurl     = $ENV{'SERVER_URL'}.$ENV{'SCRIPT_NAME'};  
$upload_dir  = '/home/httpd/htdocs/$tmp';       # location for uploaded files
$upload_url  = '/home/httpd/htdocs/$tmp';        # location for uploaded files
$authorurl   = 'steveh@pbsi.com'; # for the mail-to tag

read_net_input();  
handle_upload();


sub read_net_input 
{
    local ($i, $loc, $key, $val, $input);
    local($f,$header, $header_body, $len, $buf); 

    if ($ENV{'REQUEST_METHOD'} eq "GET")
    { $input = $ENV{'QUERY_STRING'}; }
    elsif ($ENV{'REQUEST_METHOD'} eq "POST")
    {  
	# Need to read TILL we got all bytes, bug fixed in v00.02
	$len = 0;
	$input = ''; 
	while( $len != $ENV{'CONTENT_LENGTH'} ) {
	    $buf = ''; 
	    $len += sysread(STDIN, $buf, $ENV{'CONTENT_LENGTH'});
	    $input .= $buf; 
	}
    }

    # conform to RFC1867 for upload specific 
    if( $ENV{'CONTENT_TYPE'} =~ /multipart\/form-data; boundary=(.+)$/ ) {
	$boundary = '--'.$1;  # please refer to RFC1867 
	@list = split(/$boundary/, $input); 

	$header_body = $list[1]; 
	$header_body =~ /\r\n\r\n|\n\n/; # separate header and body 
	$header = $`;        # front part
	$body   = $';        # rear part
 	$body =~ s/\r\n$//;  # the last \r\n was put in by Netscape
	$GLOBAL{'FILE_CONTENT'} = $body;  

	# open(FD,">input.txt"); print FD $input; close(FD);  # for tracking
	# parse header
	$header =~ /filename=\"(.+)\"/; 
	$GLOBAL{'FILE_NAME'} = $1; 
	$GLOBAL{'FILE_NAME'} =~ s/\"//g; # remove "s
        $GLOBAL{'FILE_NAME'} =~ s/\s//g; # make sure no space(include \n, \r..) in the file name 

	# parse trailer
	for( $i=2; $list[$i]; $i++) { 
	    $list[$i] =~ s/^.+name=$//; 
	    $list[$i] =~ /\"(\w+)\"/; 
	    $GLOBAL{$1} = $'; 
	}

	return 1; 
    }

    urldecode($input); 

    1;
} # end of read_net_input 

sub urldecode 
{
    local($in) = @_; 
    local($i, @input_list); 

    @input_list = split(/&/,$in);

    foreach $i (@input_list) {
        $i =~ s/\+/ /g;      # Convert plus's to spaces

        # Convert %XX from hex numbers to alphanumeric
        $i =~ s/%(..)/pack("c",hex($1))/ge;

        # Split into key and value.
        $loc = index($i,"=");
        $key = substr($i,0,$loc);
        $val = substr($i,$loc+1);
        $GLOBAL{$key} = $val;
    }

    1;
} # end of urldecode 

sub show_file_not_found
{

    print "Content-Type: text/html\n\n";   
    print "<TITLE>Not Found</TITLE><H1>Not Found</H1> The requested object does not exist on this server. The link you followed is either outdated, inaccurate, or the server has been instructed not to let you have it. Connection closed by foreign host.\n"








; 
    
    exit;  
    
} # show_file_not_found

sub show_upload_failed 
{

    local($reason) = @_; 

    print "Content-Type: text/html\n\n";  
    print "<body bgcolor=white>\n";
    print "<TITLE>Upload Failed</TITLE><center><H1>Upload Failed</H1></center>";
    print "The requested object was not uploaded to the server. <br>\n";
    print "Reason : <b>$reason.</b> The server may have decided not let you write to the directory specified. Please contact the web master for this 
problem. Connection closed by foreign host.\n"; 
    
    exit;  
}
sub repeat_file_name 
{

    local($reason) = @_; 

    print "Content-Type: text/html\n\n";  
    print "<body bgcolor=white>\n";
    print "<TITLE>Upload Failed</TITLE><center><H1>Upload Failed</H1></center>";
    print "This file name already existed in directory. Please change upload file's\n";
    print "name differently. but if you want to replace the old file contact administartor. \n";
    print "<FORM METHOD=POST  ENCTYPE=multipart/form-data \n";
    print "ACTION=\"load.cgi\">\n";
    print "<table> <tr><td>\n";
    $nn = $GLOBAL{'FILE_NAME'};
    print "File Name: <td><INPUT TYPE=file NAME=file  SIZE=35 >\n";
    print "<tr><td>\n";
    print "Upload file's name: <td><INPUT TYPE=text NAME=upname SIZE=35
VALUE=$fname>\n";
    print "</tr><tr><td><td><INPUT TYPE=submit NAME=UPLOAD VALUE=UPLOAD >\n";
    print "</table>\n";
    
    exit;  

} # end of show_upload_failed 

sub show_upload_success 
{
    local($uploaded_file) = @_; 
    local(@status_list) ; 

    #  @status_list = stat($uploaded_file); 
    $file_stats = `ls -la $uploaded_file`; 
    @status_list = split(/\s+/,  $file_stats); # bug fix in v00.01 

    if ( !$status_list[4]) {
       system "rm $upload_dir$filename"; 
       show_upload_failed("The file's size equls zero");
    }
    else {
    print "Content-Type: text/html\n\n";   
    print "<html>\n";
    print "<head><title>Choose the properties of your text</title></head>\n";
    print "<body bgcolor=#5ea0a0>\n";
    print "<center>\n";
    print "<h4>Please Choose the properties of your text which you want</h4>\n";
    print "</center>\n";
    print "<br>\n";
    print "<form action=\"add_pic.cgi\" method=post>\n";
    print "<table border=0>\n";
    print "<tr><th align=left>Position:</th>\n";
    print "    <td align=left><select name=position>\n";
    print "        <option value=\"left\">Left</option>\n";
    print "        <option value=\"center\">Center</option>\n";
    print "        <option value=\"right\">Right</option>\n";
    print "        </select></td>\n";
    print "</tr>\n";
    print "<tr></tr>\n";
    print "<tr><th align=left><input type=checkbox name=link value=y>Do you want to link?</th>\n";
    print "    <td align=left><input type=text name=url size=30 maxlength=80 value=\"URL which you want to link\"></td>\n";
    print "</tr>\n";
    print "<tr></tr>\n";
    print "<tr><th align=left><input type=checkbox name=br value=y>Do you want to br?</th>\n";
    print "    <td align=left><input type=text name=no_br size=6 maxlength=3 value=\"Number\"></td>\n";
    print "</tr>\n";
    print "</table>\n";
    print "<input type=hidden name=file value=$filename>\n";
    print "<p><input type=submit value=\"Submit\">\n";
    print "   <input type=reset value=\"Clear\">\n";
    print "</form>\n";
    print "<br>\n";
    print "</body>\n";
    print "</html>\n";
}

    exit; 

} # end of show_upload_success 

sub handle_upload 
{

    if( !$GLOBAL{'FILE_NAME'} ) { show_file_not_found(); } 

    # grep the file name , there is always a / in front of the file name
    # $GLOBAL{'FILE_NAME'} =~ /.+\\([^\\]+)$|([^\/]+)$/; 
    $filename   = $GLOBAL{'FILE_NAME'}; 
    $filename =~ s/.+\\([^\\]+)$|.+\/([^\/]+)$/\1/;     

    if( $GLOBAL{'UPLOAD_DIR'} =~ /CURRENT/ ) { # change upload dir to current 
	$GLOBAL{'CURRENT_DIR'} =~ s/\s//g; 
	$upload_dir = $GLOBAL{'CURRENT_DIR'}; 
    }

    opendir(DIR, $upload_dir) || return 0; 

    while($fname = readdir(DIR)) {
#	if( $fname =~ /^\.|^\#|~$/ ) { next; } # skip hidden files
	$dir_content .= "$fname\n"; 
        if( $filename eq $fname) {
#          show_upload_failed("The file's name already exist please select the new name");
           repeat_file_name("repeat"); 
        }
    }
    closedir(DIR);

    $write_file = $upload_dir.$filename; 

    open(ULFD,">$write_file")  || show_upload_failed("$write_file  $!"); 
    print ULFD $GLOBAL{'FILE_CONTENT'}; 
    close(ULFD); 

    show_upload_success($write_file); 

    1;
} # end of handle_upload 

