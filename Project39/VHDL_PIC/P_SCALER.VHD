library IEEE;
use IEEE.std_logic_1164.all;
entity P_SCALER is
        port (  reset   : in  std_logic;
                inc     : in  std_logic;
                dout    : out std_logic_vector(7 downto 0) );
end;

architecture rtl of P_SCALER is
        signal  PRS : std_logic_vector(7 downto 0);

        function increment(val : std_logic_vector) return std_logic_vector
        is
                variable result : std_logic_vector(val'range);
                variable carry  : std_logic;
        begin
                carry := '1';
                for i in val'low to val'high loop
                        result(i) := val(i) xor carry;
                        carry := val(i) and carry;
                end loop;
                return result;
        end increment;

begin
        dout  <= PRS;

        PRESCALER:
        process(reset,inc)
	begin
		if (reset = '1') then
                        PRS <= "00000000";
                elsif rising_edge(inc) then
                        PRS <= increment(PRS);
		end if;
	end process;

end rtl;
