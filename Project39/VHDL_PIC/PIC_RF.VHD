library IEEE;
use IEEE.std_logic_1164.all;
entity PIC_RF is
        port (  reset                   : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q3                  : in    std_logic;
                Data_in_RF              : in    std_logic_vector(7 downto 0);
                Direct_adr_in_RF        : in    std_logic_vector(5 downto 0);
                Indirect_adr_in_RF      : in    std_logic_vector(5 downto 0);
                Addr_mode_RF            : in    std_logic;
                Write_to_RF             : in    std_logic;
                Data_out_RF             : out   std_logic_vector(7 downto 0) );
end;

architecture rtl of PIC_RF is

    component RAM32X8
        port (  ADDR      : in    std_logic_vector(4 downto 0);
                DATA      : in    std_logic_vector(7 downto 0);
                WR_ENA    : in    std_logic;
                DOUT      : out   std_logic_vector(7 downto 0)  );
    end component;

    component RAM16X8
        port (  ADDR      : in    std_logic_vector(3 downto 0);
                DATA      : in    std_logic_vector(7 downto 0);
                WR_ENA    : in    std_logic;
                DOUT      : out   std_logic_vector(7 downto 0)  );
    end component;

        signal   Addr_in : std_logic_vector(5 downto 0);
        alias    Sel_adr : std_logic is Addr_in(5);
        alias    Ram_adr1: std_logic_vector(4 downto 0) is Addr_in(4 downto 0);
        alias    Ram_adr2: std_logic_vector(3 downto 0) is Addr_in(3 downto 0);
        signal   WE_in   : std_logic;
        signal   Dout_in : std_logic_vector(7 downto 0);
        signal   Ram_in1 : std_logic_vector(7 downto 0);
        signal   Ram_out1: std_logic_vector(7 downto 0);
        signal   Ram_in2 : std_logic_vector(7 downto 0);
        signal   Ram_out2: std_logic_vector(7 downto 0);

begin
        WE_in           <= clk_q3 and Write_to_RF;
        
        MUX_ADR:
        process(Addr_mode_RF,Direct_adr_in_RF,Indirect_adr_in_RF)
        begin
                if Addr_mode_RF = '1' then
                        Addr_in <= Indirect_adr_in_RF;
                else
                        Addr_in <= Direct_adr_in_RF;
                end if;
        end process;

        MUX_RAM1:
        process(Sel_adr,Data_in_RF,Ram_out1)
        begin
                if Sel_adr = '1' then
                        Ram_in1 <= Ram_out1;
                else
                        Ram_in1 <= Data_in_RF;
                end if;
        end process;

        MUX_RAM2:
        process(Sel_adr,Data_in_RF,Ram_out2)
        begin
                if Sel_adr = '1' then
                        Ram_in2 <= Data_in_RF;
                else
                        Ram_in2 <= Ram_out2;
                end if;
        end process;

        MUX_DATA_OUT:
        process(Sel_adr,Ram_out1,Ram_out2)
        begin
                if Sel_adr = '1' then
                        Dout_in <= Ram_out2;
                else
                        Dout_in <= Ram_out1;
                end if;
        end process;

        DOUT_reg:
        process(clk_q2,Dout_in,reset)
        begin
                if    reset = '1' then
                        Data_out_RF <= (others => '0');
                elsif falling_edge(clk_q2) then
                        Data_out_RF <= Dout_in;
                end if;
        end process;

        RAM1: RAM32X8
                port map (Ram_adr1,Ram_in1,WE_in,Ram_out1);

        RAM2: RAM16X8
                port map (Ram_adr2,Ram_in2,WE_in,Ram_out2);

end rtl;

configuration rf_block of PIC_RF is
    for rtl
        ------ for testbench architecture
        for all: RAM32X8
            use entity work.RAM32X8(behavior);
	end for;

        for all: RAM16X8
            use entity work.RAM16X8(behavior);
	end for;
    end for;
end rf_block;
