<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</head>

<body bgcolor="#FFFFFF">
<form method="get" action="viewpaper.asp" name="DetailPaper">
  <table width="82%" border="0">
    <tr> 
      <td height="30" width="25%"> 
        <div align="center">ชิ่อบทความ</div>
      </td>
      <td height="30" width="37%"> 
        <input type="text" name="STitle">
      </td>
      <td height="30" width="6%">&nbsp;</td>
      <td height="30" width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="25%"> 
        <div align="center">ชื่อวรสาร</div>
      </td>
      <td width="37%"> 
        <select name="SJournal">
        </select>
      </td>
      <td width="6%">&nbsp;</td>
      <td width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="25%"> 
        <div align="center">ชนิดของบทความ</div>
      </td>
      <td width="37%"> 
        <select name="SType">
        </select>
      </td>
      <td width="6%">&nbsp;</td>
      <td width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="25%">
        <div align="center">ผู้แต่ง</div>
      </td>
      <td width="37%">
        <input type="text" name="AuthorA">
      </td>
      <td width="6%">
        <select name="BoAuthor">
          <option value="--">--</option>
          <option value="or">หรือ</option>
          <option value="and">และ</option>
        </select>
      </td>
      <td width="32%">
        <input type="text" name="AuthorB">
      </td>
    </tr>
    <tr> 
      <td width="25%" height="35"> 
        <div align="center">คำคัน</div>
      </td>
      <td width="37%" height="35">
        <input type="text" name="KeywordA">
      </td>
      <td width="6%" height="35">
        <select name="BoKey">
          <option value="--">--</option>
          <option value="or">หรือ</option>
          <option value="and">และ</option>
        </select>
      </td>
      <td width="32%" height="35">
        <input type="text" name="KeywordB">
      </td>
    </tr>
  </table>
  <p>
    <input type="submit" name="Submit" value="ตกลง">
  </p>
</form>
</body>
</html>
