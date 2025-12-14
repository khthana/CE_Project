library IEEE;
use IEEE.std_logic_1164.all;
package PIC16CXX is
        ------------------------------------------------------------
        ------                  ALU Execute Code              ------
        ------------------------------------------------------------
        constant ALU_ADD  : std_logic_vector(4 downto 0) := "00010";
        constant ALU_SUB  : std_logic_vector(4 downto 0) := "00101";
        constant ALU_INC  : std_logic_vector(4 downto 0) := "00001";
        constant ALU_DEC  : std_logic_vector(4 downto 0) := "00110";
        constant ALU_AND  : std_logic_vector(4 downto 0) := "01100";--0110-
        constant ALU_IOR  : std_logic_vector(4 downto 0) := "01000";--0100-
        constant ALU_XOR  : std_logic_vector(4 downto 0) := "01010";--0101-
        constant ALU_CPL  : std_logic_vector(4 downto 0) := "01110";--0111-
        constant ALU_TRA  : std_logic_vector(4 downto 0) := "00000";
        constant ALU_SHL  : std_logic_vector(4 downto 0) := "10000";
        constant ALU_SHR  : std_logic_vector(4 downto 0) := "10111";
        constant ALU_XXX  : std_logic_vector(4 downto 0) := "-----";
        ------------------------------------------------------------
        ------                  Affect Flag Code              ------
        ------------------------------------------------------------
        constant ZERO_FG  : std_logic_vector(2 downto 0) := "100";
        constant CARRY_FG : std_logic_vector(2 downto 0) := "001";
        constant ALL_FG   : std_logic_vector(2 downto 0) := "111";
        constant NONE_FG  : std_logic_vector(2 downto 0) := "000";
        ------------------------------------------------------------
        ------                 Alu first opernad              ------
        ------------------------------------------------------------
        constant fDin     : std_logic_vector(1 downto 0) := "00";
        constant fIRin    : std_logic_vector(1 downto 0) := "01";
        constant fZero    : std_logic_vector(1 downto 0) := "11";
        constant fX       : std_logic_vector(1 downto 0) := "--";
        ------------------------------------------------------------
        ------                 Alu second opernad             ------
        ------------------------------------------------------------
        constant sSwapDin : std_logic_vector(1 downto 0) := "00";
        constant sIrbBAR  : std_logic_vector(1 downto 0) := "01";
        constant sIrb     : std_logic_vector(1 downto 0) := "10";
        constant sW       : std_logic_vector(1 downto 0) := "11";
        constant sX       : std_logic_vector(1 downto 0) := "--";
        ------------------------------------------------------------
        ------             Part of Program count (PC)         ------
        ------------------------------------------------------------
        constant pcDin    : std_logic_vector(1 downto 0) := "00";
        constant pcTOS    : std_logic_vector(1 downto 0) := "01";
        constant pcIR     : std_logic_vector(1 downto 0) := "11";
        constant pcX      : std_logic_vector(1 downto 0) := "--";
        ------------------------------------------------------------
        ------             Update Stack pointer (SP)          ------
        ------------------------------------------------------------
        constant spHOLD : std_logic_vector(1 downto 0) := "00";
        constant spINC  : std_logic_vector(1 downto 0) := "01";
        constant spDEC  : std_logic_vector(1 downto 0) := "11";
        ------------------------------------------------------------
        ------                   RAM Delay Time               ------
        ------------------------------------------------------------
        constant tpd_address_change     : time := 10 ns;
        constant tpd_write_value        : time := 5  ns;

end PIC16CXX;
