#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Input and Output file streams. */
FILE *fpi, *fpo;

#define MAX_MEMORY_SIZE  1024
struct {
	unsigned int  nAddress;
	unsigned int  byData;
} Memory[MAX_MEMORY_SIZE];

char sLine[80];
unsigned int  start_address, address, ndata_bytes, ndata_words;
unsigned int  data; 
unsigned int  nMemoryCount = 0;
char *MakeBinaryString (unsigned int data);

char *szHelpLine = "\
\nThe VPIC16C61 --- HEX File to Xilinx Rom conververt.\
\nUsage: HEX2ROM <filename> [<options>]\
\n  Input file is assumed to have the extension HEX.  \
\n  Output will go to the filename with the extension MEM\
\n";

char szInFilename[40];
char szOutFilename[40];
char szOutFilenameOnly[40];

/* INHX8M  variable */
char StartCharacter;
char ByteCount[2];
char Address[4];
char RecordType[2];
char LowByte;
char HighByte;
char CheckSum[2];


int bUseSTDLOGIC;

void main (int argc, char *argv[])
{
	int  i;
        int x;

	if (!(argc == 2 || argc == 3)) {
		printf (szHelpLine);
		exit(1);
	}

	if ( (strcmp(argv[1], "?") == 0) ||
		  (strcmp(argv[1], "help") == 0) ||
		  (strcmp(argv[1], "-h") == 0) ||
		  (strcmp(argv[1], "-?") == 0)) {
		printf (szHelpLine);
		exit(1);
	}

	strcpy (szInFilename, argv[1]);
	if ( strstr(szInFilename, ".") == 0)
		strcat (szInFilename, ".hex");

	strcpy (szOutFilename, argv[2]);
	strcpy (szOutFilenameOnly,szOutFilename);
	strcat (szOutFilename, ".mem");

	/* Open input HEX file */
	if((fpi=fopen(szInFilename, "r"))==NULL){
		printf("Can't open file %s.\n", szInFilename);
		exit(1);
	}
        /* Open output mem file */
        if ((fpo = fopen(szOutFilename, "w")) == NULL) {
                printf("Can't open mem file '%s'. \n",szOutFilename);
                exit(1);
        }

        while (!feof(fpi)) {
           /* get 1 line */
           fgets(sLine, 80, fpi);
           x = strlen(sLine);
           if  (x  >= 10) {
            i = 9;

	  sscanf(&sLine[1],"%2x%4x",&ndata_bytes,&start_address);
	  if ( start_address >= 0 && ndata_bytes > 0)
          { 
            ndata_words = ndata_bytes/2;
            start_address = start_address/2;

            for (address = start_address; address < start_address + ndata_words; address++)
            {
               sscanf(&sLine[i], "%04x",&data);
               
               /* swap 4 bits */
               data =  ((data >> 8) & 0x00ff) | ((data << 8) & 0xff00);
               i += 4;

	       Memory[nMemoryCount].nAddress = address;
               Memory[nMemoryCount].byData   = data;
               nMemoryCount++;
             }
	    }
	   } /* end while */
        }
        fprintf(fpo,"\n;====================================;");
        fprintf(fpo,"\n;= Program memory for VPIC16C61     =;");
	fprintf(fpo,"\n;====================================;");
	fprintf(fpo,"\nTYPE   ROM       ; The memory is ROM=;");
	fprintf(fpo,"\nDEPTH  %03d       ; Words deep       =;",nMemoryCount);
	fprintf(fpo,"\nWIDTH   14       ; Bits wide        =;");
	fprintf(fpo,"\n;====================================;");
	fprintf(fpo,"\nPART 4010PC84-5  ; Device           =;");
	fprintf(fpo,"\nSYMBOL NONE                           ");
	fprintf(fpo,"\nDEFAULT   1      ;<- Unspecification=;");
	fprintf(fpo,"\n;====================================;");
	fprintf(fpo,"\nDATA   2#%14s#,",MakeBinaryString(Memory[0].byData)+2);
	for (i = 1; i< nMemoryCount; i++) {
	  if ( i != (nMemoryCount -1) )
	  {
	    fprintf(fpo,"\n       2#%14s#,",MakeBinaryString(Memory[i].byData)+2
	    );
	  }else
	  {
	    fprintf(fpo,"\n       2#%14s# ",MakeBinaryString(Memory[i].byData)+2
	    );
	 }
	}

	fprintf(fpo,"\n;                <- Initailization  =;");
	fprintf(fpo,"\n;====================================;");

	fclose(fpi);
	fclose(fpo);

}

/*

 Return an ASCII formatted binary string of exactly 16 digits.
 eg. If the data value was 5344 decimal, then the string would be:
    "0001010011100000"

 Nothin' fancy.  Always output leading zeros, not too much error checking..
	Last change:  C    29 Jan 97    0:14 am
*/

char *MakeBinaryString (unsigned int data)
{
	static char szBinary[20];
/* Statically allocated!  Caller better use immediately */
        int  i;


	for (i = 0; i < 16; i++) {
		if (data & 0x8000) {
			szBinary[i] = '1';
		}
		else {
			szBinary[i] = '0';
		}
		data <<= 1;
	}

	/* Zero terminate */
      /*
	szBinary[i] = '\0';
      */
	return szBinary;
}

