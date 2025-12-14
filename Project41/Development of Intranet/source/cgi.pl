#!/usr/local/bin/perl
sub form_method{
$method=$ENV{'REQUEST_METHOD'};
 }
#####################################
if(&form_method eq 'POST'){
 read(STDIN,$temp,$ENV{'CONTENT_LENGTH'});
}
else{
 $temp=$ENV{'QUERY_STRING'};
}
@pairs=split(/&/,$temp);
foreach $item(@pairs){
  ($key,$content)=split(/=/,$item,2);
  $content=~tr/+/ /;
  $content=~ s/%(..)/pack("c",hex($1))/ge;
  $fields{$key}=$content;
}
#########Assign value to variable################
$topic=$fields{'type'};
$word1=$fields{'text1'};
$word2=$fields{'text2'};
$word3=$fields{'text3'};
$option1=$fields{'choice1'};
$option2=$fields{'choice2'};


if((!defined $option1)&&(!defined $option2)){
   $statement="select $bname,$auname,$sub,$tname,$id,$barcode
                         from book 
                         where $topic like '%$word1%'";
}
if(defined $option1){
   $statement="select $bname,$auname,$sub,$tname,$id,$barcode 
                        from book 
                        where $topic like '%$word1%' $option1 $topic like '%$word2%'";
}
if(defined $option2){
   $statement="select $bname,$auname,$sub,$tname,$id,$barcode 
                         from book 
                         where $topic like '%$word1%' $option1 $topic like '%$word2%' $option2 $topic like '%$word3%'";
}

############Database Connection Section#################
$ENV{ORACLE_HOME} = '/usr/oracle/app/oracle/product/7.3.4';
$ENV{ORACLE_SID} = 'SUNT';

$dbname = $ARGV[0] || '';       # if '' it'll use TWO_TASK/ORACLE_SID
$dbuser = $ENV{ORACLE_USERID} || 'scott/tiger';

use Oraperl;
#load Module Oraperl

#&ora_version;
#login to database
$dba= &ora_login($dbname,$dbuser,'');
$csr= &ora_open($dba,$statement);

#########Print result to WEB##########################

print"Content-type: text/html\n\n";
print"<body bgcolor=\"#ffffff\">\n";
print"<h1>This is your result</h1>\n";
print"Your choice is: $topic <br>\n";
print"Your word that want to search: $word1<br>\n";
while(@result=&ora_fetch($csr)){
@barcodeid=$result[5];
@barcodeid=splice(@barcodeid,0,2);
$barid=splice(@barcodeid,0,1,B);
print"<table>\n";
print"<tr>\n";
print"<td>$result[0] </td>\n";
print"<td>$result[1] </td>\n";
print"<td>$result[2] </td>\n";
print"<td>$result[3] </td>\n";
print"<td>$result[4] </td>\n";
print"<td><a href="http://1.2.27.22/image/$barid.gif">Image</a></td>\n";
print"</tr>\n";
print"</table>\n";
}
&ora_close($csr);
&ora_logoff($dba);

##################################################


