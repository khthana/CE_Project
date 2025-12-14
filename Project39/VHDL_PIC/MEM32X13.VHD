library IEEE;
use IEEE.std_logic_1164.all;
library xi4;
use xi4.all;

entity MEM32X13 is
        port (  ADR      : in    std_logic_vector(4 downto 0);
                DI       : in    std_logic_vector(12 downto 0);
                WR       : in    std_logic;
                DO       : out   std_logic_vector(12 downto 0)  );
end;

architecture xilinx of MEM32X13 is

        component RAM
        port (
	    A0, A1, A2, A3, A4, D, WE : in std_logic;
	    O : out std_logic
        );
        end component;

begin
        GEN_RAM: for i in 0 to 12 generate
                  ram32: RAM port map ( A0=>adr(0),A1=>adr(1),
                                        A2=>adr(2),A3=>adr(3),
                                        A4=>adr(4),d=>di(i),
                                        we=>wr,o=>do(i)   );
        end generate;

end xilinx;
