public class decode_base64 {

  public static String decode(String code)
  {
   String table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

   String reference =   "X¡¢X¤X¦§¨©ª«¬­®¯" +
                        "°±²³´µ¶·¸¹º»¼½¾¿" +
                        "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ" +
                        "ĞÑÒÓÔÕÖ×ØÙÚXXXXß" +
                        "àáâãäåæçèéêëìíXX" +
                        "ğñòóôõö÷øùXXXXXX";
                       
   if ( code.indexOf("0KDQoNC") != -1 )
      {  code = code.substring(0,code.indexOf("0KDQoNC") );        }

   if (code.indexOf("NCg0KDQo")   != -1 )
      {  code = code.substring(0,code.indexOf("NCg0KD") );         }

   if (code.indexOf("DQoNCg0K") != -1 )
      {  code = code.substring(0,code.indexOf("DQoNCg0K") );       }

    char ch;
    int  numTable,intBit8;
    String bit_6,bit_8,Text="",bitStr="";

    for (int i = 0 ; i < code.length(); i ++)
    {
     numTable =  table.indexOf(code.charAt(i));
     bit_6    =  Integer.toBinaryString(numTable);
         for (int j = bit_6.length(); j < 6 ; j++)  // fill 0 unitl is  6bit
              bit_6  = '0' + bit_6;
     bitStr = bitStr + bit_6;
    }

    do {
         intBit8=0;
         bit_8  =  bitStr.substring(0,8);
         bitStr   =  bitStr.substring(8);
         for (int i=0; i<8 ; i++)    // convert  2base -->  10base
         {
              if  (bit_8.charAt(i) == '1')
                   intBit8 = intBit8 +  ((int) Math.pow(2,7-i));
         }

        if (intBit8<161)
         Text = Text + (char) intBit8;
        else
          Text = Text + reference.charAt(intBit8-160);
       }  while (bitStr.length() >= 8);

    return  Text;
  }


} // Main