library IEEE;
use IEEE.std_logic_1164.all;
library exemplar;
use exemplar.exemplar_1164.all;

entity PIC_PC is
        port (  clk                     : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q3                  : in    std_logic;
                clk_q4                  : in    std_logic;
                reset                   : in    std_logic;
                Data_in_PC              : in    std_logic_vector( 7 downto 0);
                IR_jmp_in_PC            : in    std_logic_vector(10 downto 0);
                Sel_part_PC             : in    std_logic_vector( 1 downto 0);
                Increase_PC             : in    std_logic;
                Write_to_PC             : in    std_logic;
                Write_to_PCLATH_PC      : in    std_logic;
                Sel_SADR_PC             : in    std_logic;
                Update_SP_PC            : in    std_logic_vector( 1 downto 0);
                Write_to_STACK_PC       : in    std_logic;
                Call_int                : in    std_logic;
                PCLATH_out_PC           : out   std_logic_vector( 7 downto 0);
                PC_out_PC               : out   std_logic_vector(12 downto 0) );
end;

architecture rtl of PIC_PC is

    component PC_REG
        port (  clk     : in  std_logic;
                reset   : in  std_logic;
                We_PC   : in  std_logic;
                Inc_PC  : in  std_logic;
                PC_in   : in  std_logic_vector(12 downto 0);
                PC_out  : out std_logic_vector(12 downto 0) );
    end component;

    component SP_REG
        port (  clk     : in  std_logic;
                reset   : in  std_logic;
                Upd     : in  std_logic_vector(1 downto 0);
                Data_out: out std_logic_vector(2 downto 0) );
    end component;

    component RAM16X13
        port (  ADDR      : in    std_logic_vector(3 downto 0);
                DATA      : in    std_logic_vector(12 downto 0);
                WR_ENA    : in    std_logic;
                DOUT      : out   std_logic_vector(12 downto 0)  );
    end component;

        signal  clk_bar         : std_logic;
        signal  PCLATH_out      : std_logic_vector( 4 downto 0);
        signal  PC_ip           : std_logic_vector(12 downto 0);
        signal  PC_op           : std_logic_vector(12 downto 0);
        signal  PC_dec          : std_logic_vector(12 downto 0);
        signal  Ram_adr         : std_logic_vector( 3 downto 0);
        signal  WE_in           : std_logic;
        signal  SP_out          : std_logic_vector( 2 downto 0);
        signal  SADR_out        : std_logic_vector( 2 downto 0);
        signal  Ram_out         : std_logic_vector(12 downto 0);

begin
        WE_in           <= clk_q3 and Write_to_STACK_PC and clk_bar;
        PCLATH_out_PC   <= "000" & PCLATH_out;
        PC_out_PC       <= PC_op;
        PC_dec          <= PC_op-"1" when Call_int = '0' else PC_op;
        clk_bar         <= not clk;

        MUX_PCH1:
        process(Sel_part_PC,PCLATH_out(4 downto 3),Ram_out(12 downto 11))
        begin
                if Sel_part_PC(1) /= Sel_part_PC(0) then
                        PC_ip(12 downto 11) <= Ram_out(12 downto 11);
                else
                        PC_ip(12 downto 11) <= PCLATH_out( 4 downto  3);
                end if;
        end process;

        MUX_PCH0:
        process(Sel_part_PC,PCLATH_out(2 downto 0),Ram_out(10 downto 8),IR_jmp_in_PC(10 downto 8))
        begin
                case Sel_part_PC is
                        when "00" =>
                                PC_ip(10 downto 8) <= PCLATH_out( 2 downto 0);
                        when "01" =>
                                PC_ip(10 downto 8) <= Ram_out(10 downto 8);
                        when others =>
                                PC_ip(10 downto 8) <= IR_jmp_in_PC(10 downto 8);
                end case;
        end process;

        MUX_PCL:
        process(Sel_part_PC,Data_in_PC,Ram_out(7 downto 0),IR_jmp_in_PC(7 downto 0))
        begin
                case Sel_part_PC is
                        when "00" =>
                                PC_ip(7 downto 0) <= Data_in_PC;
                        when "01" =>
                                PC_ip(7 downto 0) <= Ram_out(7 downto 0);
                        when others =>
                                PC_ip(7 downto 0) <= IR_jmp_in_PC(7 downto 0);
                end case;
        end process;


        PCLATH_reg:
        process(clk_q4,reset)
        begin
                if (reset = '1') then
                        PCLATH_out <= "00000";
                elsif rising_edge(clk_q4) then
                        if Write_to_PCLATH_PC = '1' then
                                PCLATH_out <= Data_in_PC(4 downto 0);
                        end if;
                end if;
        end process;

        SADR_reg:
        process(clk_q2,reset)
        begin
                if    reset = '1' then
                        SADR_out <= (others => '0');
                elsif rising_edge(clk_q2) then
                        SADR_out <= SP_out;
                end if;
        end process;

        MUX_STACK_ADR:
        process(Sel_SADR_PC,SP_out,SADR_out)
        begin
                if Sel_SADR_PC = '1' then
                        Ram_adr <= '0' & SADR_out;
                else
                        Ram_adr <= '0' & SP_out;
                end if;
        end process;

        SP:  SP_REG
                port map (clk_q3,reset,Update_SP_PC,SP_out);

        PC:  PC_REG
                port map (clk_bar,reset,Write_to_PC,Increase_PC,PC_ip,PC_op);

        RAM: RAM16X13
                port map (Ram_adr,Pc_dec,WE_in,Ram_out);

end rtl;

configuration pc_block of PIC_PC is
    for rtl
        for all: PC_REG
            use entity work.PC_REG(rtl);
	end for;
        for all: SP_REG
            use entity work.SP_REG(rtl);
	end for;
        for all: RAM16X13
            use entity work.RAM16X13(behavior);
	end for;
    end for;
end pc_block;
