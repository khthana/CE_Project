
import java.io.*;
import java.util.*;

public class decode_quoted {

  public static String decode(String string){
    //byte[] s = string.getBytes();
    if (string.length()<76)
    {
		string = string + 'A';
    }
	String newString = "";
    System.out.println("xx: " + string.length());

    for(int i=0;i<(string.length()-1);i++){
      System.out.println("x0 " + i);
      if(string.charAt(i) == '='){
        i++;
        System.out.println("x1 " +i);
		System.out.println("string is " + string);
        switch(string.charAt(i)){
          case '3' :  i++;
						 if(string.charAt(i) == 'D')
						 newString = newString + "=";
                         break;
		  case 'A':{
                    i++;
                    System.out.println("x2A " + i);
                    switch(string.charAt(i)){
                      case '1':newString = newString + "¡";
                               break;
                      case '2':newString = newString + "¢";
                               break;
                      case '4':newString = newString + "¤";
                               break;
                      case '6':newString = newString + "¦";
                               break;
                      case '7':newString = newString + "§";
                               break;
                      case '8':newString = newString + "¨";
                               break;
                      case '9':newString = newString + "©";
                               break;
                      case 'A':newString = newString + "ª";
                               break;
                      case 'B':newString = newString + "«";
                               break;
                      case 'C':newString = newString + "¬";
                               break;
                      case 'D':newString = newString + "­";
                               break;
                      case 'E':newString = newString + "®";
                               break;
                      case 'F':newString = newString + "¯";
                    }
          }
          break;
          case 'B':{
                    i++;
                    System.out.println("x2B " + i);
                    switch(string.charAt(i)){
                      case '0':newString = newString + "°";
                               break;
                      case '1':newString = newString + "±";
                               break;
                      case '2':newString = newString + "²";
                               break;
                      case '3':newString = newString + "³";
                               break;
                      case '4':newString = newString + "´";
                               break;
                      case '5':newString = newString + "µ";
                               break;
                      case '6':newString = newString + "¶";
                               break;
                      case '7':newString = newString + "·";
                               break;
                      case '8':newString = newString + "¸";
                               break;
                      case '9':newString = newString + "¹";
                               break;
                      case 'A':newString = newString + "º";
                               break;
                      case 'B':newString = newString + "»";
                               break;
                      case 'C':newString = newString + "¼";
                               break;
                      case 'D':newString = newString + "½";
                               break;
                      case 'E':newString = newString + "¾";
                               break;
                      case 'F':newString = newString + "¿";
                    }
          }
          break;
          case 'C':{
                    i++;
                    System.out.println("x2C " + i);
                    switch(string.charAt(i)){
                      case '0':newString = newString + "À";
                               break;
                      case '1':newString = newString + "Á";
                               break;
                      case '2':newString = newString + "Â";
                               break;
                      case '3':newString = newString + "Ã";
                               break;
                      case '4':newString = newString + "Ä";
                               break;
                      case '5':newString = newString + "Å";
                               break;
                      case '6':newString = newString + "Æ";
                               break;
                      case '7':newString = newString + "Ç";
                               break;
                      case '8':newString = newString + "È";
                               break;
                      case '9':newString = newString + "É";
                               break;
                      case 'A':newString = newString + "Ê";
                               break;
                      case 'B':newString = newString + "Ë";
                               break;
                      case 'C':newString = newString + "Ì";
                               break;
                      case 'D':newString = newString + "Í";
                               break;
                      case 'E':newString = newString + "Î";
                               break;
                      case 'F':newString = newString + "Ï";
                    }
          }
          break;
          case 'D':{
                    i++;
                    System.out.println("x2D " + i);
                    switch(string.charAt(i)){
                      case '0':newString = newString + "Ð";
                               break;
                      case '1':newString = newString + "Ñ";
                               break;
                      case '2':newString = newString + "Ò";
                               break;
                      case '3':newString = newString + "Ó";
                               break;
                      case '4':newString = newString + "Ô";
                               break;
                      case '5':newString = newString + "Õ";
                               break;
                      case '6':newString = newString + "Ö";
                               break;
                      case '7':newString = newString + "×";
                               break;
                      case '8':newString = newString + "Ø";
                               break;
                      case '9':newString = newString + "Ù";
                               break;
                      case 'A':newString = newString + "Ú";
                               break;
                      case 'F':newString = newString + "ß";
                    }
          }
          break;
          case 'E':{
                    i++;
                    System.out.println("x2E " + i);
                    switch(string.charAt(i)){
                      case '0':newString = newString + "à";
                               break;
                      case '1':newString = newString + "á";
                               break;
                      case '2':newString = newString + "â";
                               break;
                      case '3':newString = newString + "ã";
                               break;
                      case '4':newString = newString + "ä";
                               break;
                      case '5':newString = newString + "å";
                               break;
                      case '6':newString = newString + "æ";
                               break;
                      case '7':newString = newString + "ç";
                               break;
                      case '8':newString = newString + "è";
                               break;
                      case '9':newString = newString + "é";
                               break;
                      case 'A':newString = newString + "ê";
                               break;
                      case 'B':newString = newString + "ë";
                               break;
                      case 'C':newString = newString + "ì";
                               break;
                      case 'D':newString = newString + "í";
                    }
          }
          break;
          case 'F':{
                    i++;
                    System.out.println("x2F " + i);
                    switch(string.charAt(i)){
                      case '0':newString = newString + "ð";
                               break;
                      case '1':newString = newString + "ñ";
                               break;
                      case '2':newString = newString + "ò";
                               break;
                      case '3':newString = newString + "ó";
                               break;
                      case '4':newString = newString + "ô";
                               break;
                      case '5':newString = newString + "õ";
                               break;
                      case '6':newString = newString + "ö";
                               break;
                      case '7':newString = newString + "÷";
                               break;
                      case '8':newString = newString + "ø";
                               break;
                      case '9':newString = newString + "ù";
                    }
          }
        }
      }
      else {
        newString = newString + string.charAt(i);
      }
    }
    return newString;
  }
  public static void main(String args[]){
    System.out.println(args[0] + ": " + decode(args[0]));
  }
}

