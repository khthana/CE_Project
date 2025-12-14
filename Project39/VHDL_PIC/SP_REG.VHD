library IEEE;
use IEEE.std_logic_1164.all;
entity SP_REG is
        port (  clk     : in  std_logic;
                reset   : in  std_logic;
                Upd     : in  std_logic_vector(1 downto 0);
                Data_out: out std_logic_vector(2 downto 0) );
end;

architecture rtl of SP_REG is
        signal  SP      : std_logic_vector(2 downto 0);

        function inc_dec(val : std_logic_vector;ctrl,cy : std_logic) return std_logic_vector
        is
                variable d_in,d_out,result : std_logic_vector(val'high downto val'low);
                variable carry :std_logic;
        begin
                carry := cy;
                if ctrl = '1' then
                -- sub
                        d_in := not val;
                else
                -- add
                        d_in := val;
                end if;

                for i in d_in'low to d_in'high loop
                        result(i) := d_in(i) xor carry;
                        carry := d_in(i) and carry;
                end loop;

                if ctrl = '1' then
                        d_out := not result;
                else
                        d_out := result;
                end if;

                return d_out;

        end inc_dec;

begin
        Data_out <= SP;

        SP_reg:
        process(clk,reset)
        begin
                if (reset = '1') then
                        SP <= "000";
                elsif rising_edge(clk) then
                        SP <= Inc_Dec(SP,Upd(1),Upd(0));
                end if;
        end process;

end rtl;
