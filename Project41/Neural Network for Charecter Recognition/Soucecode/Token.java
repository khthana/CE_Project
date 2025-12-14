import java.awt.*;

public class Token  {
   int  dataToken[][]; 
   int  height;
   int  width;
   public static final int numberOfBlockX=10;
   public static final int numberOfBlockY=10;
   double  encodeData[]=new double[100];
   int  displayData[][]=new int[numberOfBlockY][numberOfBlockX];


   public Token(int[][] data)   {
       dataToken=data;
       height=dataToken.length;
       width=dataToken[0].length;
       skeleton();
   }

   public double[] getData()  {
       encode();
       return encodeData;
   }
/////////////////////////////////////////////
   private void encode()  {
       setSize();
       int i,j;
       for(i=0;i<10;i++)  
         for(j=0;j<10;j++)  
          encodeData[i*10+j]=displayData[i][j];
  }
/////////////////////////////////////////////
   public int[][] getDisplayData() {
       setSize();
       return displayData;
   }

   private void setSize()   {
       int sumRow[]=new int[height];
       int sumCol[]=new int[width];
       int tempDisplayData[][]=new int[numberOfBlockY][numberOfBlockX];
       int totalRow=0;
       int totalCol=0;
       int i,j,k,l;
       int tempX=0;
       int tempY=0;
       for(j=0;j<width;j++)
         for(i=0;i<height;i++)
           if(dataToken[i][j]==1)  sumCol[j]++;

       for(j=0;j<width;j++)
         totalCol=sumCol[j]+totalCol;

       for(i=0;i<height;i++)
         for(j=0;j<width;j++)
           if(dataToken[i][j]==1)  sumRow[i]++;

       for(i=0;i<height;i++)
         totalRow=sumRow[i]+totalRow;

       for(j=0;j<width;j++)  
         for(i=0;i<height;i++)  
           if(dataToken[i][j]==1)  {
              tempX=0;
              tempY=0;
              for(k=0;k<j;k++)  tempX=sumCol[k]+tempX;
              for(l=0;l<i;l++)  tempY=sumRow[l]+tempY;
                tempDisplayData[tempY*numberOfBlockY/totalRow]
                   [tempX*numberOfBlockX/totalCol]=1;
           } 

       displayData=tempDisplayData;


   }

   private void skeleton()  {
       int i,j;
       int window[];
       int tempdata[][]=dataToken;
       boolean erase=true;
       while(erase) {
       erase=false;


       //first step
       for(i=0;i<height;i++)
         for(j=0;j<width;j++)
           if(dataToken[i][j]==1)  {
              window=setIndexArray(i,j);
              if(!((window[0]==0&&window[1]==1)||(window[4]==0&&window[3]==1)
                 ||(window[1]+window[0]+window[7]+window[5]+window[4]+
                 window[3]==0)))
                   if(window[6]==1&&window[2]==0)  tempdata[i][j]=2;
           }

         // erase 
         for(i=0;i<height;i++)
           for(j=0;j<width;j++)  
              if(tempdata[i][j]==2)  {
                  dataToken[i][j]=0;
                  tempdata[i][j]=0;
                  erase=true;
              }

       //seconde step
       for(i=0;i<height;i++)
         for(j=0;j<width;j++)
           if(dataToken[i][j]==1)  {
              window=setIndexArray(i,j);
              if(!((window[6]==0&&window[7]==1)||(window[2]==0&&window[1]==1)
                 ||(window[2]+window[1]+window[7]+window[6]+window[5]+
                 window[3]==0)))
                   if(window[4]==1&&window[0]==0)  tempdata[i][j]=2;
           }

         // erase 
         for(i=0;i<height;i++)
           for(j=0;j<width;j++)  
              if(tempdata[i][j]==2)  {
                  dataToken[i][j]=0;
                  tempdata[i][j]=0;
                  erase=true;
              }

       //tird step
       for(i=0;i<height;i++)
         for(j=0;j<width;j++)
           if(dataToken[i][j]==1)  {
              window=setIndexArray(i,j);
              if(!((window[0]==0&&window[7]==1)||(window[4]==0&&window[5]==1)
                 ||(window[1]+window[0]+window[7]+window[5]+window[4]+
                 window[3]==0)))
                   if(window[2]==1&&window[6]==0)  tempdata[i][j]=2;
           }

         // erase
         for(i=0;i<height;i++)
           for(j=0;j<width;j++)  
              if(tempdata[i][j]==2)  {
                  dataToken[i][j]=0;
                  tempdata[i][j]=0;
                  erase=true;
              }

       //four step
       for(i=0;i<height;i++)
         for(j=0;j<width;j++)
           if(dataToken[i][j]==1)  {
              window=setIndexArray(i,j);
              if(!((window[6]==0&&window[5]==1)||(window[2]==0&&window[3]==1)
                 ||(window[2]+window[1]+window[7]+window[6]+window[5]+
                 window[3]==0)))
                   if(window[0]==1&&window[4]==0)  tempdata[i][j]=2;
           }

         // erase
         for(i=0;i<height;i++)
           for(j=0;j<width;j++)  
              if(tempdata[i][j]==2)  {
                  dataToken[i][j]=0;
                  tempdata[i][j]=0;
                  erase=true;
              }

         }


   }




  private int[] setIndexArray(int y,int x) {
     int temp[]=new int[8];
     if(y!=0)  temp[0]=dataToken[y-1][x];
     else temp[0]=0;

     if(y!=0 && x!=width-1) temp[1]=dataToken[y-1][x+1];
     else temp[1]=0;

     if(x!=width-1)  temp[2]=dataToken[y][x+1];
     else temp[2]=0;

     if(y!=height-1 && x!=width-1) temp[3]=dataToken[y+1][x+1];
     else temp[3]=0;

     if(y!=height-1) temp[4]=dataToken[y+1][x];
     else temp[4]=0;

     if(y!=height-1 && x!=0) temp[5]=dataToken[y+1][x-1];
     else temp[5]=0;

     if(x!=0) temp[6]=dataToken[y][x-1];
     else temp[6]=0;

     if(y!=0 && x!=0) temp[7]=dataToken[y-1][x-1];
     else temp[7]=0;

//     for(int i=0;i<8;i++) System.out.print(temp[i]);
//     System.out.println();
     return temp;
  }



      
}

                
                           
