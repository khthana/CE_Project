library IEEE;
use IEEE.std_logic_1164.all;
entity RAM32X8 is
        port (  ADDR      : in    std_logic_vector(4 downto 0);
                DATA      : in    std_logic_vector(7 downto 0);
                WR_ENA    : in    std_logic;
                DOUT      : out   std_logic_vector(7 downto 0)  );
end;

architecture behavior of RAM32X8 is

        component MEM32X8
        port (  ADR      : in    std_logic_vector(4 downto 0);
                DI       : in    std_logic_vector(7 downto 0);
                WR       : in    std_logic;
                DO       : out   std_logic_vector(7 downto 0)  );
        end component;
begin
        RAMBLOCK: MEM32X8 port map (addr,data,wr_ena,dout);
end behavior;
