
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

architecture tb_call of ROM_1kx14 is
subtype adr_range is integer range 0 to 39;
-- declare 1Kx14 ROM
subtype ROM_WORD is std_logic_vector(13 downto 0);
type ROM_TABLE is array (0 to 39) of ROM_WORD;
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
   ROM_WORD'("10000000011010"), -- 00023 201a 
   ROM_WORD'("10100000011110"), -- 00024 281e 
   ROM_WORD'("10100000100011"), -- 00025 2823 
   ROM_WORD'("00000000000000"), -- 00026    0 
   ROM_WORD'("00000000000000"), -- 00027    0 
   ROM_WORD'("00000000000000"), -- 00028    0 
   ROM_WORD'("00000000001000"), -- 00029    8 
   ROM_WORD'("01001010000011"), -- 00030 1283 
   ROM_WORD'("11000011111111"), -- 00031 30ff 
   ROM_WORD'("00000010000101"), -- 00032   85 
   ROM_WORD'("00000010000110"), -- 00033   86 
   ROM_WORD'("10100000100010"), -- 00034 2822 
   ROM_WORD'("01001010000011"), -- 00035 1283 
   ROM_WORD'("11000011111111"), -- 00036 30ff 
   ROM_WORD'("00000010000101"), -- 00037   85 
   ROM_WORD'("10100000100110"), -- 00038 2826 
   ROM_WORD'("00000000000000")  -- 00039    0 
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
end tb_call;
