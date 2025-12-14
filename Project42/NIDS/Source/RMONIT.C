#include "rmonit.h"
 
int main(int argc,char *argv[])
{
  InitFlag();
  ParseCmdLine(argc,argv);
  CheckFlag();
  printf("End Program.\n\n");
  return 0;
}

/****************************************************
**   Function: ParseCmdLine(int,char *);
**   Purpose : Parse command line args 
**   Argument: argc => count of argunemts passed to the routine 
**             argv => 2-D character array, contains list of command line args
**   Return  : 0 => success ,  1 => exit on error 
****************************************************/
int ParseCmdLine(int argc,char *argv[])
{
   int ch;
   extern char *optarg;
   extern int optind;
   int fd;
    
   printf("Parsing command line ... \n");
   strcpy (logdir,DEFAULT_LOG_DIR);

   while ((ch = getopt(argc, argv, "h :R :t :M :o :m :v :l :s :f:d:a :c :L")) != -1)
   {
      switch(ch)
      {
        case 'h':
                  flag.host = 0;
                  break;

        case 'R':
                  flag.Realtime = 0;
                  break;


        case 'M':
                  flag.MF = 0;
                  printf("..Check MF..\n");
                  break;


        case 'o':
                  flag.framehost = 0;
                  printf("..frame per host..\n");
                  break;

        case 'm':
                  flag.framemin = 0;
                  printf("..frame per min..\n");
                  break;

        case 'L':
                  flag.log = 0;
                  printf("..Logging..\n");
                  break;

        case 'v':
                  flag.verbose = 0;
		  printf("..Verbose Mode..\n");
                  break;

        case 'd':
                  flag.log_dir = 0;
                  strcpy (logdir,optarg);
                  printf ("%s\n",logdir);
                  break;

        case 'f':
                  strcpy (&datafile[0],optarg);
                  printf ("open file name :%s\n",datafile);
                  break;
      
        case 'a': printf ("All Option\n"); 
                  flag.count = 0;
                  flag.framemin = 0;
                  flag.framehost = 0;
                  flag.land = 0;
                  break;

        case 'c': printf ("Count IP Frame ...\n");
                  flag.count = 0;
                  break;

        case 's': printf ("Sniff...\n");
                  flag.sniff = 0;
                  break;

        case 'l': printf ("Check LAND...\n");
                  flag.land = 0;
                  break;

        default : break;
      }

   }
  return 0;
}

/****************************************************
**   Function: PrintHowto();
**   Purpose : Printing How to use this program
**   Argument: none
**   Return  : none
****************************************************/
void PrintHowto(char *filename)
{
   printf("\n");
   printf("USAGE:  %s [-options] <filter options>\n",filename);
   printf("Options: \n");
   printf(" -f <file>  : check <file>\n");
   printf(" -a         : set all option\n");
   printf(" -c         : count frame\n");
   printf(" -s         : sniff\n");
   printf("\n");
}


/**************************************************
**  Function : InitFlag()
**  Purpose  : Initial vale of flag and Variable 
**  Argument : none
**  Return   : none
**************************************************/
void InitFlag()
{
  flag.count = 1;
  flag.framemin = 1;
  flag.framehost = 1;
  flag.sniff = 1;
  flag.log_dir = 1;
  flag.land = 1;
  flag.verbose = 1;
  flag.log = 1;
  flag.MF = 1;
  flag.Realtime = 1;
  flag.host = 1;
}


/*************************************************
**  Function : CheckFlag() 
**  Purpose  : Check all flag and call function
**  Argument : none 
**  Return   : none
*************************************************/
void CheckFlag()
{

  if (!flag.host) { ReadHostFromFile();} 
  if (!flag.count) { CountIPFrame(datafile,flag.log); }
  if (!flag.framemin) { FramePerMin(datafile,flag.log); }
  if (!flag.framehost) { FramePerHost(datafile,flag.log); }
  if (!flag.land) { LANDCheck(datafile,flag.log);} 
  if (!flag.MF) { CheckFragment(datafile); }
  if ((!flag.Realtime) || (!flag.sniff)) { if (fork()) exit(0); }
  if ((!flag.sniff) || (!flag.verbose) || (!flag.Realtime))
  { 
     Sniff(flag.sniff,flag.verbose,flag.Realtime,flag.host); 
  }

}

/********************
** Function : getDateHour(char *);
** Purpose  : get Date and Hour From Datafilename
** Argument : Data File Name
** Return   : none
*********************/

void getDateHour(char *datafile)
{
 strncpy(&hour[0],datafile,2);
 strcpy (&hour[2],"\0");
 strncpy(&date[0],datafile+3,11);
 strcpy (&hour[12],"\0");
}



