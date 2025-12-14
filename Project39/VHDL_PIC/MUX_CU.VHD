library IEEE;
use IEEE.std_logic_1164.all;
library exemplar;
use exemplar.exemplar_1164.all;

entity MUX_CU is
        port (  Direct  : in  std_logic_vector(6 downto 0);
                Adr_RF  : in  std_logic;
                TMR0    : in  std_logic_vector(7 downto 0);
                OPTION  : in  std_logic_vector(7 downto 0);
                PCL     : in  std_logic_vector(7 downto 0);
                STATUS  : in  std_logic_vector(7 downto 0);
                FSR     : in  std_logic_vector(7 downto 0);
                PORTA   : in  std_logic_vector(7 downto 0);
                TRISA   : in  std_logic_vector(7 downto 0);
                PORTB   : in  std_logic_vector(7 downto 0);
                TRISB   : in  std_logic_vector(7 downto 0);
                PCLATH  : in  std_logic_vector(7 downto 0);
                INTCON  : in  std_logic_vector(7 downto 0);
                RF      : in  std_logic_vector(7 downto 0);
                Dout    : out std_logic_vector(7 downto 0);
                BANK    : out std_logic_vector(1 downto 0) );
end MUX_CU;

architecture rtl of MUX_CU is
        signal  REG_ADR   : std_logic_vector(6 downto 0);
        signal  SEL_BANK  : std_logic_vector(1 downto 0);


begin
        BANK <= SEL_BANK;

        ADR_MUX:
        process(Adr_RF,Direct,FSR)
        begin
                if Adr_RF = '1' then
                        REG_ADR <= FSR(6 downto 0);
                else
                        REG_ADR <= Direct;
                end if;
        end process;

        MUX_BANK:
        process(Adr_RF,STATUS(7 downto 5),FSR(7))
        begin
                if Adr_RF = '1' then
                        SEL_BANK <= STATUS(7) & FSR(7);
                else
                        SEL_BANK <= STATUS(6 downto 5);
                end if;
        end process;

        DATA_OUT:
        process(SEL_BANK,REG_ADR,TMR0,OPTION,PCL,STATUS,FSR,
                PORTA,PORTB,TRISA,TRISB,PCLATH,INTCON,RF)
        begin
                case SEL_BANK is
                        when "00" =>
                          if (REG_ADR >= "0001100") AND (REG_ADR <= "0101111") then
                                Dout <= RF;
                          else
                                case REG_ADR is
                                        when "0000001" => -- 01
                                                Dout <= TMR0;
                                        when "0000010" => -- 02
                                                Dout <= PCL;
                                        when "0000011" => -- 03
                                                Dout <= STATUS;
                                        when "0000100" => -- 04
                                                Dout <= FSR;
                                        when "0000101" => -- 05
                                                Dout <= PORTA;
                                        when "0000110" => -- 06
                                                Dout <= PORTB;
                                        when "0001010" => -- 0A
                                                Dout <= PCLATH;
                                        when "0001011" => -- 0B
                                                Dout <= INTCON;
                                        when others =>
                                                Dout <= "00000000";
                                end case;
                          end if;
                        when "01" =>
                          if (REG_ADR >= "0001100") AND (REG_ADR <= "0101111") then
                                Dout <= RF;
                          else
                                case REG_ADR is
                                        when "0000001" => -- 01
                                                Dout <= OPTION;
                                        when "0000010" => -- 02
                                                Dout <= PCL;
                                        when "0000011" => -- 03
                                                Dout <= STATUS;
                                        when "0000100" => -- 04
                                                Dout <= FSR;
                                        when "0000101" => -- 05
                                                Dout <= TRISA;
                                        when "0000110" => -- 06
                                                Dout <= TRISB;
                                        when "0001010" => -- 0A
                                                Dout <= PCLATH;
                                        when "0001011" => -- 0B
                                                Dout <= INTCON;
                                        when others =>
                                                Dout <= "00000000";
                                end case;
                          end if;

                        when others =>
                                Dout <= "00000000";
                end case;
        end process;

end rtl;
