-- ALU_UNIT is excluded for synthesis seperately.
library IEEE;
use IEEE.std_logic_1164.all;
entity ALU_UNIT is
    port (      Execute         : in  std_logic_vector(4 downto 0);
                Carry_in        : in  std_logic;
                S1_in           : in  std_logic_vector(7 downto 0);
                S2_in           : in  std_logic_vector(7 downto 0);
                F_out           : out std_logic_vector(7 downto 0);
                cf              : out std_logic;
                dcf             : out std_logic;
                zf              : out std_logic );
end ALU_UNIT;

architecture rtl of ALU_UNIT is
        signal  Xi,Yi,Fo,Ro,S2b_in : std_logic_vector(7 downto 0);
        signal  Ca              : std_logic;
        alias   e0 : std_logic is Execute(0);
        alias   e1 : std_logic is Execute(1);
        alias   e2 : std_logic is Execute(2);
        alias   e3 : std_logic is Execute(3);
        alias   e4 : std_logic is Execute(4);
begin
        S2b_in <= not S2_in;

        MODIFY_A:
        process(S1_in,S2_in,S2b_in,e3,e2,e1)
        variable e3e2be1b,e3e2e1b,e1b : std_logic;
        begin
                e1b := not e1;
                e3e2be1b := e3 and (not e2) and e1b;
                e3e2e1b  := e3 and e2  and e1b;
                for i in 0 to 7 loop
                        Xi(i)   <= S1_in(i) or (e3e2be1b and  S2_in(i)) or
                                               (e3e2e1b  and S2b_in(i));
                end loop;
        end process;

        MODIFY_B:
        process(S2_in,S2b_in,e2,e1)
        begin
                for i in 0 to 7 loop
                        Yi(i) <= (e1 and  S2_in(i)) or
                                 (e2 and S2b_in(i));
                end loop;
        end process;

        PARALLEL_ADDER:
        process(Xi,Yi,e3,e0)
        variable e3b : std_logic;
        variable Ci  : std_logic_vector(8 downto 0);
        begin
                Ci(0) := e0;
                e3b   := not e3;
                for i in 0 to 3 loop
                        Fo(i)  <=  Xi(i) xor Yi(i) xor (Ci(i) and e3b);
                       Ci(i+1) := (Xi(i) and Yi(i)) or 
                                 ((Xi(i) or  Yi(i)) and Ci(i));
                end loop;
        -----------------------------
        --      DC flag out        --
        -----------------------------
                dcf <= Ci(4);

                for i in 4 to 7 loop
                         Fo(i) <=  Xi(i) xor Yi(i) xor (Ci(i) and e3b);
                       Ci(i+1) := (Xi(i) and Yi(i)) or 
                                 ((Xi(i) or  Yi(i)) and Ci(i));
                end loop;
                Ca <= Ci(8) and e3b;
        end process;

        SHIFT:
        process(Fo,Carry_in,Ca,e4,e0)
        begin
                if e4 = '1' then
                        if e0 = '0' then
                                Ro <= Fo(6 downto 0) & Carry_in;
                                cf <= Fo(7);
                        else
                                Ro <= Carry_in & Fo(7 downto 1);
                                cf <= Fo(0);
                        end if;
                else
                        Ro <= Fo;
                        cf <= Ca;
                end if;
        end process;

        ZERO_FLAG:
        process(Ro)
        begin
                if Ro = "00000000" then
                        zf <= '1';
                else
                        zf <= '0';
                end if;
        end process;

        F_out <= Ro;

end rtl;
