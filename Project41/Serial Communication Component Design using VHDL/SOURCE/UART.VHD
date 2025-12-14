library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity ch_select is
	port(cs,rw,rs:in std_logic;
		ctr,treg,rreg:out std_logic);

end ;

architecture cselect of ch_select is

begin
	
    ctr <= '1' when cs = '1' and rs = '0' and rw = '0' else '0';
    treg <= '1' when cs = '1' and rs = '1' and rw = '0' else '0';
    rreg <= '1' when cs = '1' and rs = '1' and rw = '1' else '0';
end cselect;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity  ct_reg is
 	port(ctr,reset:in std_logic;
       	din:in std_logic_vector(7 downto 0);
		ctr1:out std_logic_vector(3 downto 0);
		ctr2:out std_logic_vector(1 downto 0);
		mreset:out std_logic);
end ;
 
architecture control of ct_reg is 
     signal	cont:std_logic_vector(7 downto 0);
begin
	cont <= (others =>'0') when reset = '0' else 
		    din when ctr = '1' else cont;
	ctr1 <=	(others =>'0') when reset = '0' else cont(3 downto 0);
    ctr2 <= (others =>'0') when reset = '0' else cont(7 downto 6);
	
	mreset <= '0' when cont( 1 downto 0) = "11" else '1';
end control;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity  st_reg is

	 port(tdre:in std_logic;
		  fe,pe,rdrf,ov:in std_logic;	  -- from control reg
		  ctr:in std_logic_vector(1 downto 0);--control bit 7,6
		  stout:out std_logic_vector(7 downto 0);
		  int:out std_logic);
end ;
	
architecture status of st_reg is

begin
 stout(0) <=rdrf;
 stout(1) <= tdre ; --tdre from tx data reg
 stout(2) <= '0' ; 
 stout(3) <= '0' ;
 stout(4) <= fe ; 
 stout(5) <= ov ; 
 stout(6) <= pe ; 
 stout(7)  <= tdre or rdrf ;
 int<=not (tdre or rdrf) when (ctr(1) or ctr(0)) ='1' else '1'; 

end status;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity tr_data is
	port(din:in std_logic_vector(7 downto 0);
		 dout:out std_logic_vector(7 downto 0);
		 tdrf,tdre:out std_logic;
		 clk,fin,treg,reset,mreset:in std_logic);
end ;
-- st1 to status reg  (tdre)
-- tdrf to tr_shift
--fin from tr_shift when tx finish
--treg : select this register	
architecture tdata of tr_data is 
   signal tout:	std_logic_vector(7 downto 0);
   
begin
	
	dout<= tout when fin = '1' else (others=>'0');

	process(clk,reset,mreset) 
		
	begin
		if reset = '0'  or mreset = '0' then
	   	tdre<='0';tdrf<='0';
		tout<=(others=>'0');
		
		elsif rising_edge(clk) then
			if treg = '1'  then
			tout<=din;
			tdre<= '0';
			tdrf<='1';
            elsif  fin = '1' then
				tdre <= '1';
				tdrf<='0';
		    end if;
                    	
		end if;
	end process;
end tdata;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity tr_shift is
	port(clk,reset,mreset,tdrf:in std_logic;
		 cin:in std_logic_vector(3 downto 0);
		 tin:in	std_logic_vector(7 downto 0);
		 tx,fin:out std_logic);

end;

architecture transmit of tr_shift is
-- declarations
begin
	process(clk,tdrf,tin,cin,reset,mreset) 
	variable n:integer;
	variable t_shift:std_logic_vector(7 downto 0);		
	variable t_flag:std_logic; 
	variable tcl:integer;
	variable tcount:integer;
	variable txpar:std_logic;
	
   begin	
		
if reset = '0' or mreset = '0' then	
	   	tx<='1';
		fin<='1';
		tcl:=0;
		tcount:=0;
		n:=	0;
		t_flag := '0';
		txpar := '0';
        t_shift:=(others =>'0');
			
elsif rising_edge(clk)	then
	 if tdrf = '1' and t_flag = '0' then
		if cin(1 downto	0) = "00" then n:=16; elsif
		   cin(1 downto	0) = "01" then n:=32; elsif
		   cin(1 downto	0) = "10" then n:=64; 
		end if;
		if cin(3 downto	2) = "10" then --even parity
	     txpar := '0';
	    elsif cin(3 downto	2) = "11" then --odd parity
	     txpar := '1';
	    end if;	
	       
		   tcl:=0;tcount:=0;
		   t_shift := tin;
		   fin<='0';  
		   t_flag:= '1';
		   
	 
     end if ; --tdrf   	
     
	 if t_flag =	'1'	then
		
			tcl	:= tcl + 1;
		if tcount	= 0	then
			tx <= '0'; 	
		end if;
		if tcl = n then
			tcount := tcount+1;
			tcl	:= 0;
						
			if tcount >= 1	and	 tcount	<= 8 then
			tx <= t_shift(0);
			txpar := txpar xor t_shift(0); -- parity
			
			for	i in 0 to 6	loop
			t_shift(i) :=	t_shift(i+1);
			end	loop;
			
			elsif tcount = 9 then
				case cin(3 downto	2) is
					when "00" =>		-- no parity ,2	stop bits
					tx <= '1';
					
					when "01" =>		-- no parity ,1	stop bit
					tx <= '1';
									
					
				    when "10" =>		-- even	parity ,1 stop bit
					tx <= txpar;
					
					when others =>		-- odd parity ,1 stop bit
					tx <= txpar;
				
				end	case;
			elsif tcount = 10 then
			  if cin(3 downto	2) = "01" then	 -- no parity ,1 stop bit
			  		t_flag:= '0';
			  		tcount:=0;
			  		fin<='1';
			  else tx <=	'1';		
			  end if;
			  
			  
			elsif tcount = 11 then
			  t_flag:= '0';
			  tcount:=0;
			  fin<='1'; 
    		  
    	   end if;	  
 
		  end if;  	--cl=n
    
     end if;	--check	t_flag
 end if; --clk	
end process;

end transmit;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity r_data	is
	port(clk,recf,rreg,reset,mreset:in std_logic;
		 din:in std_logic_vector(7 downto 0);
		 dout:out std_logic_vector(7 downto 0);
		 rdrf,ov:out std_logic);
end ;

architecture rdata of r_data is
	signal rout:std_logic_vector(7 downto 0);
   	signal rdre:std_logic;	
begin
	
	dout<= rout ;
	process(clk,rreg,reset,mreset)
	
	begin		
	if reset = '0' or mreset = '0' then
		rdrf<='0';ov<='0';rdre<='1';
		rout<= (others=>'0');
	
	elsif rising_edge(clk) then
	--receive data from shifter
	if 	recf ='1' then 
		if rdre /= '1' then ov <='1'; else ov<='0'; end if;
		rout<= din;rdre<='0';rdrf<='1';
	
	end if;
	--cpu read data
	if rreg ='1' then rdre <= '1';rdrf<='0';end if;

	end if;
end process;
end rdata;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity rc_shift	is
	port(reset,mreset,rx,clk:in std_logic;
		 cin:in std_logic_vector(3 downto 0);
		 rout:out std_logic_vector(7 downto 0);
		 fe,pe,recf:out std_logic);
end ;
--recf tell receive data register to get data
architecture receive of rc_shift is
begin

process(clk,reset,mreset,rx,cin)
 variable r_flag:std_logic;
 variable rcl:integer;	
 variable rxpar:std_logic;		
 variable rcount:integer;		
 variable r_shift:std_logic_vector(7 downto 0);				
 variable par:std_logic;					
 variable st:std_logic;	
 variable n :integer;
 variable hn:integer;	

begin		
 
 if reset = '0' or mreset = '0' then	
	   	rout<= (others=>'0');
 		recf<='0';
	   	fe<='0';
		pe<='0';
		rcl:=0;
		rcount:=0;
	   	n:=	0;hn:=0;
		r_flag := '0';
		par:='0';
		st:='0';
		rxpar := '0';
		r_shift:=(others =>'0');
		
elsif rising_edge(clk) then	
   if rx = '0' and r_flag	= '0' then
	    rcount:=0;fe<= '0';pe<='0';
	    if cin(1 downto	0) = "00" then n:=16;hn:=8; elsif
		   cin(1 downto	0) = "01" then n:=32;hn:=16; elsif
		   cin(1 downto	0) = "10" then n:=64;hn:=32; 
		end if;
	    
	    if cin(3 downto	2) = "10" then rxpar := '0';--even parity
	    elsif cin(3 downto	2) = "11" then rxpar := '1';--odd parity
	    end if;	
	    
		  -- detect	start bit
	      rcl := rcl +	1;
	      if rcl =	hn  then rcl := 0;r_flag := '1';end if;
   elsif r_flag	= '1' then rcl:= rcl + 1;
	 if rcl = n then rcl := 0; rcount :=rcount +1;
        if rcount = 1 then r_shift(0) :=rx; rxpar:=rxpar xor rx;
	    elsif rcount = 2 then r_shift(1) :=	rx;rxpar:=rxpar xor rx;
        elsif rcount = 3 then r_shift(2) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 4 then r_shift(3) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 5 then r_shift(4) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 6 then r_shift(5) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 7 then r_shift(6) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 8 then r_shift(7) :=	rx;rxpar:=rxpar xor rx;
	    elsif rcount = 9 then par := rx;--parity	or stop	bit
				case cin(3 downto	2) is				-- PE
	  				when "00" =>		-- no parity ,2	stop bits
					if par = '1' then fe<= '0'; else fe <= '1';
	  				end	if;	 --	FE
	  									
					when "01" =>		-- no parity ,1	stop bit
					if par = '1' then fe<= '0';	else fe <= '1';
	  				end	if;	 --	FE
					recf<='1';	   --signal data register to receive data
		 		    rout<=r_shift;
	 			    rcount := 0;r_flag:= '0';
	  												   
					when "10" =>		-- even	parity ,1 stop bit
					if par = rxpar then pe<= '0'; else pe<=	'1';	
					end	if;
					
					when others =>		-- odd parity ,1 stop bit
					if par = rxpar then pe<= '0'; else pe<= '1';	
					end	if;
			   	  end	case;
	    elsif rcount = 10 then      --stop bit
		 		st	:= rx;
	  	 		recf<='1';	   --signal data register to receive data
		 		rout<=r_shift;
	 			rcount := 0;r_flag:= '0';
	  	   if st /='1'	then fe<= '1'; end if;	 --	FE

	     end if; --rcount
	  end if;--rcl
	else recf<='0';
	end if;--r_flag
 end if;--clk

end process;
end receive;

library	IEEE;
Use	IEEE.STD_Logic_1164.all;
Entity uart is
  port(rx,reset,cs,rs,clk,rw:in std_logic;
		 dat:inout std_logic_vector(7 downto 0);
		 tx,int:out	std_logic);
end ;

architecture rtl of uart is
-- declarations
	component ch_select 
		port(cs,rw,rs:in std_logic;
			ctr,treg,rreg:out std_logic);

    end	 component;

	component  ct_reg
		port(ctr,reset:in std_logic;
        din:in std_logic_vector(7 downto 0);
		ctr1:out std_logic_vector(3 downto 0);
		ctr2:out std_logic_vector(1 downto 0);
		mreset:out std_logic);

	end component;
	
	component st_reg
		  port(tdre:in std_logic;
		  fe,pe,rdrf,ov:in std_logic;	  
		  ctr:in std_logic_vector(1 downto 0);
		  stout:out std_logic_vector(7 downto 0);
		  int:out std_logic);
   end component;

	component tr_data 
		 port(din:in std_logic_vector(7 downto 0);
		 dout:out std_logic_vector(7 downto 0);
		 tdre,tdrf:out std_logic;
		 clk,fin,treg,reset,mreset:in std_logic);
					  
	end component;
	
	component tr_shift 
		port(clk,reset,mreset,tdrf:in std_logic;
		 cin:in std_logic_vector(3 downto 0);
		 tin:in	std_logic_vector(7 downto 0);
		 tx,fin:out std_logic);

	end component;	
	
    
    component r_data  
	     port(clk,recf,rreg,reset,mreset:in std_logic;
		 din:in std_logic_vector(7 downto 0);
		 dout:out std_logic_vector(7 downto 0);
		 rdrf,ov:out std_logic);
    end component;
    	
    component rc_shift 
	   port(reset,mreset,rx,clk:in std_logic;
		 cin:in std_logic_vector(3 downto 0);
		 rout:out std_logic_vector(7 downto 0);
		 fe,pe,recf:out std_logic);
    end component;
    
        
    signal dat1:std_logic_vector(7 downto 0);--from status register
	signal dat2:std_logic_vector(7 downto 0);--from receive data register
	signal ctr :std_logic;
	signal treg :std_logic;
	signal rreg :std_logic;	
	signal mreset :std_logic;	
	signal tdre :std_logic;	
	signal ctr1:std_logic_vector(3 downto 0);
	signal ctr2:std_logic_vector(1 downto 0);	
	signal tout:std_logic_vector(7 downto 0);
	signal rout:std_logic_vector(7 downto 0);	
	signal fin :std_logic;
	signal tdrf :std_logic;
	signal rdrf :std_logic;
	signal ov :std_logic;	
	signal recf:std_logic;	
	signal fe:std_logic;
	signal pe:std_logic;	

begin
	u1:ch_select port map (cs=>cs,rw=>rw,rs=>rs,--clk=>clk,reset=>reset,
						   ctr=>ctr,treg=>treg,rreg=>rreg);
	u2:ct_reg port map (reset=>reset,ctr=>ctr,din=>dat,--clk=>clk,
						mreset=>mreset,ctr1=>ctr1,ctr2=>ctr2);
	u3:st_reg port map (tdre=>tdre,ctr=>ctr2,
		  				stout=>dat1,int=>int,
		  				fe=>fe,pe=>pe,rdrf=>rdrf,ov=>ov);
	
	u4:tr_data port map(din=>dat,dout=>tout,tdre=>tdre,tdrf=>tdrf,
						clk=>clk,fin=>fin,treg=>treg,reset=>reset,
						mreset=>mreset);
	u5:tr_shift port map(clk=>clk,reset=>reset,mreset=>mreset,
						 tdrf=>tdrf,cin=>ctr1,tin=>tout,tx=>tx,fin=>fin);
	u6:r_data port map(dout=>dat2,din=>rout,recf=>recf,rreg=>rreg,reset=>reset,
						mreset=>mreset,clk=>clk,rdrf=>rdrf,ov=>ov);	
	u7:rc_shift port map(reset=>reset,mreset=>mreset,rx=>rx,clk=>clk,
		 				cin=>ctr1,rout=>rout,fe=>fe,pe=>pe,recf=>recf);

-- concurrent statements
		dat<= dat1 when rs = '0' and rw = '1' and cs = '1' else (others=>'Z');
		dat<= dat2 when rs = '1' and rw = '1' and cs = '1' else (others=>'Z');

end rtl;

