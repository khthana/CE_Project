
--
-- VHDL Program Memory Code 
library ieee;
use ieee.std_logic_1164.all;

entity ROM_1kx14 is
  port ( address : in  std_logic_vector(12 downto 0);
         oe      : in  std_logic;
         dout    : out std_logic_vector(13 downto 0)
       );
end ROM_1kx14;

architecture tb_arm4 of ROM_1kx14 is
subtype adr_range is integer range 0 to 91;
-- declare 1Kx14 ROM
subtype ROM_WORD is std_logic_vector(13 downto 0);
type ROM_TABLE is array (0 to 91) of ROM_WORD;
constant ROM : ROM_TABLE := ROM_TABLE'(
   ROM_WORD'("10100000001001"), -- 00000 2809 
   ROM_WORD'("00000000000000"), -- 00001    0 
   ROM_WORD'("00000000000000"), -- 00002    0 
   ROM_WORD'("00000000000000"), -- 00003    0 
   ROM_WORD'("00000000000000"), -- 00004    0 
   ROM_WORD'("00000000000000"), -- 00005    0 
   ROM_WORD'("00000000000000"), -- 00006    0 
   ROM_WORD'("00000000000000"), -- 00007    0 
   ROM_WORD'("00000000000000"), -- 00008    0 
   ROM_WORD'("01011010000011"), -- 00009 1683 
   ROM_WORD'("11000000000000"), -- 00010 3000 
   ROM_WORD'("00000010000101"), -- 00011   85 
   ROM_WORD'("11000000000000"), -- 00012 3000 
   ROM_WORD'("00000010000110"), -- 00013   86 
   ROM_WORD'("11000000000000"), -- 00014 3000 
   ROM_WORD'("00000010001011"), -- 00015   8b 
   ROM_WORD'("11000000000000"), -- 00016 3000 
   ROM_WORD'("00000010000001"), -- 00017   81 
   ROM_WORD'("01001010000011"), -- 00018 1283 
   ROM_WORD'("11000000000000"), -- 00019 3000 
   ROM_WORD'("00000010000001"), -- 00020   81 
   ROM_WORD'("00000010000101"), -- 00021   85 
   ROM_WORD'("00000010000110"), -- 00022   86 
   ROM_WORD'("11000000000111"), -- 00023 3007 
   ROM_WORD'("00000010000011"), -- 00024   83 
   ROM_WORD'("11000011111111"), -- 00025 30ff 
   ROM_WORD'("00000010001111"), -- 00026   8f 
   ROM_WORD'("00001110001111"), -- 00027  38f 
   ROM_WORD'("01110000000011"), -- 00028 1c03 
   ROM_WORD'("10100001010111"), -- 00029 2857 
   ROM_WORD'("01110010000011"), -- 00030 1c83 
   ROM_WORD'("10100001010111"), -- 00031 2857 
   ROM_WORD'("01100100000011"), -- 00032 1903 
   ROM_WORD'("10100001010111"), -- 00033 2857 
   ROM_WORD'("00100000001111"), -- 00034  80f 
   ROM_WORD'("11111000000010"), -- 00035 3e02 
   ROM_WORD'("01110000000011"), -- 00036 1c03 
   ROM_WORD'("10100001010111"), -- 00037 2857 
   ROM_WORD'("11000000000111"), -- 00038 3007 
   ROM_WORD'("00000010000011"), -- 00039   83 
   ROM_WORD'("11000000000000"), -- 00040 3000 
   ROM_WORD'("00000010001111"), -- 00041   8f 
   ROM_WORD'("00001110001111"), -- 00042  38f 
   ROM_WORD'("01110000000011"), -- 00043 1c03 
   ROM_WORD'("10100001010111"), -- 00044 2857 
   ROM_WORD'("01110010000011"), -- 00045 1c83 
   ROM_WORD'("10100001010111"), -- 00046 2857 
   ROM_WORD'("01100100000011"), -- 00047 1903 
   ROM_WORD'("10100001010111"), -- 00048 2857 
   ROM_WORD'("00100000001111"), -- 00049  80f 
   ROM_WORD'("11111000000001"), -- 00050 3e01 
   ROM_WORD'("01110000000011"), -- 00051 1c03 
   ROM_WORD'("10100001010111"), -- 00052 2857 
   ROM_WORD'("11000000000111"), -- 00053 3007 
   ROM_WORD'("00000010000011"), -- 00054   83 
   ROM_WORD'("11000011111111"), -- 00055 30ff 
   ROM_WORD'("00000010001111"), -- 00056   8f 
   ROM_WORD'("00101000001111"), -- 00057  a0f 
   ROM_WORD'("01110000000011"), -- 00058 1c03 
   ROM_WORD'("10100001010111"), -- 00059 2857 
   ROM_WORD'("01110010000011"), -- 00060 1c83 
   ROM_WORD'("10100001010111"), -- 00061 2857 
   ROM_WORD'("01110100000011"), -- 00062 1d03 
   ROM_WORD'("10100001010111"), -- 00063 2857 
   ROM_WORD'("11111011111111"), -- 00064 3eff 
   ROM_WORD'("01100000000011"), -- 00065 1803 
   ROM_WORD'("10100001010111"), -- 00066 2857 
   ROM_WORD'("11000000000111"), -- 00067 3007 
   ROM_WORD'("00000010000011"), -- 00068   83 
   ROM_WORD'("11000000001111"), -- 00069 300f 
   ROM_WORD'("00000010001111"), -- 00070   8f 
   ROM_WORD'("00101010001111"), -- 00071  a8f 
   ROM_WORD'("01110000000011"), -- 00072 1c03 
   ROM_WORD'("10100001010111"), -- 00073 2857 
   ROM_WORD'("01110010000011"), -- 00074 1c83 
   ROM_WORD'("10100001010111"), -- 00075 2857 
   ROM_WORD'("01100100000011"), -- 00076 1903 
   ROM_WORD'("10100001010111"), -- 00077 2857 
   ROM_WORD'("00100000001111"), -- 00078  80f 
   ROM_WORD'("11111011110000"), -- 00079 3ef0 
   ROM_WORD'("01110000000011"), -- 00080 1c03 
   ROM_WORD'("10100001010111"), -- 00081 2857 
   ROM_WORD'("01001010000011"), -- 00082 1283 
   ROM_WORD'("11000011111111"), -- 00083 30ff 
   ROM_WORD'("00000010000101"), -- 00084   85 
   ROM_WORD'("00000010000110"), -- 00085   86 
   ROM_WORD'("10100001010110"), -- 00086 2856 
   ROM_WORD'("01001010000011"), -- 00087 1283 
   ROM_WORD'("11000011111111"), -- 00088 30ff 
   ROM_WORD'("00000010000101"), -- 00089   85 
   ROM_WORD'("10100001011010"), -- 00090 285a 
   ROM_WORD'("00000000000000")  -- 00091    0 
);


     function to_integer(val : std_logic_vector) return adr_range
     is
             variable sum : adr_range;
             variable tmp : integer range 0 to 8192;
             begin
                     tmp := 1;
                     sum := 0;
                     for i in val'low to val'high loop
                             if val(i) = '1' then
                                     sum := sum +tmp;
                             end if;
                             tmp := tmp + tmp;
                     end loop;
                     return sum;
             end to_integer;

	signal LATCH : std_logic_vector(13 downto 0);
begin
       PROG_MEM:
       process(address)
       begin
            -- Read from the program memory
               LATCH <= ROM(to_integer(address));
       end process;

       CTRL_OUTPUT:
       process(oe)
       begin
               if    oe = '0' then
                       dout <= (others => 'Z');
               else
                      -- Read from the program memory
                       dout <= LATCH;
               end if;
       end process;
end tb_arm4;