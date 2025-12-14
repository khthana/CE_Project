library IEEE;
use IEEE.std_logic_1164.all;
entity FSM_CU is
        port (  clk             : in  std_logic;
                reset           : in  std_logic;
                SKIP            : in  std_logic;
                INT             : in  std_logic;
                Write_to_PC     : in  std_logic;
                Sel_des_IR_CU   : out std_logic;
                Increase_PC     : out std_logic;
                CLR_MBR_CU      : out std_logic;
                Load_INT_CU     : out std_logic;
                WR_PC_CU        : out std_logic;
                CLR_INT_CU      : out std_logic  );
end;

architecture rtl of FSM_CU is
        type    STATE_TYPE is (Q0,Q1, Q2, Q3, Q4, Q2X, Q3X);
        signal  CURRENT_STATE,NEXT_STATE : STATE_TYPE;
begin

        SYNCH:
        process(clk,reset)
        begin
                if    reset = '1' then
                        CURRENT_STATE <= Q0;
                elsif rising_edge(clk) then
                        CURRENT_STATE <= NEXT_STATE;
                end if;
        end process;

        CU:
        process(CURRENT_STATE,SKIP,INT,Write_to_PC)
	begin
                case CURRENT_STATE is
                        when Q0 =>
                                Sel_des_IR_CU   <= '0';
                                Increase_PC     <= '0';
                                CLR_MBR_CU      <= '0';
                                Load_INT_CU     <= '0';
                                WR_PC_CU        <= '0';
                                CLR_INT_CU      <= '0';
                                NEXT_STATE      <= Q1;

                        when Q1 =>
                                if INT = '1' then
                                        Sel_des_IR_CU   <= '1';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q2X;
                                else
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '1';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q2;
                                end if;
                        when Q2 =>
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q3;
                        when Q3 =>
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q4;
                        when Q4 =>
                                if Write_to_PC = '1' then
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '1';
                                        Load_INT_CU     <= '1';
                                        WR_PC_CU        <= '1';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q1;
                                elsif SKIP = '1' then
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '1';
                                        Load_INT_CU     <= '1';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q1;
                                else
                                        Sel_des_IR_CU   <= '0';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '1';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q1;
                                end if;
                        when Q2X =>
                                        Sel_des_IR_CU   <= '1';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '1';
                                        NEXT_STATE      <= Q3X;
                        when Q3X =>
                                        Sel_des_IR_CU   <= '1';
                                        Increase_PC     <= '0';
                                        CLR_MBR_CU      <= '0';
                                        Load_INT_CU     <= '0';
                                        WR_PC_CU        <= '0';
                                        CLR_INT_CU      <= '0';
                                        NEXT_STATE      <= Q4;
                end case;
	end process;

end rtl;
