library IEEE;
use IEEE.std_logic_1164.all;
entity RAM16X13 is
        port (  ADDR      : in    std_logic_vector(3 downto 0);
                DATA      : in    std_logic_vector(12 downto 0);
                WR_ENA    : in    std_logic;
                DOUT      : out   std_logic_vector(12 downto 0)  );
end;

architecture behavior of RAM16X13 is

        component MEM32X13
        port (  ADR      : in    std_logic_vector(4 downto 0);
                DI       : in    std_logic_vector(12 downto 0);
                WR       : in    std_logic;
                DO       : out   std_logic_vector(12 downto 0)  );
        end component;

        signal addrs : std_logic_vector(4 downto 0);
begin
        addrs <= '1' & addr;
        RAMBLOCK: MEM32X13 port map (addrs,data,wr_ena,dout);
end behavior;
