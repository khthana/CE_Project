library IEEE;
use IEEE.std_logic_1164.all;
entity DEC2_CU is
        port (  IR              : in std_logic_vector(13 downto 0);
                BANK            : in std_logic_vector(1 downto 0);
                FSR             : in std_logic_vector(6 downto 0);
                Wr_W            : out std_logic;
                Wr_STATUS       : out std_logic;
                Wr_FSR          : out std_logic;
                Wr_PC           : out std_logic;
                Wr_PCLATCH      : out std_logic;
                Adr_RF          : out std_logic;
                Wr_RF           : out std_logic;
                Wr_TMR0         : out std_logic;
                Wr_OPTION       : out std_logic;
                Wr_INTCON       : out std_logic;
                Wr_PORTA        : out std_logic;
                Wr_PORTB        : out std_logic;
                Wr_TRISA        : out std_logic;
                Wr_TRISB        : out std_logic  );
end;

architecture rtl of DEC2_CU is
        alias  fff  : std_logic_vector(6 downto 0) is IR(6 downto 0);
begin

        DECODER2_UNIT:
        process(IR,BANK,FSR)
        variable chkf  : std_logic_vector(6 downto 0);
        variable testb : std_logic;
	begin
         -- If Bit test then "testb" = '1' else '0';
         if    IR(13 downto 11) = "011" then
                testb := '0';
         else
                testb := '1';
         end if;
         if     fff = "0000000" then
                chkf   := FSR;
                Adr_RF <= '1';
         else
                chkf   := fff;
                Adr_RF <= '0';
         end if;
         if    (IR(13 downto 12) = "01") or
               (IR(13 downto 12) = "00" and IR(7) = '1') then
                        Wr_W            <= '0';
                        if chkf = "0000011" then
                           Wr_STATUS      <= testb;
                        else
                           Wr_STATUS      <= '0';
                        end if;
                        if chkf = "0000100" then
                           Wr_FSR         <= testb;
                        else
                           Wr_FSR         <= '0';
                        end if;
                        if chkf = "0000010" then
                           Wr_PC          <= testb;
                        else
                           Wr_PC          <= '0';
                        end if;
                        if chkf = "0001010" then
                           Wr_PCLATCH     <= testb;
                        else
                           Wr_PCLATCH     <= '0';
                        end if;
                        if (chkf >= "0001100") AND (chkf <= "0101111") then
                           Wr_RF          <= testb;
                        else
                           Wr_RF          <= '0';
                        end if;
                        if chkf = "0001011" then
                           Wr_INTCON      <= testb;
                        else
                           Wr_INTCON      <= '0';
                        end if;

                        if BANK = "00" then
                           if chkf = "0000001" then
                              Wr_TMR0        <= testb;
                           else
                              Wr_TMR0        <= '0';
                           end if;
                           Wr_OPTION       <= '0';
                           if chkf = "0000101" then
                              Wr_PORTA       <= testb;
                           else
                              Wr_PORTA       <= '0';
                           end if;
                           if chkf = "0000110" then
                              Wr_PORTB       <= testb;
                           else
                              Wr_PORTB       <= '0';
                           end if;
                           Wr_TRISA        <= '0';
                           Wr_TRISB        <= '0';
                        elsif BANK = "01" then
                           Wr_TMR0         <= '0';
                           if chkf = "0000001" then
                              Wr_OPTION      <= testb;
                           else
                              Wr_OPTION      <= '0';
                           end if;
                           Wr_PORTA        <= '0';
                           Wr_PORTB        <= '0';
                           if chkf = "0000101" then
                              Wr_TRISA       <= testb;
                           else
                              Wr_TRISA       <= '0';
                           end if;
                           if chkf = "0000110" then
                              Wr_TRISB       <= testb;
                           else
                              Wr_TRISB       <= '0';
                           end if;
                        else
                           Wr_W            <= '0';
                           Wr_STATUS       <= '0';
                           Wr_FSR          <= '0';
                           Wr_PC           <= '0';
                           Wr_PCLATCH      <= '0';
                           Wr_RF           <= '0';
                           Wr_TMR0         <= '0';
                           Wr_OPTION       <= '0';
                           Wr_INTCON       <= '0';
                           Wr_PORTA        <= '0';
                           Wr_PORTB        <= '0';
                           Wr_TRISA        <= '0';
                           Wr_TRISB        <= '0';
                        end if;
         else
                        Wr_STATUS       <= '0';
                        Wr_FSR          <= '0';
                        Wr_PC           <= '0';
                        Wr_PCLATCH      <= '0';
                        Wr_RF           <= '0';
                        Wr_TMR0         <= '0';
                        Wr_OPTION       <= '0';
                        Wr_INTCON       <= '0';
                        Wr_PORTA        <= '0';
                        Wr_PORTB        <= '0';
                        Wr_TRISA        <= '0';
                        Wr_TRISB        <= '0';
                        if    IR(13 downto 12) = "10" then
                                Wr_W    <= '0';
                        elsif IR(13 downto 12) = "11" then
                                Wr_W    <= '1';
                        elsif (IR(13 downto 12) = "00") and (IR(7) = '0') then
                                if IR(11 downto 8) = "0000" then
                                        Wr_W    <= '0';
                                else
                                        Wr_W    <= '1';
                                end if;
                        else
                                Wr_W    <= '0';
                        end if;
         end if;
       end process;
end rtl;
