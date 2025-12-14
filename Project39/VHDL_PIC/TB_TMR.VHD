
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

architecture tb_tmr of ROM_1kx14 is
subtype adr_range is integer range 0 to 34;
-- declare 1Kx14 ROM
subtype ROM_WORD is std_logic_vector(13 downto 0);
type ROM_TABLE is array (0 to 34) of ROM_WORD;
constant ROM : ROM_TABLE := ROM_TABLE'(
   ROM_WORD'("10100000001001"), -- 00000 2809 
   ROM_WORD'("00000000000000"), -- 00001    0 
   ROM_WORD'("00000000000000"), -- 00002    0 
   ROM_WORD'("00000000000000"), -- 00003    0 
   ROM_WORD'("10000000011001"), -- 00004 2019 
   ROM_WORD'("00000000000000"), -- 00005    0 
   ROM_WORD'("00000000000000"), -- 00006    0 
   ROM_WORD'("00000000000000"), -- 00007    0 
   ROM_WORD'("00000000001001"), -- 00008    9 
   ROM_WORD'("01011010000011"), -- 00009 1683 
   ROM_WORD'("11000000000000"), -- 00010 3000 
   ROM_WORD'("00000010000101"), -- 00011   85 
   ROM_WORD'("11000000000000"), -- 00012 3000 
   ROM_WORD'("00000010000110"), -- 00013   86 
   ROM_WORD'("11000010100000"), -- 00014 30a0 
   ROM_WORD'("00000010001011"), -- 00015   8b 
   ROM_WORD'("11000000000000"), -- 00016 3000 
   ROM_WORD'("00000010000001"), -- 00017   81 
   ROM_WORD'("01001010000011"), -- 00018 1283 
   ROM_WORD'("11000011110000"), -- 00019 30f0 
   ROM_WORD'("00000010000001"), -- 00020   81 
   ROM_WORD'("00000010000101"), -- 00021   85 
   ROM_WORD'("00000010000110"), -- 00022   86 
   ROM_WORD'("10100000010111"), -- 00023 2817 
   ROM_WORD'("00000000000000"), -- 00024    0 
   ROM_WORD'("01001010000011"), -- 00025 1283 
   ROM_WORD'("11000011110000"), -- 00026 30f0 
   ROM_WORD'("00000010000001"), -- 00027   81 
   ROM_WORD'("01000100001011"), -- 00028 110b 
   ROM_WORD'("11000011111111"), -- 00029 30ff 
   ROM_WORD'("00000010000101"), -- 00030   85 
   ROM_WORD'("00000010000110"), -- 00031   86 
   ROM_WORD'("00000000001000"), -- 00032    8
   ROM_WORD'("00000000001000"), -- 00033    8
   ROM_WORD'("00000000001000")  -- 00034    8
);


     function to_integer(val : std_logic_vector) return adr_range
     is
--             variable sum : adr_range;
             variable sum,tmp : integer range 0 to 8192;
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
end tb_tmr;
