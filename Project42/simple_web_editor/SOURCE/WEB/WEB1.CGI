#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');

print "Content-type:text/html\n\n";
print <<htmlweb1;
<html>
<head><title>Web</title></head>
<body>

<p align="center">Font</p>
<form method="POST" action="--WEBBOT-SELF--">
  <div align="center"><center><p>
  <textarea rows="3" name="S1" cols="42"></textarea></p></center></div>
  <div align="center"><center><p><select name="D1" size="1">
    <option value="AngsanaUPC">Angsana UPC</option>
    <option value="Cordia New">Cordia New</option>
  </select><select name="D2" size="1">
    <option value="Regular">Regular</option>
    <option value="Italic">Italic</option>
  </select><select name="D3" size="1">
    <option value="Normal">Normal</option>
    <option value="1">1</option>
    <option value="2">2</option>
  </select><select name="D4" size="1">
    <option value="Green">Green</option>
    <option value="Blue">Blue</option>
  </select></p>
  </center></div><div align="center"><center><p><input type="submit"
value="Submit" name="B1"></p>
  </center></div>
</form>

<p align="center">Picture</p>

<p align="center">Background</p>
<form method="POST" action="--WEBBOT-SELF--">
  <div align="center"><center><p><select name="D1" size="1">
    <option value="Blue">Blue</option>
    <option value="Brown">Brown</option>
  </select><input type="submit" value="Submit" name="B1"></p>
  </center></div>
</form>

</body>
</html>
htmlweb1



