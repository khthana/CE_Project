#include <fstream.h>
#include <string.h>
class ReadiniFile
{
   public:
   char Value[];

   public:
	void RdiniFile(char[],char[]);
};

void ReadiniFile::RdiniFile(char FileName[],char Segment[])
{
 	const MaxChar=12;
    char iniLine[MaxChar];
  	int testSegment;
  	unsigned int i;
  	ifstream ReadFile(FileName);

  	testSegment=0;
  	while(ReadFile)
  	{
   	ReadFile.getline(iniLine,MaxChar);
      for(i=0;i<strlen(Segment)+1;i++)
      {
      	if (Segment[i]!=iniLine[i])
         {
         	testSegment=1;
            i=strlen(Segment)+1;
         }
      }
      if(testSegment==0)
      {
      	ReadFile.getline(iniLine,MaxChar);
         strcpy(Value,iniLine);
      }
   }
}

