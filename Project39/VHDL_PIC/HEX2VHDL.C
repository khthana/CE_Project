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
\nThe Synthetic PIC --- HEX File to VHDL Memory Entity conververt.\
\nUsage: HEX2VHDL <filename> [<options>]\
\n  Input file is assumed to have the extension HEX.  \
\n  Output will go to the filename with the extension VHD\
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
	strcat (szOutFilename, ".vhd");

	/* Open input HEX file */
	if((fpi=fopen(szInFilename, "r"))==NULL){
		printf("Can't open file %s.\n", szInFilename);
		exit(1);
	}
        /* Open output vhd file */
        if ((fpo = fopen(szOutFilename, "w")) == NULL) {
                printf("Can't open vhdl file '%s'. \n",szOutFilename);
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
        fprintf(fpo, "\n--");
        fprintf(fpo, "\n-- VHDL Program Memory Code ");
        fprintf(fpo,"\nlibrary ieee;");
        fprintf(fpo,"\nuse ieee.std_logic_1164.all;\n");
	fprintf(fpo,"\nentity ROM_1kx14 is");
	fprintf(fpo,"\n  port ( address : in  std_logic_vector(12 downto 0);");
	fprintf(fpo,"\n         oe      : in  std_logic;");
	fprintf(fpo,"\n         dout    : out std_logic_vector(13 downto 0)");
	fprintf(fpo,"\n       );");
	fprintf(fpo,"\nend ROM_1kx14;");
	fprintf(fpo,"\n");
	fprintf(fpo,"\narchitecture %s of ROM_1kx14 is",szOutFilenameOnly);
	fprintf(fpo,"\n-- declare 1Kx14 ROM");
	fprintf(fpo,"\nsubtype ROM_WORD is std_logic_vector(13 downto 0);");
	fprintf(fpo,"\ntype ROM_TABLE is array (0 to %d) of ROM_WORD;",nMemoryCount );
	fprintf(fpo,"\nconstant MEM_SIZE : integer := %d;",nMemoryCount );
	fprintf(fpo,"\nconstant ROM : ROM_TABLE := ROM_TABLE'(");

	for (i = 0; i<= nMemoryCount; i++) {
	  if ( i != nMemoryCount )
	  {
	    fprintf(fpo,"\n   ROM_WORD'(\"%14s\"), -- %05d %4x ",
		 MakeBinaryString(Memory[i].byData)+2,Memory[i].nAddress,Memory[i].byData
	    );
	  }else
	  {
	    fprintf(fpo,"\n   ROM_WORD'(\"00000000000000\")  -- %05d %4x ",
		 Memory[i-1].nAddress+1,Memory[i].byData
	    );
	 }
	}

	fprintf(fpo,"\n);");

    fprintf(fpo,"\n\n");
    fprintf(fpo,"\n     function to_integer(val : std_logic_vector) return integer");
    fprintf(fpo,"\n     is");
    fprintf(fpo,"\n		variable sum,tmp : integer range 0 to 8192;");
    fprintf(fpo,"\n             begin");
    fprintf(fpo,"\n                     tmp := 1;");
    fprintf(fpo,"\n                     sum := 0;");
    fprintf(fpo,"\n                     for i in val'low to val'high loop");
    fprintf(fpo,"\n                             if val(i) = '1' then");
    fprintf(fpo,"\n                                     sum := sum +tmp;");
    fprintf(fpo,"\n                             end if;");
    fprintf(fpo,"\n                             tmp := tmp + tmp;");
    fprintf(fpo,"\n                     end loop;");
    fprintf(fpo,"\n                     return sum;");
    fprintf(fpo,"\n             end to_integer;");
    fprintf(fpo,"\n");
    fprintf(fpo,"\n	signal LATCH : std_logic_vector(13 downto 0);");

    fprintf(fpo,"\nbegin");
    fprintf(fpo,"\n       PROG_MEM:");
    fprintf(fpo,"\n       process(address)");
    fprintf(fpo,"\n       variable mindex : integer;");
    fprintf(fpo,"\n       begin");
    fprintf(fpo,"\n		-- Read from the program memory");
    fprintf(fpo,"\n		mindex := to_integer(address);");
    fprintf(fpo,"\n		if mindex > MEM_SIZE then");
    fprintf(fpo,"\n			mindex := MEM_SIZE;");
    fprintf(fpo,"\n		end if;");
    fprintf(fpo,"\n		LATCH <= ROM(mindex);");
    fprintf(fpo,"\n       end process;");
    fprintf(fpo,"\n");
    fprintf(fpo,"\n       CTRL_OUTPUT:");
    fprintf(fpo,"\n       process(oe)");
    fprintf(fpo,"\n       begin");
    fprintf(fpo,"\n               if    oe = '0' then");
    fprintf(fpo,"\n                       dout <= (others => 'Z');");
    fprintf(fpo,"\n               else");
    fprintf(fpo,"\n                      -- Read from the program memory");
    fprintf(fpo,"\n                       dout <= LATCH;");
    fprintf(fpo,"\n               end if;");
    fprintf(fpo,"\n       end process;");
    fprintf(fpo,"\nend %s;",szOutFilenameOnly);

	fclose(fpi);
	fclose(fpo);

}

/*

 Return an ASCII formatted binary string of exactly 16 digits.
 eg. If the data value was 5344 decimal, then the string would be:
    "0001010011100000"

 Nothin' fancy.  Always output leading zeros, not too much error checking..
	Last change:  C    27 Jan 97    9:22 pm
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