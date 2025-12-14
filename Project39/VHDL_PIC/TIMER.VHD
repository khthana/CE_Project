library IEEE;
use IEEE.std_logic_1164.all;
entity TIMER is
        port (  reset   : in  std_logic;
                clk     : in  std_logic;
                inc     : in  std_logic;
                wr      : in  std_logic;
                din     : in  std_logic_vector(7 downto 0);
                ov      : out std_logic;
                dout    : out std_logic_vector(7 downto 0) );
end;

architecture rtl of TIMER is

        function increment(val : std_logic_vector) return std_logic_vector
        is
                variable result : std_logic_vector(val'length downto 0);
                variable carry  : std_logic_vector(val'length downto 0);
        begin
                carry(0) := '1';
                for i in val'low to val'high loop
                        result(i)  := val(i) xor carry(i);
                        carry(i+1) := val(i) and carry(i);
                end loop;
                result(val'length) := carry(val'length);
                return result;
        end increment;

        signal  TMR0      : std_logic_vector(8 downto 0);

begin
        dout <= TMR0(7 downto 0);
        ov   <= TMR0(8);

        TIMER0:
        process(clk,reset)
        begin
                if     reset = '1' then
                        TMR0 <= (others => '0');
                elsif  rising_edge(clk) then
                        if      wr  = '1' then
                                TMR0 <= '0' & din;
                        elsif   inc = '1' then
                                TMR0 <= increment(TMR0(7 downto 0));
                        end if;
                end if;
        end process;

end rtl;
