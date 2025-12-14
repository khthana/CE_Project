#include <fstream.h>
#include <string.h>
#include <vcl\vcl.h>
class ChangeiniFile
{
   public:
	String NewValue;
   public:
   void WrtiniFile(char[],char[]);
};
void ChangeiniFile::WrtiniFile(char FileName[],char Segment[])
{

   ofstream WriteFile(FileName);
   WriteFile<<Segment;
   WriteFile<<"\n";
   WriteFile<<NewValue;

}


