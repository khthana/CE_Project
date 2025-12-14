------------------------------------------------------------------------
-- ALU block
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity PIC_ALU is
    port (
        clk                     : in    std_logic;
        reset                   : in    std_logic;
        Data_in_ALU             : in    std_logic_vector(7 downto 0);
        IR_operand_in_ALU       : in    std_logic_vector(7 downto 0);
        IR_b_in_ALU             : in    std_logic_vector(2 downto 0);
        Sel_first_operand_ALU   : in    std_logic_vector(1 downto 0);
        Sel_second_operand_ALU  : in    std_logic_vector(1 downto 0);
        Execute_ALU             : in    std_logic_vector(4 downto 0);
        Check_STATUS_ALU        : in    std_logic_vector(2 downto 0);
        Write_to_W_ALU          : in    std_logic;
        Write_to_STATUS_ALU     : in    std_logic;
        Write_to_FSR_ALU        : in    std_logic;
        Data_out_ALU            : out   std_logic_vector(7 downto 0);
        FSR_out_ALU             : out   std_logic_vector(7 downto 0);
        STATUS_out_ALU          : out   std_logic_vector(7 downto 0);
        ALU_Zero_flag           : out   std_logic     );
end PIC_ALU;

architecture rtl of PIC_ALU is

    component ALU_UNIT
        port (  Execute         : in  std_logic_vector(4 downto 0);
                Carry_in        : in  std_logic;
                S1_in           : in  std_logic_vector(7 downto 0);
                S2_in           : in  std_logic_vector(7 downto 0);
                F_out           : out std_logic_vector(7 downto 0);
                cf              : out std_logic;
                dcf             : out std_logic;
                zf              : out std_logic );
    end component;

        signal ALU_out          : std_logic_vector(7 downto 0);
        alias  ALU_L3_out       : std_logic_vector(2 downto 0) is
                                        ALU_out(2 downto 0);
        signal STATUS_L3_out    : std_logic_vector(2 downto 0);
        signal STATUS_U3_out    : std_logic_vector(2 downto 0);
        signal Dec3to8_out      : std_logic_vector(7 downto 0);
        signal Dec3to8_bar_out  : std_logic_vector(7 downto 0);
        signal First_operand    : std_logic_vector(7 downto 0);
        signal Second_operand   : std_logic_vector(7 downto 0);
        signal W_out            : std_logic_vector(7 downto 0);
        signal ALU_flag_out     : std_logic_vector(2 downto 0);
        signal MUX_flag_out     : std_logic_vector(2 downto 0);
        signal SEL_flag_out     : std_logic_vector(2 downto 0);

begin

        Data_out_ALU    <= ALU_out;
        STATUS_out_ALU  <= STATUS_U3_out & "11" & STATUS_L3_out;
        ALU_zero_flag   <= ALU_flag_out(2);

        W_reg:
        process(clk,reset)
        begin
                if    reset = '1' then
                        W_out <= (others => '0');
                elsif rising_edge(clk) then
                        if  Write_to_W_ALU = '1' then
                                W_out <= ALU_out;
                        end if;
		end if;
        end process;

        FSR_reg:
        process(clk,reset)
    	begin
                if    reset = '1' then
                        FSR_out_ALU <= (others => '0');
                elsif rising_edge(clk) then
                        if  Write_to_FSR_ALU = '1' then
                                FSR_out_ALU <= ALU_out;
                        end if;
		end if;
        end process;

        STATUS_lowreg:
        process(clk,reset)
    	begin
                if rising_edge(clk) then
                        STATUS_L3_out <= SEL_flag_out;
		end if;
        end process;

        STATUS_upreg:
        process(clk,reset)
    	begin
		if (reset = '1') then
                        STATUS_U3_out <=  "000";
                elsif rising_edge(clk) then
                        if Write_to_STATUS_ALU = '1' then
                                STATUS_U3_out <= ALU_out(7 downto 5);
                        end if;
		end if;
        end process;

        Decoder_3to8:
        process(IR_b_in_ALU)
	begin
		case IR_b_in_ALU is
                        when "000"  =>  Dec3to8_out     <= "00000001";
                                        Dec3to8_bar_out <= "11111110";
                        when "001"  =>  Dec3to8_out     <= "00000010";
                                        Dec3to8_bar_out <= "11111101";
                        when "010"  =>  Dec3to8_out     <= "00000100";
                                        Dec3to8_bar_out <= "11111011";
                        when "011"  =>  Dec3to8_out     <= "00001000";
                                        Dec3to8_bar_out <= "11110111";
                        when "100"  =>  Dec3to8_out     <= "00010000";
                                        Dec3to8_bar_out <= "11101111";
                        when "101"  =>  Dec3to8_out     <= "00100000";
                                        Dec3to8_bar_out <= "11011111";
                        when "110"  =>  Dec3to8_out     <= "01000000";
                                        Dec3to8_bar_out <= "10111111";
                        when others =>  Dec3to8_out     <= "10000000";
                                        Dec3to8_bar_out <= "01111111";
		end case;
        end process;

        First_MUX:
        process(Sel_first_operand_ALU,Data_in_ALU,IR_operand_in_ALU)
	begin
                case Sel_first_operand_ALU is
                        when "01" =>
                                First_operand <= IR_operand_in_ALU;
                        when "11" =>
                                First_operand <= "00000000";
                        when others =>
                                First_operand <= Data_in_ALU;
                end case;
        end process;

        Second_MUX:
        process(Sel_second_operand_ALU,Data_in_ALU,Dec3to8_out,Dec3to8_bar_out,W_out)
	begin
		case Sel_second_operand_ALU is
                        when "00" =>
                                Second_operand <= Data_in_ALU(3 downto 0) &
                                                  Data_in_ALU(7 downto 4);
                        when "01" =>
                                Second_operand <= Dec3to8_bar_out;
                        when "10" =>
                                Second_operand <= Dec3to8_out;
                        when others =>
				Second_operand <= W_out;
                end case;
        end process;

        ALU:
        ALU_UNIT port map(Execute_ALU,STATUS_L3_out(0),
                          First_operand,Second_operand,ALU_out,
                          ALU_flag_out(0),ALU_flag_out(1),ALU_flag_out(2));

        MUX_flag:
        process(Write_to_STATUS_ALU,STATUS_L3_out,ALU_L3_out)
	begin
                if Write_to_STATUS_ALU = '1' then
                        MUX_flag_out <= ALU_L3_out;
		else
                        MUX_flag_out <= STATUS_L3_out;
		end if;
        end process;

        Sel_flag:
        process(Check_STATUS_ALU,MUX_flag_out,ALU_flag_out)
	begin
                for i in Check_STATUS_ALU'range loop
                        if Check_STATUS_ALU(i) = '1' then
                                SEL_flag_out(i) <= ALU_flag_out(i);
                        else
                                SEL_flag_out(i) <= MUX_flag_out(i);
                        end if;
                end loop;
        end process;

end rtl;

configuration alu_block of PIC_ALU is
    for rtl
        for all: ALU_UNIT
            use entity work.ALU_UNIT(rtl);
	end for;
    end for;
end alu_block;
