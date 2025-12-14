import java.io.*;

public class decode_byte {

  public static char decode(int b){
    String reference =   "X¡¢X¤X¦§¨©ª«¬­®¯" +
                         "°±²³´µ¶·¸¹º»¼½¾¿" +
                         "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ" +
                         "ĞÑÒÓÔÕÖ×ØÙÚXXXXß" +
                         "àáâãäåæçèéêëìíXX" +
                         "ğñòóôõö÷øùXXXXXX";
    char c;
    if(b > 160){
      c = reference.charAt( b-160 );
    }
    else{
      c = (char)b;
    }
   return  c;
  }
}
