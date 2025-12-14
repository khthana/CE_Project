library IEEE;
use IEEE.std_logic_1164.all;
entity CLK_CU is
        port (  osc1            : in  std_logic;
                reset           : in  std_logic;
                clk_q1          : out std_logic;
                clk_q2          : out std_logic;
                clk_q3          : out std_logic;
                clk_q4          : out std_logic );
end;

architecture rtl of CLK_CU is
        type    STATE_TYPE is (S0, S1, S2, S3, S4);
        signal  CURRENT_STATE,NEXT_STATE : STATE_TYPE;
begin

        SYNCH:
        process(reset,osc1)
        begin
                if    reset = '1' then
                       CURRENT_STATE <= S0;
                elsif osc1'event and osc1 = '1'  then
                        CURRENT_STATE <= NEXT_STATE;
                end if;
        end process;

        CU:
        process(CURRENT_STATE,osc1)
	begin
                case CURRENT_STATE is
                        when S0 =>
                                clk_q1 <= '0';
                                clk_q2 <= '0';
                                clk_q3 <= '0';
                                clk_q4 <= '0';
                                NEXT_STATE <= S1;
                        when S1 =>
                                clk_q1 <= '1';
                                clk_q2 <= '0';
                                clk_q3 <= '0';
                                clk_q4 <= '0';
                                NEXT_STATE <= S2;
                        when S2 =>
                                clk_q1 <= '0';
                                clk_q2 <= '1';
                                clk_q3 <= '0';
                                clk_q4 <= '0';
                                NEXT_STATE <= S3;
                        when S3 =>
                                clk_q1 <= '0';
                                clk_q2 <= '0';
                                clk_q3 <= '1';
                                clk_q4 <= '0';
                                NEXT_STATE <= S4;
                        when S4 =>
                                clk_q1 <= '0';
                                clk_q2 <= '0';
                                clk_q3 <= '0';
                                clk_q4 <= '1';
                                NEXT_STATE <= S1;
                end case;
	end process;

end rtl;
