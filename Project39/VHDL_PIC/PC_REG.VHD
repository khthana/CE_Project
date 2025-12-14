library IEEE;
use IEEE.std_logic_1164.all;
entity PC_REG is
        port (  clk     : in  std_logic;
                reset   : in  std_logic;
                We_PC   : in  std_logic;
                Inc_PC  : in  std_logic;
                PC_in   : in  std_logic_vector(12 downto 0);
                PC_out  : out std_logic_vector(12 downto 0) );
end;

architecture rtl of PC_REG is

        function increment(val : std_logic_vector) return std_logic_vector
        is
                variable result : std_logic_vector(val'range);
                variable carry : std_logic;
        begin
                carry := '1';
                for i in val'low to val'high loop
                        result(i) := val(i) xor carry;
                        carry := val(i) and carry;
                end loop;
                return result;
        end increment;

        signal PC : std_logic_vector(12 downto 0);

begin
        PC_out <= PC;

        PC_BLOCK:
	process(clk, reset)
	begin
                if   (reset = '1') then
                        PC <= "0000000000000";
                elsif rising_edge(clk) then
                        if    Inc_pc = '1' then
                                  PC <= Increment(PC);
                        elsif We_PC = '1' then
                                  PC <= PC_in;
                        end if;
		end if;
	end process;

end rtl;
