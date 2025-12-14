/* Filename : fields.hpp

   Declare class Fields
   "Network Monitoring System" 1998
   written by MANEECHOTE SAMARNTHAI */


   /***
       Write file by
	    *file << "Wow"; for example
				       ***/

class Fields
{
   private:
      ofstream *file;
      int num,count;
      unsigned int size;

      void realData(unsigned char[]);
      void isTCP(unsigned char[]);
      void isUDP(unsigned char[]);
      void isSPX(unsigned char[]);
      void isIP(unsigned char[]);
      void isIPX(unsigned char[]);
      void isICMP(unsigned char[]);
      void isARP(unsigned char[]);
      void isRARP(unsigned char[]);
   public:
      /******************************
       Class name:  seperate
       Description: Only method called by external
       Parameter:   1. char[] = 1 frame
       Return:      NOT
       ******************************/
      void seperate(unsigned char[],unsigned int);

      Fields(ofstream *);
      ~Fields();
};
