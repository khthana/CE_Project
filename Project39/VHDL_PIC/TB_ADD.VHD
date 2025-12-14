
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

architecture tb_add of ROM_1kx14 is
subtype adr_range is integer range 0 to 71;
-- declare 1Kx14 ROM
subtype ROM_WORD is std_logic_vector(13 downto 0);
type ROM_TABLE is array (0 to 71) of ROM_WORD;
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
   ROM_WORD'("11000000000001"), -- 00023 3001 
   ROM_WORD'("00000010010101"), -- 00024   95 
   ROM_WORD'("11000000000010"), -- 00025 3002 
   ROM_WORD'("00000010010100"), -- 00026   94 
   ROM_WORD'("11000010011001"), -- 00027 3099 
   ROM_WORD'("00000010010110"), -- 00028   96 
   ROM_WORD'("11000000100001"), -- 00029 3021 
   ROM_WORD'("00000010000100"), -- 00030   84 
   ROM_WORD'("10000000101001"), -- 00031 2029 
   ROM_WORD'("00100000100001"), -- 00032  821 
   ROM_WORD'("11111011111110"), -- 00033 3efe 
   ROM_WORD'("01100000000011"), -- 00034 1803 
   ROM_WORD'("10100001000011"), -- 00035 2843 
   ROM_WORD'("00100000100010"), -- 00036  822 
   ROM_WORD'("11111011111101"), -- 00037 3efd 
   ROM_WORD'("01100000000011"), -- 00038 1803 
   ROM_WORD'("10100001000011"), -- 00039 2843 
   ROM_WORD'("10100000111110"), -- 00040 283e 
   ROM_WORD'("01011010000011"), -- 00041 1683 
   ROM_WORD'("00100000010110"), -- 00042  816 
   ROM_WORD'("00011100010100"), -- 00043  714 
   ROM_WORD'("00000010001101"), -- 00044   8d 
   ROM_WORD'("11111000000110"), -- 00045 3e06 
   ROM_WORD'("01100010000011"), -- 00046 1883 
   ROM_WORD'("10100000110001"), -- 00047 2831 
   ROM_WORD'("00100000001101"), -- 00048  80d 
   ROM_WORD'("00000010001101"), -- 00049   8d 
   ROM_WORD'("11111001100000"), -- 00050 3e60 
   ROM_WORD'("01100000000011"), -- 00051 1803 
   ROM_WORD'("10100000110110"), -- 00052 2836 
   ROM_WORD'("00100000001101"), -- 00053  80d 
   ROM_WORD'("00000010000000"), -- 00054   80 
   ROM_WORD'("01110000000011"), -- 00055 1c03 
   ROM_WORD'("10100000111101"), -- 00056 283d 
   ROM_WORD'("00101010000100"), -- 00057  a84 
   ROM_WORD'("00101000010101"), -- 00058  a15 
   ROM_WORD'("00000010000000"), -- 00059   80 
   ROM_WORD'("00001110000100"), -- 00060  384 
   ROM_WORD'("00000000001000"), -- 00061    8 
   ROM_WORD'("01001010000011"), -- 00062 1283 
   ROM_WORD'("11000011111111"), -- 00063 30ff 
   ROM_WORD'("00000010000101"), -- 00064   85 
   ROM_WORD'("00000010000110"), -- 00065   86 
   ROM_WORD'("10100001000010"), -- 00066 2842 
   ROM_WORD'("01001010000011"), -- 00067 1283 
   ROM_WORD'("11000011111111"), -- 00068 30ff 
   ROM_WORD'("00000010000101"), -- 00069   85 
   ROM_WORD'("10100001000110"), -- 00070 2846 
   ROM_WORD'("00000000000000")  -- 00071    0 
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
end tb_add;