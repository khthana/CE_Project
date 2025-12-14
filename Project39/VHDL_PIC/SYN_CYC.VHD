library IEEE;
use IEEE.std_logic_1164.all;
entity SYN_CYC is
        port (  reset   : in  std_logic;
                clkq2   : in  std_logic;
                clkq4   : in  std_logic;
                pscale  : in  std_logic;
                trigged : in  std_logic;
                inctmr0 : out std_logic  );
end;

architecture rtl of SYN_CYC is
        type    STATE_TYPE is (S0,S1,S2);
        signal  CURRENT_STATE,NEXT_STATE : STATE_TYPE;
        signal  clk,iclk,inc_previous : std_logic;
begin
        clk     <= clkq2 or clkq4;
        iclk    <= clkq2 when pscale = '0' else clkq4;

        SAMPLE_SET:
        process(clk,reset)
        begin
                if    reset = '1' then
                       CURRENT_STATE <= S0;
                elsif rising_edge(clk) then
                       CURRENT_STATE <= NEXT_STATE;
                end if;
        end process;

        PREPARE_INC:
        process(CURRENT_STATE,trigged)
        begin 
                case CURRENT_STATE is
                        when S0 =>
                                inc_previous <= '0';                          
                                if trigged = '1' then
                                        NEXT_STATE <= S1;
                                else
                                        NEXT_STATE <= S0;
                                end if;
                        when S1 =>
                                inc_previous <= '0';
                                if trigged = '1' then
                                        NEXT_STATE <= S1;
                                else
                                        NEXT_STATE <= S2;
                                end if;
                        when S2=>
                                inc_previous <= '1';
                                if trigged = '1' then
                                        NEXT_STATE <= S1;
                                else
                                        NEXT_STATE <= S0;
                                end if;

                        end case;
        end process;

        INC_TIMER:
        process(iclk,reset)
        begin
                if    reset = '1' then
                        inctmr0 <= '0';
                elsif falling_edge(iclk) then
                     inctmr0 <= inc_previous;
               end if;
        end process;

end rtl;
