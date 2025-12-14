
import java.io.*;
import java.util.*;

public class coding_quoted {

  public static String coding(String string){
    byte[] s = string.getBytes();
    String newString = "";
    String reference =  "=A0=A1=A2=A3=A4=A5=A6=A7=A8=A9=AA=AB=AC=AD=AE=AF" +
                        "=B0=B1=B2=B3=B4=B5=B6=B7=B8=B9=BA=BB=BC=BD=BE=BF" +
                        "=C0=C1=C2=C3=C4=C5=C6=C7=C8=C9=CA=CB=CC=CD=CE=CF" +
                        "=D0=D1=D2=D3=D4=D5=D6=D7=D8=D9=DA=DB=DC=DD=DE=DF" +
                        "=E0=E1=E2=E3=E4=E5=E6=E7=E8=E9=EA=EB=EC=ED=EE=EF" +
                        "=F0=F1=F2=F3=F4=F5=F6=F7=F8=F9=FA=FB=FC=FD=FE=FF";

    for(int i=0;i<(string.length());i++){
      System.out.println("s[i]: " + s[i]);
      if(s[i] <= -7 && s[i] >= -95 ){
        int index = ((s[i] + 256)-160)*3;
        System.out.println("index: " + index);
        for(int j = 0;j<3;j++){
          newString = newString + reference.charAt(index);
          index++;
        }
      }
      else{
        newString = newString + string.charAt(i);
      }
    }

    return newString;
  }

  public static void main(String args[]){
    System.out.println("coding " + args[0] + ": " + coding(args[0]));
  }
}

