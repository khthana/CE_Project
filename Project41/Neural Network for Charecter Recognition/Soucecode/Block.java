import java.awt.*;
import java.lang.*;
import java.util.*;
public class Block    {
   int dataBlock[][];
   int dataBlock_WIDTH;
   int dataBlock_HEIGHT;
   int scanline_TOP;
   int scanline_LEFT;
   int scanline_BUTTOM;
   int scanline_RIGHT;
   int tokenData[][];
   int numberOfToken=0;
   boolean haveToken=true;
   Vector tokenDisplayVector=new Vector();
   Vector tokenDataVector=new Vector();
   int numberOfDisplayData=0;

   public Block(int data[][])    {
       dataBlock=data;
       dataBlock_HEIGHT=dataBlock.length-1;
       dataBlock_WIDTH=dataBlock[0].length-1;
       while(haveAnyToken()) getToken();
   }
   public void getToken()     {
       scanline_TOP=0;
       scanline_LEFT=0;
       scanline_BUTTOM=0;
       scanline_RIGHT=0;
       findToken(0,0,dataBlock_WIDTH,dataBlock_HEIGHT);
   }

   private void findToken(int left,int top,int right,int buttom)    {
       //case top,left
       int i,j;

       //Find scanline_TOP
       for(i=top;i<=buttom;i++)
         for(j=left;j<=right;j++)
           if(dataBlock[i][j]==1)   {
              scanline_TOP=i;
              i=buttom+1;
              j=right+1;
          }
       //Find scanline_BUTTOM
       for(i=scanline_TOP;i<=buttom;i++)    
         for(j=left;j<=right;j++)
           if(dataBlock[i][j]==1) j=right+1;
           else if(j==right)   {
                    scanline_BUTTOM=i-1;
                    i=buttom+1;
                }

       //Find scanline_LEFT
       for(j=left;j<=right;j++)
         for(i=scanline_TOP;i<=scanline_BUTTOM;i++)
           if(dataBlock[i][j]==1)   {
              scanline_LEFT=j;
              i=scanline_BUTTOM+1;
              j=right+1;
          }

       //Find scanline_RIGHT
       for(j=scanline_LEFT;j<=right;j++)
         for(i=scanline_TOP;i<=scanline_BUTTOM;i++)
           if(dataBlock[i][j]==1) i=scanline_BUTTOM+1;
           else if(i==scanline_BUTTOM)   {
                    scanline_RIGHT=j-1;
                    j=right+1;
                }

       //Cut blank Top and Buttom again
       for(i=scanline_TOP;i<=scanline_BUTTOM;i++)
         for(j=scanline_LEFT;j<=scanline_RIGHT;j++)
           if(dataBlock[i][j]==1) {
              scanline_TOP=i;
              j=scanline_RIGHT+1;
              i=scanline_BUTTOM+1;
            }

       for(i=scanline_TOP;i<=scanline_BUTTOM;i++)
         for(j=scanline_LEFT;j<=scanline_RIGHT;j++)
           if(dataBlock[i][j]==1) j=scanline_RIGHT+1;
           else if(j==scanline_RIGHT) scanline_BUTTOM=i-1;

       haveToken=false;

       //Check it Single Token
       //first check left to right if it not have blank step 2

       for(i=scanline_TOP;i<=scanline_BUTTOM;i++)    
         for(j=scanline_LEFT;j<=scanline_RIGHT;j++)
           if(dataBlock[i][j]==1) j=scanline_RIGHT+1;
           else if(j==scanline_RIGHT) haveToken=true;

       //step 2 check top to bottom 
       if(!haveToken)
         for(j=scanline_LEFT;j<=scanline_RIGHT;j++)
           for(i=scanline_TOP;i<=scanline_BUTTOM;i++)
             if(dataBlock[i][j]==1) i=scanline_BUTTOM+1;
             else if(i==scanline_BUTTOM) haveToken=true;

       //if it is a single token haveToken=false we want to clear
       //block in the token position





       //clear Block
       if(!haveToken)  {
          //copy dataBlock--> dataToken
          int datatoken[][]=new int[scanline_BUTTOM-scanline_TOP+1]
                                 [scanline_RIGHT-scanline_LEFT+1];
          for(i=scanline_TOP;i<=scanline_BUTTOM;i++) 
             for(j=scanline_LEFT;j<=scanline_RIGHT;j++)   
               datatoken[i-scanline_TOP][j-scanline_LEFT]=dataBlock[i][j];
         
         clearBlock(scanline_LEFT,scanline_TOP,scanline_RIGHT,scanline_BUTTOM);
         Token x=new Token(datatoken);
         tokenDisplayVector.addElement(x);
         tokenDataVector.addElement(x);
       }

       else
         findToken(scanline_LEFT,scanline_TOP,scanline_RIGHT,scanline_BUTTOM);

   }

   private void clearBlock(int left,int top,int right,int buttom) {
      int i,j;
      for(i=top;i<=buttom;i++)
        for(j=left;j<=right;j++)
          dataBlock[i][j]=0;
   }

   public boolean haveAnyDisplayData()  {
      if(numberOfDisplayData==0)
         return false;
      else
         return true;
   }

   public int[][] getDisplayData()  {
      Token token=null;
      if(!tokenDisplayVector.isEmpty()) {
        token =(Token)tokenDisplayVector.firstElement();
        tokenDisplayVector.removeElementAt(0);
      }
      numberOfDisplayData=tokenDisplayVector.size();
      return token.getDisplayData();
   }


//////////////////////////////////
   public double[] getTokenData()  {
      Token token=null;
      if(!tokenDataVector.isEmpty()) {
        token =(Token)tokenDataVector.firstElement();
        tokenDataVector.removeElementAt(0);
      }
      return token.getData();
   }
//////////////////////////////////

   public boolean haveAnyToken()  {
      int i,j;
      boolean temp=false;
      for(i=0;i<=dataBlock_HEIGHT;i++)
        for(j=0;j<=dataBlock_WIDTH;j++)
          if(dataBlock[i][j]==1) {
            j=dataBlock_WIDTH;
            i=dataBlock_HEIGHT;
            temp=true;
          }
      return  temp;
   }    
}



                                
