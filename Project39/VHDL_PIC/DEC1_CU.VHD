library IEEE,work;
use IEEE.std_logic_1164.all;
use WORK.pic16cxx.all;
entity DEC1_CU is
        port (  IR              : in  std_logic_vector(13 downto 0);
                Sel_first_op    : out std_logic_vector( 1 downto 0);
                Sel_second_op   : out std_logic_vector( 1 downto 0);
                Execute         : out std_logic_vector( 4 downto 0);
                Chk_status      : out std_logic_vector( 2 downto 0);
                Sel_SADR        : out std_logic;
                Update_SP       : out std_logic_vector( 1 downto 0);
                Wr_STACK        : out std_logic;
                Sel_part_PC     : out std_logic_vector( 1 downto 0);
                Wr_PC           : out std_logic;
                Set_GIE         : out std_logic;
                Skip_if_clr     : out std_logic;
                Skip_if_set     : out std_logic );
end;

architecture rtl of DEC1_CU is

begin

        DECODER1_UNIT:
        process(IR)
	begin
         if    IR(13 downto 12) = "11" then
                -- Literal
                case IR(11 downto 8) is
                    when "1110" =>      -- ADDLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_ADD;  Wr_PC           <= '0';
                       Chk_status      <= ALL_FG;   
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "1100" =>      -- SUBLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_SUB;  Wr_PC           <= '0';
                       Chk_status      <= ALL_FG;   
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "1001" =>      -- ANDLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_AND;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "1000" =>      -- IORLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_IOR;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "1010" =>      -- XORLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XOR;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "0000" =>      -- MOVLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_TRA;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                    when "0100" =>      -- RETLW
                       Sel_first_op    <= fIRin;    Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcTOS;
                       Execute         <= ALU_TRA;  Wr_PC           <= '1';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '0';      Skip_if_clr     <= '0';
                       Update_SP       <= spDEC;    Skip_if_set     <= '0';

                    when others =>      -- NULL
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XXX;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                end case;
         elsif IR(13 downto 12) = "01" then
                case IR(11 downto 10) is
                     when "00" =>       -- BCF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sIrbBAR;  Sel_part_PC     <= pcDin;
                       Execute         <= ALU_AND;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "01" =>       -- BSF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sIrb;     Sel_part_PC     <= pcDin;
                       Execute         <= ALU_IOR;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "10" =>       -- BTFSC
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sIrb;     Sel_part_PC     <= pcDin;
                       Execute         <= ALU_AND;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '1';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "11" =>       -- BTFSS
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sIrb;     Sel_part_PC     <= pcDin;
                       Execute         <= ALU_AND;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '1';

                     when others =>     -- NULL
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XXX;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                end case;
         elsif IR(13 downto 12) = "10" then
                case IR(11) is
                     when '0' =>        -- CALL
                       Sel_first_op    <= fX;       Wr_STACK        <= '1';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcIR;
                       Execute         <= ALU_XXX;  Wr_PC           <= '1';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '1';      Skip_if_clr     <= '0';
                       Update_SP       <= spINC;    Skip_if_set     <= '0';

                     when '1' =>        -- GOTO
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcIR;
                       Execute         <= ALU_XXX;  Wr_PC           <= '1';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                     when others =>     -- NULL;
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XXX;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                end case;
         elsif IR(13 downto 12) = "00" then
                case IR(11 downto 8) is
                     when "0000" =>
                      if    IR(7) = '1' then
                                        -- MOVWF
                       Sel_first_op    <= fZERO;    Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_IOR;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                      elsif IR(3) = '1' then
                        case IR(0) is
                         when '0' =>    -- RETURN
                          Sel_first_op    <= fX;      Wr_STACK        <= '0';
                          Sel_second_op   <= sX;      Sel_part_PC     <= pcTOS;
                          Execute         <= ALU_XXX; Wr_PC           <= '1';
                          Chk_status      <= NONE_FG; 
                          Set_GIE         <= '0';
                          Sel_SADR        <= '0';     Skip_if_clr     <= '0';
                          Update_SP       <= spDEC;   Skip_if_set     <= '0';

                         when '1' =>    -- RETFIE
                          Sel_first_op    <= fX;      Wr_STACK        <= '0';
                          Sel_second_op   <= sX;      Sel_part_PC     <= pcTOS;
                          Execute         <= ALU_XXX; Wr_PC           <= '1';
                          Chk_status      <= NONE_FG; 
                          Set_GIE         <= '1';
                          Sel_SADR        <= '0';     Skip_if_clr     <= '0';
                          Update_SP       <= spDEC;   Skip_if_set     <= '0';

                         when others =>  -- NULL;
                         Sel_first_op    <= fX;       Wr_STACK        <= '0';
                         Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                         Execute         <= ALU_XXX;  Wr_PC           <= '0';
                         Chk_status      <= NONE_FG;  
                         Set_GIE         <= '0';
                         Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                         Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                        end case;
                      else
                                         -- NOP, SLEEP, CLRWDT
                        Sel_first_op    <= fX;       Wr_STACK        <= '0';
                        Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                        Execute         <= ALU_XXX;  Wr_PC           <= '0';
                        Chk_status      <= NONE_FG;  
                        Set_GIE         <= '0';
                        Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                        Update_SP       <= spHOLD;   Skip_if_set     <= '0';
                      end if;

                     when "0111" =>     -- ADDWF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_ADD;  Wr_PC           <= '0';
                       Chk_status      <= ALL_FG;   
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1010" =>     -- INCF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_INC;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1111" =>     -- INCFSZ
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_INC;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '1';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "0010" =>     -- SUBWF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_SUB;  Wr_PC           <= '0';
                       Chk_status      <= ALL_FG;   
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "0011" =>     -- DECF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_DEC;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1011" =>     -- DECFSZ
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_DEC;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '1';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "0001" =>     -- CLRW
                       Sel_first_op    <= fZERO;    Wr_STACK        <= '0';
                       Sel_second_op   <= sX;
                       Execute         <= ALU_TRA;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                                if IR(7) = '1' then
                                        -- CLRF
                                                    Sel_part_PC     <= pcDin;
                                else
                                                    Sel_part_PC     <= pcX;
                                end if;

                     when "0101" =>     -- ANDWF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_AND;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "0100" =>     -- IORWF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_IOR;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "0110" =>     -- XORWF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sW;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_XOR;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1110" =>     -- SWAPF
                       Sel_first_op    <= fZERO;    Wr_STACK        <= '0';
                       Sel_second_op   <= sSwapDin; Sel_part_PC     <= pcDin;
                       Execute         <= ALU_IOR;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1000" =>     -- MOVF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_TRA;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1001" =>     -- COMF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_CPL;  Wr_PC           <= '0';
                       Chk_status      <= ZERO_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1101" =>     -- RLF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_SHL;  Wr_PC           <= '0';
                       Chk_status      <= CARRY_FG; 
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when "1100" =>     -- RRF
                       Sel_first_op    <= fDin;     Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcDin;
                       Execute         <= ALU_SHR;  Wr_PC           <= '0';
                       Chk_status      <= CARRY_FG; 
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                     when others =>     -- NULL;
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XXX;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';

                end case;
         else
                       Sel_first_op    <= fX;       Wr_STACK        <= '0';
                       Sel_second_op   <= sX;       Sel_part_PC     <= pcX;
                       Execute         <= ALU_XXX;  Wr_PC           <= '0';
                       Chk_status      <= NONE_FG;  
                       Set_GIE         <= '0';
                       Sel_SADR        <= '-';      Skip_if_clr     <= '0';
                       Update_SP       <= spHOLD;   Skip_if_set     <= '0';
         end if;
        end process;
end rtl;
