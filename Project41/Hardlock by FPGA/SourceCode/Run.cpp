#include <alloc.h>
#include <fcntl.h>
#include <io.h>
#include <iostream.h>
#include <process.h>
#include <share.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

class DES
{
   public:
   	void Encypt(unsigned int[]);
      void Decypt(unsigned int[]);
};
void transpose(unsigned int data[],int t[],int s)
{

     	unsigned int Tr[64];
//---------------------------
     	for(int n=0;n<64;n++)
      Tr[n]=data[n];
//---------------------------
     	for(int i=0;i<s;i++)
     	data[i]=Tr[t[i]];
}
void  rotate(unsigned int key[])
{
	unsigned int k[64];
//--------------------------
   for(int n=0;n<56;n++)
   k[n]=key[n];
//--------------------------
   for (int i=0;i<55;i++) k[i]=k[i+1];
   k[27]=key[0]; k[55]=key[28];
   for(int i=0;i<56;i++)
   key[i]=k[i];
}
void f(int i,unsigned int key[],unsigned int a[],unsigned int x[])
{
      int KeyTr2[48]	  ={13,16,10,23,0,4,2,27,14,5,20,9,22,18,11,3,25,7,15,6,
        						 26,19,12,1,40,51,30,36,46,54,29,39,50,44,32,47,43,48,
                         38,55,33,52,45,41,49,35,28,31};

		int etr[48]		  ={31,0,1,2,3,4,3,4,5,6,7,8,7,8,9,10,11,12,11,12,13,14,
      						 15,16,15,16,17,18,19,20,19,20,21,22,23,24,23,24,25,26,
                         27,28,27,28,29,30,31,0};

		int ptr[32]		  ={15,6,19,20,28,11,27,16,0,14,22,25,4,17,30,9,1,7,23,13,
      						 31,26,2,8,18,12,29,5,21,10,3,24};

		int s[8][64]     ={{14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,0,15,7,4,14,2,13,
                         1,10,6,12,11,9,5,3,8,4,1,14,8,13,6,2,11,15,12,9,7,3,10,
                         5,0,15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13},

								 {15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,3,13,4,7,15,2,8,
                         14,12,0,1,10,6,9,11,5,0,14,7,11,10,4,13,1,5,8,12,6,9,3,
                         2,15,13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9},

								 {10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,13,7,0,9,3,4,6,
      		             10,2,8,5,14,12,11,15,1,13,6,4,9,8,15,3,0,11,1,2,12,5,
                         10,14,7,1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12},

								 {7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,13,8,11,5,6,15,
                         0,3,4,7,2,12,1,10,14,9,10,6,9,0,12,11,7,13,15,1,3,14,5,
                         2,8,4,3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14},

								 {2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,14,11,2,12,4,7,
      						 13,1,5,0,15,10,3,9,8,6,4,2,1,11,10,13,7,8,15,9,12,5,6,
                         3,0,14,11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3},

								 {12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,10,15,4,2,7,12,
      						 9,5,6,1,13,14,0,11,3,8,9,14,15,5,2,8,12,3,7,0,4,10,1,
                         13,11,6,4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13},

								 {4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,13,0,11,7,4,9,1,
      						 10,14,3,5,12,2,15,8,6,1,4,11,13,12,3,7,14,10,15,6,8,0,
                         5,9,2,6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12},

  								 {13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,1,15,13,8,10,3,
      						 7,4,12,5,6,11,0,14,9,2,7,11,4,1,9,12,14,2,0,6,10,13,15,
                         3,5,8,2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11}};

		int rots[16]	  ={1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1};
	unsigned int e[64];
   unsigned int ikey[64];
   unsigned int y[64];
   int r,T;
   div_t D;
//------------------------
   for(int n=0;n<64;n++)
   e[n]=a[n];
//------------------------
	transpose(e,etr,48);
   for(int j=0;j<rots[i];j++) rotate(key);
//------------------------
	for(int n=0;n<64;n++)
   ikey[n]=key[n];
//------------------------
   transpose(ikey,KeyTr2,48);
	for(int j=0;j<48;j++)
   if(e[j]+ikey[j]==1) y[j]=1; else y[j]=0;

   for(int k=1;k<9;k++)
   {
     r=32*y[6*k-6]+16*y[6*k-1]+8*y[6*k-5]+4*y[6*k-4]+2*y[6*k-3]+y[6*k-2];
     D=div(s[k-1][r],8);
     T=D.quot;
     if (T%2!=0) x[4*k-4]=1; else x[4*k-4]=0;
     D=div(s[k-1][r],4);
     T=D.quot;
     if (T%2!=0) x[4*k-3]=1; else x[4*k-3]=0;
     D=div(s[k-1][r],2);
     T=D.quot;
     if (T%2!=0) x[4*k-2]=1; else x[4*k-2]=0;
     T=s[k-1][r];
     if (T%2!=0) x[4*k-1]=1; else x[4*k-1]=0;
   }

   transpose(x,ptr,32);
}
void  rotateb(unsigned int key[])
{
	unsigned int k[64];
//--------------------------
   for(int n=0;n<56;n++)
   k[n]=key[n];
//--------------------------
   for (int i=55;i>0;i--) k[i]=k[i-1];
   k[0]=key[27]; k[28]=key[55];
   for(int i=0;i<56;i++)
   key[i]=k[i];
}
void fd(int i,unsigned int key[],unsigned int a[],unsigned int x[])
{
      int KeyTr2[48]	  ={13,16,10,23,0,4,2,27,14,5,20,9,22,18,11,3,25,7,15,6,
        						 26,19,12,1,40,51,30,36,46,54,29,39,50,44,32,47,43,48,
                         38,55,33,52,45,41,49,35,28,31};

		int etr[48]		  ={31,0,1,2,3,4,3,4,5,6,7,8,7,8,9,10,11,12,11,12,13,14,
      						 15,16,15,16,17,18,19,20,19,20,21,22,23,24,23,24,25,26,
                         27,28,27,28,29,30,31,0};

		int ptr[32]		  ={15,6,19,20,28,11,27,16,0,14,22,25,4,17,30,9,1,7,23,13,
      						 31,26,2,8,18,12,29,5,21,10,3,24};

		int s[8][64]     ={{14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,0,15,7,4,14,2,13,
                         1,10,6,12,11,9,5,3,8,4,1,14,8,13,6,2,11,15,12,9,7,3,10,
                         5,0,15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13},

								 {15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,3,13,4,7,15,2,8,
                         14,12,0,1,10,6,9,11,5,0,14,7,11,10,4,13,1,5,8,12,6,9,3,
                         2,15,13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9},

								 {10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,13,7,0,9,3,4,6,
      		             10,2,8,5,14,12,11,15,1,13,6,4,9,8,15,3,0,11,1,2,12,5,
                         10,14,7,1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12},

								 {7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,13,8,11,5,6,15,
                         0,3,4,7,2,12,1,10,14,9,10,6,9,0,12,11,7,13,15,1,3,14,5,
                         2,8,4,3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14},

								 {2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,14,11,2,12,4,7,
      						 13,1,5,0,15,10,3,9,8,6,4,2,1,11,10,13,7,8,15,9,12,5,6,
                         3,0,14,11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3},

								 {12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,10,15,4,2,7,12,
      						 9,5,6,1,13,14,0,11,3,8,9,14,15,5,2,8,12,3,7,0,4,10,1,
                         13,11,6,4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13},

								 {4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,13,0,11,7,4,9,1,
      						 10,14,3,5,12,2,15,8,6,1,4,11,13,12,3,7,14,10,15,6,8,0,
                         5,9,2,6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12},

  								 {13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,1,15,13,8,10,3,
      						 7,4,12,5,6,11,0,14,9,2,7,11,4,1,9,12,14,2,0,6,10,13,15,
                         3,5,8,2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11}};

		int rots[16]	  ={1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1};
	unsigned int e[64];
   unsigned int ikey[64];
   unsigned int y[64];
   int r,T;
   div_t D;
//------------------------
   for(int n=0;n<64;n++)
   e[n]=a[n];
//------------------------
	transpose(e,etr,48);
   if (i<16) for(int j=0;j<rots[i];j++) rotateb(key);
//------------------------
	for(int n=0;n<64;n++)
   ikey[n]=key[n];
//------------------------
   transpose(ikey,KeyTr2,48);
	for(int j=0;j<48;j++)
   if(e[j]+ikey[j]==1) y[j]=1; else y[j]=0;

   for(int k=1;k<9;k++)
   {
     r=32*y[6*k-6]+16*y[6*k-1]+8*y[6*k-5]+4*y[6*k-4]+2*y[6*k-3]+y[6*k-2];
     D=div(s[k-1][r],8);
     T=D.quot;
     if (T%2!=0) x[4*k-4]=1; else x[4*k-4]=0;
     D=div(s[k-1][r],4);
     T=D.quot;
     if (T%2!=0) x[4*k-3]=1; else x[4*k-3]=0;
     D=div(s[k-1][r],2);
     T=D.quot;
     if (T%2!=0) x[4*k-2]=1; else x[4*k-2]=0;
     T=s[k-1][r];
     if (T%2!=0) x[4*k-1]=1; else x[4*k-1]=0;
   }
   transpose(x,ptr,32);
}
void DES::Encypt(unsigned int a[])
{
      int InitialTr[64]={57,49,41,33,25,17,9,1,59,51,43,35,27,19,11,3,61,
                         53,45,37,29,21,13,5,63,55,47,39,31,23,15,7,56,48,
                         40,32,24,16,8,0,58,50,42,34,26,18,10,2,60,52,44,36,
                         28,20,12,4,62,54,46,38,30,22,14,6};
      int FinalTr[64]  ={39,7,47,15,55,23,63,31,38,6,46,14,54,22,62,30,37,
                         5,45,13,53,21,61,29,36,4,44,12,52,20,60,28,35,3,43,
                         11,51,19,59,27,34,2,42,10,50,18,58,26,32,1,41,9,49,
                         17,57,25,32,0,40,8,48,16,56,24};

 		int swap[64]	  ={32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,
                         49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,0,1,
                         2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
                         22,23,24,25,26,27,28,29,30,31};

		int KeyTr1[56]	  ={56,48,40,32,24,16,8,0,57,49,41,33,25,17,9,1,58,50,
      						 42,34,26,18,10,2,59,51,43,35,62,54,46,38,30,22,14,6,
                         61,53,45,37,29,21,13,5,60,52,44,36,28,20,12,4,27,19,
                         11,3};

      unsigned int key[64] ={1,1,0,1,0,1,0,0,0,1,1,0,0,1,0,1,1,0,0,1,1,1,0,0,1,0,1,
                         0,1,1,1,0,0,0,1,1,0,1,1,0,0,1,1,1,1,1,0,0,1,1,0,1,1,0,
                         0,1,1,1,1,0,1,0,1,1};

      unsigned int b[64];
      unsigned int x[64];
      transpose(a,InitialTr,64);
      transpose(key,KeyTr1,56);
      for(int i=0;i<16;i++)
      {
        for(int n=0;n<64;n++)
        b[n]=a[n];
        for(int j=0;j<32;j++)
        a[j]=b[j+32];

        f(i,key,a,x);

        for(int j=0;j<32;j++)
        if (b[j]+x[j]==1)
        	a[j+32]=1;
        else
        	a[j+32]=0;
      }
      transpose(a,swap,64);
      transpose(a,FinalTr,64);
}

void DES::Decypt(unsigned int a[])
{
      int InitialTr[64]={57,49,41,33,25,17,9,1,59,51,43,35,27,19,11,3,61,
                         53,45,37,29,21,13,5,63,55,47,39,31,23,15,7,56,48,
                         40,32,24,16,8,0,58,50,42,34,26,18,10,2,60,52,44,36,
                         28,20,12,4,62,54,46,38,30,22,14,6};
      int FinalTr[64]  ={39,7,47,15,55,23,63,31,38,6,46,14,54,22,62,30,37,
                         5,45,13,53,21,61,29,36,4,44,12,52,20,60,28,35,3,43,
                         11,51,19,59,27,34,2,42,10,50,18,58,26,32,1,41,9,49,
                         17,57,25,32,0,40,8,48,16,56,24};

 		int swap[64]	  ={32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,
                         49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,0,1,
                         2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
                         22,23,24,25,26,27,28,29,30,31};

		int KeyTr1[56]	  ={56,48,40,32,24,16,8,0,57,49,41,33,25,17,9,1,58,50,
      						 42,34,26,18,10,2,59,51,43,35,62,54,46,38,30,22,14,6,
                         61,53,45,37,29,21,13,5,60,52,44,36,28,20,12,4,27,19,
                         11,3};
      unsigned int key[64]= {1,1,0,1,0,1,0,0,0,1,1,0,0,1,0,1,1,0,0,1,1,1,0,0,1,0,1,
                         0,1,1,1,0,0,0,1,1,0,1,1,0,0,1,1,1,1,1,0,0,1,1,0,1,1,0,
                         0,1,1,1,1,0,1,0,1,1};
      unsigned int b[64];
      unsigned int x[64];
      transpose(a,InitialTr,64);
      transpose(key,KeyTr1,56);
      for(int i=16;i>0;i--)
      {
        for(int n=0;n<64;n++)
        b[n]=a[n];
        for(int j=0;j<32;j++)
        a[j]=b[j+32];

        fd(i,key,a,x);

        for(int j=0;j<32;j++)
        if (b[j]+x[j]==1)
        	a[j+32]=1;
        else
        	a[j+32]=0;
      }
      transpose(a,swap,64);
      transpose(a,FinalTr,64);
}
class EncryptionFile
{
	public:
      void EncryptFile(char[]);
      void DecryptFile();
};

void HextoBin(unsigned int Hex,unsigned int Bin[],int j)
{
     div_t D;
     for(int i=1;i<9;i++)
     {
   	  if (Hex%2!=0) Bin[8*j-i]=1; else Bin[8*j-i]=0;
        D=div(Hex,2);
        Hex=D.quot;
     }
}

unsigned int BintoHex(unsigned int Bin[],int j)
{
   unsigned int Hex;
	Hex=128*Bin[8*j-8]+64*Bin[8*j-7]+32*Bin[8*j-6]+16*Bin[8*j-5]+8*Bin[8*j-4]
       +4*Bin[8*j-3]+2*Bin[8*j-2]+Bin[8*j-1];
   return Hex;
}
void EncryptionFile::EncryptFile(char NameOfFile[])
{
   DES Encyption;
   FILE *FileWrite;
   fpos_t pos;
	int File,Data,redo,x,loop;
   unsigned int FileData[64],Temp1[64],Temp2[64];
   unsigned int *buf;
   char FileList[5][14]={"Encrypt00.dat","Encrypt01.dat","Encrypt02.dat"
   					      ,"Encrypt03.dat","Encrypt04.dat"};
   buf = (unsigned int *)malloc(1);
   *buf = 0;
   loop = 0;
   
   do
   {
   do
   {
      redo=0;
   	File = _rtl_open(NameOfFile,SH_DENYRW);

   	do
   	{
      	randomize();
      	x=random(32);
   	} while (x==0);
      for(int i=1;i<256*x+1;i++)
      Data =_rtl_read(File,buf,1);
      for(int i=1;i<8;i++)
      {
         	Data=_rtl_read(File,buf,1);
          	HextoBin(*buf,FileData,i);
      }
      HextoBin(x,FileData,8);

      for (int i=0;i<64;i++)
      Temp2[i]=FileData[i];

      Encyption.Encypt(FileData);
      for (int i=0;i<64;i++)
      Temp1[i]=FileData[i];
      Encyption.Decypt(Temp1);

      for (int i=1;i<64;i++)
      if (Temp1[i]!=Temp2[i]) redo=1;
   	_rtl_close(File);
   }while(redo==1);
   FileWrite = _fsopen(NameOfFile,"r+",SH_DENYNO);
   pos=256*x;
   fsetpos(FileWrite,&pos);
   fwrite("LockNow",7,1,FileWrite);
   fclose(FileWrite);
   File =  _rtl_creat(FileList[loop],0);
   for (int i=1;i<9;i++)
   {
       *buf = BintoHex(FileData,i);
       Data = _rtl_write(File,buf,1);
   }
   _rtl_close(File);
   loop++;
   } while (loop<5);
   free(buf);
   rename(NameOfFile,"File.dat");
}
void EncryptionFile::DecryptFile()
{
   DES Decyption;
   fpos_t pos;
   FILE *FileWrite;
	int File,Data,x,loop;
   unsigned int FileData[64];
   unsigned int *buf;
   char FileList[5][14]={"Encrypt00.dat","Encrypt01.dat","Encrypt02.dat"
   					      ,"Encrypt03.dat","Encrypt04.dat"};
   buf = (unsigned int *)malloc(1);
   *buf = 0;
   loop = 4;
   do
   {
   	File = _rtl_open(FileList[loop],SH_DENYRW);
      for(int i=1;i<9;i++)
      {
         	Data=_rtl_read(File,buf,1);
          	HextoBin(*buf,FileData,i);
      }
      _rtl_close(File);
      Decyption.Decypt(FileData);
   x=BintoHex(FileData,8);
   FileWrite = _fsopen("File.dat","r+b",SH_DENYNO);
   pos=256*x;
   fsetpos(FileWrite,&pos);
   for (int i=1;i<8;i++)
   {
      *buf=BintoHex(FileData,i);
   	fwrite(buf,1,1,FileWrite);
   }
   fclose(FileWrite);
   loop--;
   } while (loop>-1);
   free(buf);
   rename("File.dat","Run.exe");

}
void main()
{
	EncryptionFile DecrypttoRun;
   DecrypttoRun.DecryptFile();
   system("del Encrypt*.*");
   system("run.exe");
   DecrypttoRun.EncryptFile("Run.exe");
}
