
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

architecture tb_ctrl of ROM_1kx14 is
subtype adr_range is integer range 0 to 110;
-- declare 1Kx14 ROM
subtype ROM_WORD is std_logic_vector(13 downto 0);
type ROM_TABLE is array (0 to 110) of ROM_WORD;
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
   ROM_WORD'("11000000000110"), -- 00023 3006 
   ROM_WORD'("00000010000011"), -- 00024   83 
   ROM_WORD'("11000011111111"), -- 00025 30ff 
   ROM_WORD'("00000000000000"), -- 00026    0 
   ROM_WORD'("00000000000000"), -- 00027    0 
   ROM_WORD'("11111000000001"), -- 00028 3e01 
   ROM_WORD'("01110000000011"), -- 00029 1c03 
   ROM_WORD'("10100001101010"), -- 00030 286a 
   ROM_WORD'("01110010000011"), -- 00031 1c83 
   ROM_WORD'("10100001101010"), -- 00032 286a 
   ROM_WORD'("01110100000011"), -- 00033 1d03 
   ROM_WORD'("10100001101010"), -- 00034 286a 
   ROM_WORD'("00100000001010"), -- 00035  80a 
   ROM_WORD'("11100111100111"), -- 00036 39e7 
   ROM_WORD'("00000010001010"), -- 00037   8a 
   ROM_WORD'("10000001011111"), -- 00038 205f 
   ROM_WORD'("00100000001010"), -- 00039  80a 
   ROM_WORD'("11100000011000"), -- 00040 3818 
   ROM_WORD'("00000010001010"), -- 00041   8a 
   ROM_WORD'("10000001011111"), -- 00042 205f 
   ROM_WORD'("00100000001010"), -- 00043  80a 
   ROM_WORD'("11100111100111"), -- 00044 39e7 
   ROM_WORD'("00000010001010"), -- 00045   8a 
   ROM_WORD'("10000001100011"), -- 00046 2063 
   ROM_WORD'("11111000000001"), -- 00047 3e01 
   ROM_WORD'("01110000000011"), -- 00048 1c03 
   ROM_WORD'("10100001101010"), -- 00049 286a 
   ROM_WORD'("00100000001010"), -- 00050  80a 
   ROM_WORD'("11100000011000"), -- 00051 3818 
   ROM_WORD'("00000010001010"), -- 00052   8a 
   ROM_WORD'("10000001100011"), -- 00053 2063 
   ROM_WORD'("11111000000001"), -- 00054 3e01 
   ROM_WORD'("01110000000011"), -- 00055 1c03 
   ROM_WORD'("10100001101010"), -- 00056 286a 
   ROM_WORD'("11000000000000"), -- 00057 3000 
   ROM_WORD'("00000010001111"), -- 00058   8f 
   ROM_WORD'("00111110001111"), -- 00059  f8f 
   ROM_WORD'("10100000111110"), -- 00060 283e 
   ROM_WORD'("10100001101010"), -- 00061 286a 
   ROM_WORD'("00100000001111"), -- 00062  80f 
   ROM_WORD'("11111011111111"), -- 00063 3eff 
   ROM_WORD'("01100000000011"), -- 00064 1803 
   ROM_WORD'("10100001000011"), -- 00065 2843 
   ROM_WORD'("10100001101010"), -- 00066 286a 
   ROM_WORD'("11000011111111"), -- 00067 30ff 
   ROM_WORD'("00000010001111"), -- 00068   8f 
   ROM_WORD'("00111100001111"), -- 00069  f0f 
   ROM_WORD'("10100001101010"), -- 00070 286a 
   ROM_WORD'("11111011111111"), -- 00071 3eff 
   ROM_WORD'("01110000000011"), -- 00072 1c03 
   ROM_WORD'("10100001001011"), -- 00073 284b 
   ROM_WORD'("10100001101010"), -- 00074 286a 
   ROM_WORD'("11000000000001"), -- 00075 3001 
   ROM_WORD'("00000010001111"), -- 00076   8f 
   ROM_WORD'("00101100001111"), -- 00077  b0f 
   ROM_WORD'("10100001101010"), -- 00078 286a 
   ROM_WORD'("11111011111111"), -- 00079 3eff 
   ROM_WORD'("01110000000011"), -- 00080 1c03 
   ROM_WORD'("10100001010011"), -- 00081 2853 
   ROM_WORD'("10100001101010"), -- 00082 286a 
   ROM_WORD'("11000011111111"), -- 00083 30ff 
   ROM_WORD'("00000010001111"), -- 00084   8f 
   ROM_WORD'("00101110001111"), -- 00085  b8f 
   ROM_WORD'("10100001011000"), -- 00086 2858 
   ROM_WORD'("10100001101010"), -- 00087 286a 
   ROM_WORD'("00100000001111"), -- 00088  80f 
   ROM_WORD'("11111000000001"), -- 00089 3e01 
   ROM_WORD'("01110000000011"), -- 00090 1c03 
   ROM_WORD'("10100001100101"), -- 00091 2865 
   ROM_WORD'("10100001101010"), -- 00092 286a 
   ROM_WORD'("10100001011110"), -- 00093 285e 
   ROM_WORD'("00000000001000"), -- 00094    8 
   ROM_WORD'("10000001011101"), -- 00095 205d 
   ROM_WORD'("00000000001000"), -- 00096    8 
   ROM_WORD'("10100001100010"), -- 00097 2862 
   ROM_WORD'("00000000001000"), -- 00098    8 
   ROM_WORD'("10000001100001"), -- 00099 2061 
   ROM_WORD'("11010011111111"), -- 00100 34ff 
   ROM_WORD'("01001010000011"), -- 00101 1283 
   ROM_WORD'("11000011111111"), -- 00102 30ff 
   ROM_WORD'("00000010000101"), -- 00103   85 
   ROM_WORD'("00000010000110"), -- 00104   86 
   ROM_WORD'("10100001101001"), -- 00105 2869 
   ROM_WORD'("01001010000011"), -- 00106 1283 
   ROM_WORD'("11000011111111"), -- 00107 30ff 
   ROM_WORD'("00000010000101"), -- 00108   85 
   ROM_WORD'("10100001101101"), -- 00109 286d 
   ROM_WORD'("00000000000000")  -- 00110    0 
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
end tb_ctrl;