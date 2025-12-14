user_dialog :- 
   logo,	
   init_getmouse,  
   _S1 = [dlg_ownedbyprolog,ws_sysmenu,ws_caption],
   _S2 = [ws_child,ws_visible,ws_border],
   _S3 = [ws_child,ws_visible,ws_tabstop,bs_pushbutton],
   _S4 = [ws_child,ws_border,ws_visible],
   _S5 = [ws_child,ws_visible,ws_border,ss_center],
   wdcreate(  user_dialog,        `เขียนลายมือไทย เวอร์ชัน 1.0`,            157,  53, 542, 271, _S1 ),
   wccreate( (user_dialog,9000),  grafix, `Grafix1`,                         20,  30, 190, 200, _S2 ),
   wccreate( (user_dialog,1000),  button, `เขียนไหม่`,                      230,  70,  80,  30, _S3 ),
   wccreate( (user_dialog,1001),  button, `ออกโปรแกรม`,                     230, 190,  80,  30, _S3 ),
   wccreate( (user_dialog,1002),  button, `ทำการรู้จำ`,                     230,  30,  80,  30, _S3 ),
   wccreate( (user_dialog,1004),  button, `ช่วยเหลือ`,                      230, 110,  80,  30, _S3 ),
   wccreate( (user_dialog,9001),  grafix, `Grafix2`,                        330,  30, 190, 200, _S4 ),
   wccreate( (user_dialog,10001), static, `รับลายมือเขียน`,                  20,  10, 190,  20, _S5 ),
   wccreate( (user_dialog,10003), static, `แสดงผลตัวอักษรที่ทำการรู้จำได้`, 330,  10, 190,  20, _S5 ),
   window_handler( user_dialog, getmouse_handler ),   
   call_dialog( user_dialog, _ ).    

%user interface
logo :- 
   _S1 = [dlg_ownedbyprolog,ws_sysmenu,ws_caption],
   _S2 = [ws_child,ws_visible,ws_tabstop,bs_pushbutton],
   wdcreate(  'ThaiFreeHand',       `THAI FREE HAND v.1.0`,                215, 144, 352, 241, _S1 ),
   wccreate( ('ThaiFreeHand',1000), button, `เขียนลายมือไทย เวอร์ชัน 1.0`,   0,   0, 350, 220, _S2 ),
   call_dialog('ThaiFreeHand',_).

% initialise dynamic data and graphics objects
init_getmouse :-
   retractall( be_X_Y(_) ),
   assert( be_X_Y([]) ),
   retractall( use(_) ),
   assert( use([]) ),
 retractall( pri_long(_) ),
   assert( pri_long([]) ), 
 retractall( sec_long(_) ),
   assert( sec_long([]) ), 
 retractall( use_mm(_) ),
   assert( use_mm([]) ),
 retractall( start(_) ),
   assert( start([]) ),
 retractall( idea(_) ),
   assert( idea([]) ),
 retractall( cou_nt(_) ),
   assert( cou_nt([0]) ),
 retractall( t_line(_) ),
 assert( t_line([]) ),
 retractall( f_line(_) ),
   assert( f_line([]) ),  
 retractall( yag(_) ),
   assert( yag([]) ),  
 retractall( mouse_up(_) ),
   assert( mouse_up([]) ),  
 abolish( temp_mouse/4 ),
   dynamic( temp_mouse/4 ),
   gfx_pen_create(black_thick,0,0,2,2),
   !.

% handle a left up message in the grafix window
getmouse_handler( (user_dialog,9000), msg_leftup, (X,Y), _ ) :- 

   (  retract( temp_mouse(X0,Y0,X1,Y1) )    
   -> gfx_begin( (user_dialog,9000) ),
	 mouse_up(List),
	 retractall(mouse_up(_)),assert(mouse_up([-10|List])),
	 gfx_end( (user_dialog,9000) )   
   ),    !.

% handle a left down message in the grafix window
getmouse_handler( (user_dialog,9000), msg_leftdown, (X,Y), _ ) :-
   dynamic( temp_mouse/1 ),
   gfx_begin( (user_dialog,9000) ),
   gfx_transform( X0, Y0, X, Y ),
   gfx_end( (user_dialog,9000) ),
   assert( temp_mouse(X0,Y0,X0,Y0) ),
   !.

getmouse_handler( (user_dialog,9000), msg_mousemove, (X,Y), _ ) :-
   (  retract( temp_mouse(X0,Y0,X1,Y1) )
   -> gfx_begin( (user_dialog,9000) ),
      gfx_transform( X2, Y2, X, Y ),
      gfx( (  pen = black_thick
           -> polyline(X1,Y1,X2,Y2) ) ),%write(temp_mouse(X2,Y2) ),nl,
	use(Lines_list),
	 len(Lines_list,D),	

	 
	( mouse_up([Hed|T]) -> retract(mouse_up(_)),assert(mouse_up([-10,Y2,X2|T]))
				  
	       ;( 
		D >= 2 -> 	
			use([A0,B0|_]) ,re_fill(A0,B0,Y2,X2),
			use(Lines),
			retract(use(_) ),
			assert( use([Y2,X2|Lines]) ) 
			;
			retract(use(_) ),
			assert( use([Y2,X2|Lines_list]) ) 
		)
		
	) , 	  
	gfx_end( (user_dialog,9000) ),
      assert( temp_mouse(X0,Y0,X2,Y2) )
   ),
   !.
 
%MENU

% IGNORE manual attempts to EXIT this window
getmouse_handler( user_dialog, msg_close, _, done ) :-  
        !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%THIS IS A CALCULUS PHASE %%%%%%%%%%%%%
 re_fill(C0,D0,A,B) :- A0 is C0,B0 is D0,
		(Del_Y is (A - A0)),(Del_X is (B - B0)),
	(
		 Del_X =:= 0 ,Del_Y > 0  ->  N is Del_Y-1 ,
				( N > 1  ->make_line_0(N,0,A0,B0);L is 1)		
					,!; 
		 Del_X =:= 0 , Del_Y < 0 ->  N is abs(Del_Y) - 1 ,
				( N > 1 ->make_line_0(N,1,A0,B0);L is 1)					
				,!; 
		 Del_Y =:= 0 ,Del_X > 0  ->  N is (abs(Del_X)-1) ,
				( N > 1 ->make_line_0(N,2,A0,B0);L is 1)					
							,!; 
		 Del_Y =:= 0 , Del_X < 0 ->  N is (abs(Del_X)-1) ,
				( N > 1 ->make_line_0(N,3,A0,B0);L is 1)					
							,!; 
		point_t(Del_X,Del_Y,A0,B0)
		),!.
point_t(Del_X,Del_Y,A0,B0) :-(	 Del_X > 0   , Del_Y > 0  -> MM is abs(Del_Y/Del_X) ,
						( MM  >= 1 -> N is abs(Del_Y) ,Nn is N-1,
						    ( N > 1 -> make_line_1(Nn,0,A0,B0,MM)  ;K is 5);			
						MM  < 1 -> N is abs(Del_X) ,Nn is N-1,
							( N > 1 ->make_line_2(Nn,0,A0,B0,MM) ;K is 5)
			         		)
					; 
		 Del_X > 0   , Del_Y < 0  -> MM is abs(Del_Y/Del_X) ,
						( MM  >= 1 -> N is abs(Del_Y) ,Nn is N-1,
							(N > 1 ->make_line_1(Nn,1,A0,B0,MM) ;K is 5);		
						MM  < 1 -> N is abs(Del_X) ,Nn is N-1,
							(N > 1 ->make_line_2(Nn,1,A0,B0,MM) ;K is 5)
			         		) 			
				; 
		 Del_X < 0   , Del_Y > 0  -> MM is abs(Del_Y/Del_X) ,
						 ( MM  >= 1 -> N is abs(Del_Y) ,Nn is N-1,
							(N > 1 ->make_line_1(Nn,2,A0,B0,MM) ;K is 5);			
						MM  < 1 -> N is abs(Del_X) ,Nn is N-1,
							(N > 1 ->make_line_2(Nn,2,A0,B0,MM) ;K is 5)
			         		)			
				; 

		 Del_X < 0   , Del_Y < 0  -> MM is abs(Del_Y/Del_X) ,
						( MM  >= 1 -> N is abs(Del_Y) ,Nn is N-1,
							(N > 1 ->make_line_1(Nn,3,A0,B0,MM) ;K is 5);			
						MM  < 1 -> N is abs(Del_X) ,Nn is N-1,
							(N > 1 ->make_line_2(Nn,3,A0,B0,MM) ;K is 5)
			         		) 			
				;L is 6 
		),!.
make_line_0(0,T,A,B).
make_line_0(N,T,Y,X) :- NN is N - 1,
			NN >= 0,
			use(L), %M is Y-1 ,
			(  T =:= 0 -> H is X,M is Y+1 ;
			   T =:= 1 -> H is X,M is Y-1 ;
			   T =:= 2 -> H is X+1,M is Y ;
			   T =:= 3 -> H is X-1,M is Y 
			),		
			retractall(use(_)),assert(use([M,H|L])),
			make_line_0(NN,T,M,H),!.
make_line_1(0,T,A,B,MM).
make_line_1(N,T,Y,X,MM) :- NN is N - 1,
			NN >= 0,
			use(L), %M is Y-1 ,
			
			(  T =:= 0 -> H is X+(1/MM),M is Y+1 ;
			   T =:= 1 -> H is X+(1/MM),M is Y-1 ;
			   T =:= 2 -> H is X-(1/MM),M is Y+1 ;
			   T =:= 3 -> H is X-(1/MM),M is Y-1 
			),		
			retractall(use(_)),assert(use([M,H|L])),
			make_line_1(NN,T,M,H,MM).
make_line_2(0,T,A,B,MM).
make_line_2(N,T,Y,X,MM) :- NN is N - 1,
			NN >= 0,
			use(L), %M is Y-1 ,
			
			(  T =:= 0 -> H is X+1,M is Y+MM ;
			   T =:= 1 -> H is X+1,M is Y-MM ;
			   T =:= 2 -> H is X-1,M is Y+MM ;
			   T =:= 3 -> H is X-1,M is Y-MM
			),		
			retractall(use(_)),assert(use([M,H|L])),
			
			make_line_2(NN,T,M,H,MM).
%%%%%%%%%%%%%%%%%%% ADD PHASE %%%%%%%%%%%%%%%%%
for_line1 :- t_line([T,U|_]),t_line([_,_|Y]),re_degree(T,U),
	retract(t_line(_)),assert(t_line(Y)),
	!.
fill_l(A,U) :- f_line(F),
		retract(f_line(_)),assert(f_line([A|F])),
		pri_long([H_long|T_long]),
		retract(pri_long(_)),assert(pri_long(T_long)),
		sec_long(Sec_long),
		retract(sec_long(_)),assert(sec_long([H_long|Sec_long])),
		!.

fill_f(D,U) :- ( 
			( D >  159  ,D  < 203 ) -> A is 4,fill_l(A,U) ,!;
			( D >= 203  ,D =< 249 ) -> A is 5,fill_l(A,U)  ,!;
			( D >  249  ,D  < 293 ) -> A is 6,fill_l(A,U) ,!;
			( D >= 293  ,D =< 339 ) -> A is 7,fill_l(A,U)
	  ),!.
re_degree(D,U) :-   
 (
			( D >  339 ; D  < 23  ) -> A is 0,fill_l(A,U)  ,!;
			( D >= 23  ,D =< 69  ) -> A is 1,fill_l(A,U) ,!;
			( D >  69  ,D  < 113 ) -> A is 2,fill_l(A,U) ,!;
			( D >= 113 ,D =< 159 ) -> A is 3,fill_l(A,U ) ,!;
			fill_f(D,U)
		),!	.		

%%%%%%%%%%%%%%%%%%%%%%%%
for_line :- t_line(T),len(T,A),final_line(A). 
final_line(0).
final_line( N) :-
		NN is N -2,
		NN >= 0,
		t_line([T,U|_]),
		re_degree1(T,U),
		t_line([_,_|Y]),
		retract(t_line(_)),
		assert(t_line(Y)),
		final_line(NN),!.

fill_l1(A,U) :- f_line(F),f_line([X|_]),
		pri_long([H_long|T_long]),
		
		(  	A =:= X ->f_line([_|B]),%Test for the same line,
				retract(f_line(_)),assert(f_line([X|B]))  ,
				add_long	,!;  
			retract(f_line(_)),assert(f_line([A|F])) ,
			retract(pri_long(_)),assert(pri_long(T_long)),
			sec_long(Sec_long),retract(sec_long(_)),assert(sec_long([H_long|Sec_long]))  
		 ),
		!.
add_long :- pri_long(T),len(T,N),
			(N > 1 -> pri_long([P1,P2|P3]),P4 is (P1+P2) ,
			retract(pri_long(_)),assert(pri_long([P4|P3])),!;

						pri_long([P4|P3]),retract(pri_long(_)),
						assert(pri_long(P3))
			)		
			,!.
fill_f1(D,U) :- ( 
			( D >  159  ,D  < 203 ) -> A is 4,fill_l1(A,U) ,!;
			( D >= 203  ,D =< 249 ) -> A is 5,fill_l1(A,U)  ,!;
			( D >  249  ,D  < 293 ) -> A is 6,fill_l1(A,U) ,!;
			( D >= 293  ,D =< 339 ) -> A is 7,fill_l1(A,U)
	  ),!.
re_degree1(D,U) :-   
 (
			( D >  339 ; D  < 23  ) -> A is 0,fill_l1(A,U)  ,!;
			( D >= 23  ,D =< 69  ) -> A is 1,fill_l1(A,U) ,!;
			( D >  69  ,D  < 113 ) -> A is 2,fill_l1(A,U) ,!;
			( D >= 113 ,D =< 159 ) -> A is 3,fill_l1(A,U ) ,!;
			fill_f1(D,U)
		),!	.		
%>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<
fill(D) :- use_mm(D_gree),retractall(use_mm(_)),
	   assert(use_mm([D|D_gree])),!.
%========================================
fill_c :-	cou_nt([Nt|_]),retract(cou_nt(_)),
		Nn is (Nt+1),assert(cou_nt([Nn|Nt])),!.
%=============
find_line(K1,K2) :-    cou_nt([A|_]),t_line(T),retract(cou_nt(_)),
		assert(cou_nt([0])),idea([_,D|_]),
		(
			A > 0 ->
			retract(t_line(_)),
			assert(t_line([D,A|T])),
			pri_long(Pri),
			retractall(pri_long(_)),
			assert(pri_long([A|Pri]))
			;
			G is 6
		),!.
%==============================
find_last :-    cou_nt([A|_]),t_line(T),retract(cou_nt(_)),
		assert(cou_nt([0])),idea([D|_]),use([H1,H2|_]),
		(
			A > 0 ->
			pri_long(Pri),retract(pri_long(_)),
			assert(pri_long([A|Pri])),
			retract(t_line(_)),
			assert(t_line([D,A|T])) ,!
			;
			G  is 5
		),!.
%========================================                                
find_Degree(A,B) :- 	(
			 ( A > 0 ,B > 0)  -> 
			M_M is (B/A),  MM is ( 360 - (atan(M_M)//1) )  ,
			fill(MM) ,!	
				;
			  ( A < 0 ,B > 0) -> 
			M_M is (B/A),  MM is ( 180 - (atan(M_M)//1) )  ,
			fill(MM) 	
			,!	;
			  ( A < 0 ,B < 0 ) -> 
			M_M is (B/A),  MM is ( 180 - (atan(M_M)//1) )  ,
			fill(MM) 	
	,!			;
			  ( A > 0 ,B < 0  ) -> 
			M_M is (B/A),  MM is (   0 - (atan(M_M)//1) )  ,
			fill(MM) 	
			),!.
%=====================================
find_start(A1,A2) :- use_mm(Use),use_mm([B1|_]),
			start(Drt),use([K1,K2|_]),
			idea(Idea),idea([H1|_]),		     
			C is ( abs(B1 - H1)),						
			(  
			   (  C < 6 ; C > 354 )  ->  retract(start(_)),
			     assert(start([A1,A2])),fill_c 
,!			     ;
			retractall(start(_)),
			assert(start([K1,K2])),
			retractall(idea(_)),assert(idea([B1|Idea])),
			find_line(K1,K2)				
		        ),
!.
%============     INITIAL LOOP	  ====================
ini_loop(Con1,Con2) :-		
	use(New_),
	use([_,_|H]),
	retractall(use(_)),                  
	assert(use(H)),
	use([H1,H2|_]),
	Del_X is (H1 - Con1),
	Del_Y is (H2 - Con2),fi_case(Del_X,Del_Y),	
	use_mm(Start),
	use_mm([AA|_]),	
	start(New_start),
	retract(start(_)),
	assert(start([Con1,Con2|New_start])),
	idea(Idea),
	retract(idea(_)),
	assert(idea([AA|Idea]))
,!.
%====================  INI END LOOP  ==============
fi_case(Del_X,Del_Y) :-
                (  
	( Del_X =:= 0 ,Del_Y > 0 ) -> 
	 D_gree is 270 ,fill(D_gree)	
,!	;
	( Del_X =:= 0 ,Del_Y < 0 ) -> 
	D_gree is 90   , fill(D_gree)
,!	;
	( Del_X < 0 ,Del_Y =:= 0 ) -> 
	D_gree is 180 , fill(D_gree)
,!	;
	( Del_X > 0 ,Del_Y =:= 0 ) ->
	D_gree is 0  , fill(D_gree)
,!	;
	find_Degree(Del_X,Del_Y)
	),!.
%============     LOOP	  ====================
sun_loop(0,K1,K2).
sun_loop(N,Con1,Con2) :-		
NN is N - 1 ,
NN >= 0,	
	use(New_list),
	use([_,_|H]),
	retractall(use(_)),                  
	assert(use(H)),
	use([H1,H2|_]),
	start(Hey),
	start([S1,S2|_]),  
Del_X is (H1 - S1),
Del_Y is (H2 - S2),
	fi_case(Del_X,Del_Y),
	find_start(S1,S2),
sun_loop(NN,Con1,Con2),!.
%====================  END LOOP  ==============
%optimize_phase==================
opti(0).
opti(N) :- NN is N-1,
		NN >= 0,pri_long([H_pri|T_pri]),
	 t_line([H1|T]),f_line(I),
		( NN > 1 ->pri_long([P1,P2,P3|_]),pri_long([HP1,HP2|Tail_pri]),
			t_line([A1,A2,A3|_]),t_line([H1,H2|TT]),
			(
				((A1+1=:=A2);(A1-7=:=A2)),
				((A1+2=:=A3);(A1-6=:=A3))->	
				f_line(I),
				retract(f_line(_)),assert(f_line([A1|I])),
				retract(t_line(_)),assert(t_line(TT)), 							
				lon_f(H_pri,Tail_pri)
			,!; 
				((A1-1=:=A2);(A2-7=:=A1)),
				((A1-2=:=A3);(A3-6=:=A1))->	
				f_line(I),
				retract(f_line(_)),assert(f_line([A1|I])),
				retract(t_line(_)),assert(t_line(TT)) 							
				,lon_f(H_pri,Tail_pri)
			,!;
			retract(f_line(_)),assert(f_line([A1|I]))
			,retract(t_line(_)),assert(t_line(T))
			,lon_f(H_pri,T_pri)
			)
		,!; 
		  f_line(I),retract(f_line(_)),assert(f_line([H1|I]))
		,retract(t_line(_)),assert(t_line(T))
		,lon_f(H_pri,T_pri)
		),t_line(P),len(P,NNN),
		opti(NNN).		
%optimize_phase==================
opti(0).
opti(N) :- NN is N-1,
		NN >= 0,pri_long([H_pri|T_pri]),
	 f_line([H1|T]),t_line(I),
		( NN > 1 ->
			f_line([A1,A2,A3|_]),f_line([H11,H2|TT]),
			pri_long([P1,P2,P3|_]),pri_long([HP1,HP2|Tail_pri]),
			(
				((A1+1=:=A2);(A1-7=:=A2)),
				((A1+2=:=A3);(A1-6=:=A3))->	
				t_line(I),
				retract(t_line(_)),assert(t_line([A1|I])),
				retract(f_line(_)),assert(f_line(TT)) ,
				lon_f(H_pri,Tail_pri)							
			,!; 
				((A1-1=:=A2);(A2-7=:=A1)),
				((A1-2=:=A3);(A3-6=:=A1))->	
				t_line(I),
				retract(t_line(_)),assert(t_line([A1|I])),
				retract(f_line(_)),assert(f_line(TT)), 							
				lon_f(H_pri,Tail_pri)
			,!;
			retract(t_line(_)),assert(t_line([A1|I]))
			,retract(f_line(_)),assert(f_line(T)),
			lon_f(H_pri,T_pri)
			)
		,!; 
		  t_line(I),retract(t_line(_)),assert(t_line([H1|I]))
		,retract(f_line(_)),assert(f_line(T)),lon_f(H_pri,T_pri) 
		)
		,f_line(P),len(P,NNN),
		opti(NNN),!.

lon_f(H_long,Tail) :-  sec_long(S),retract(sec_long(_)),assert(sec_long([H_long|S])),
		retract(pri_long(_)),assert(pri_long(Tail)),!.
%optimize_phase==================		
optim(0).  
optim(N) :- NN is N-1,
		NN >= 0,
			sec_long([H_sec|T_sec]),
	 f_line([H1|T]),t_line(I),
		( NN > 1 ->
			f_line([A1,A2,A3|_]),f_line([H1,H2|TT]),sec_long([S1,S2|Tail_S]),
			sec_long([Hs1,Hs2,Hs3|_]),H_add is Hs1+Hs2+Hs3,	H_plus is Hs2+Hs3,		
			(
				A1 =:= A3 -> 
				( opt(K0,A1,A2) -> D is K0 ; D is abs(A1-A2)),
				( D < 2 -> %retract(t_line(_)),assert(t_line([A1|I])),
				sel_as(I,A1,H_add,H_plus),
				retract(f_line(_)),assert(f_line(TT)) 							
				,retract(sec_long(_))
				,assert(sec_long(Tail_S))       				
		  			,!; 
					sel_as(I,H1,H_sec,0)
					%retract(t_line(_)),assert(t_line([I]))
					,retract(f_line(_)),assert(f_line(T)),
					cut_sec_long(T_sec)									
			)
				,!; 
		  		t_line(I),%retract(t_line(_)),assert(t_line([H1|I]))
				sel_as(I,H1,H_sec,0)
				,retract(f_line(_)),assert(f_line(T)),
				cut_sec_long(T_sec)
			)
		,!; 
	  	t_line(I)%,retract(t_line(_)),assert(t_line([H1|I])),
		,sel_as(I,H1,H_sec,0)
		,retract(f_line(_)),assert(f_line(T)),
		cut_sec_long(T_sec)
		)
			,f_line(P),len(P,NNN),
		optim(NNN).		
%%%%=======
opt(1,0,7).
opt(1,7,0).
%%%%%%%%%%%%%%%
sel_as(I,H1,H_sec,H_plus) :- len(I,L),
		( L > 0 ->  t_line([H|_]),
			( H =:= H1 -> G is 5,pri_long([H_pri|T_pri]),
					H_add is H_pri+H_sec,retract(pri_long(_)),
					assert(pri_long([H_add|T_pri]))
			 ; retract(t_line(_)),assert(t_line([H1|I])),
			pri_long(Pri_long),retract(pri_long(_)),
			assert(pri_long([H_sec|Pri_long]))
			)
		; retract(t_line(_)),assert(t_line([H1|I]))
		,pri_long(Pri_long),retract(pri_long(_)),
			assert(pri_long([H_sec|Pri_long]))
		),!.
cut_sec_long(H) :- retract(sec_long(_)),assert(sec_long(H)),!.
%%%======head phase================  
find_head(0).
find_head(N) :- NN is N -1,
		NN >= 0,
		f_line([A1|A]),retract(f_line(_)),assert(f_line(A)),
		sec_long([H_pri|T_pri]),retract(sec_long(_)),assert(sec_long(T_pri)),
		pri_long(S),retract(pri_long(_)),assert(pri_long([H_pri|S])),
		t_line(T),retract(t_line(_)),assert(t_line([A1|T])),
		t_line(TT),len(TT,Y),f_line(E),%,write(Y),nl,
		(
			Y =:= 4-> t_line([E1,B3,B2,B1|_]),
			( head_b(K0,B1,B2,B3) -> D0 is K0;D0 is (B2-B1)),	
			( head(K1,B2,B3,B1) -> D1 is K1;D1 is (B3-B2)),	
			( D0+D1 >=5 -> %retract(t_line(_)),assert(t_line([100|E])),NNN is 0;				
					del_noi_1(B3,E,E1),NNN is 0;
			  D0+D1 =< -5 ->%retract(t_line(_)), assert(t_line([200|E])),NNN is 0;
					del_noi_2(B3,E,E1),NNN is 0;
				G is 5 ,NNN is NN) ;
			Y =:= 5-> t_line([E1,B4,B3,B2,B1|_]),
			( head_b(K0,B1,B2,B3) -> D0 is K0;D0 is (B2-B1)),	
			( head(K1,B2,B3,B1) -> D1 is K1;D1 is (B3-B2)),	
			( head(K2,B3,B4,B2) -> D2 is K2;D2 is (B4-B3)),	
			
			( D0+D1+D2 >=5 ->%retract(t_line(_)), assert(t_line([100|E])),NNN is 0;				
					del_noi_1(B4,E,E1),NNN is 0;
			  D0+D1+D2 =< -5 ->del_noi_2(B4,E,E1),NNN is 0;
				G is 5 ,NNN is NN) ;
			Y =:= 6-> t_line([E1,B5,B4,B3,B2,B1|_]),
			( head_b(K0,B1,B2,B3) -> D0 is K0;D0 is (B2-B1)),	
			( head(K1,B2,B3,B1) -> D1 is K1;D1 is (B3-B2)),	
			( head(K2,B3,B4,B2) -> D2 is K2;D2 is (B4-B3)),	
		        ( head(K3,B4,B5,B3) -> D3 is K3;D3 is (B5-B4)),				

			( D0+D1+D2+D3 >=5 ->del_noi_1(B5,E,E1),NNN is 0;
			  D0+D1+D2+D3 =< -5 ->del_noi_2(B5,E,E1),NNN is 0;
				G is 5 ,NNN is NN );
			Y =:= 7-> t_line([E1,B6,B5,B4,B3,B2,B1|_]),
			( head_b(K0,B1,B2,B3) -> D0 is K0;D0 is (B2-B1)),	
			( head(K1,B2,B3,B1) -> D1 is K1;D1 is (B3-B2)),	
			( head(K2,B3,B4,B2) -> D2 is K2;D2 is (B4-B3)),	
		        ( head(K3,B4,B5,B5) -> D3 is K3;D3 is (B5-B4)),				
			( head(K4,B5,B6,B4) -> D4 is K4;D4 is (B6-B5)),				
			( D0+D1+D2+D3+D4 >=5 ->%retract(t_line(_)), assert(t_line([100|E])),NNN is 0;				
						del_noi_1(B6,E,E1),NNN is 0;
			  D0+D1+D2+D3+D4 =< -5 ->%retract(t_line(_)),assert(t_line([200|E])),NNN is 0;
						del_noi_2(B6,E,E1),NNN is 0;
				G is 5 ,NNN is NN);
			G is 5,NNN is NN
		),
		find_head(NNN).
%%%%%========= rule head====
head(-1,0,7,_).
head(-2,0,6,_).
head(-3,0,5,_). 

head(1,7,0,_).  
head(2,6,0,_).  
head(3,5,0,_).
 
head(-2,1,7,_).
head(-3,1,6,_).

head(2,7,1,_).
head(3,6,1,_).

head(-3,2,7,_).

head(3,7,2,_).

head(Y,6,2,X) :- ( (X =:= 1;X =:= 0;X =:= 7) -> Y is -4 ;
		     (X =:= 3;X =:= 4;X =:= 5) -> Y is 4 
		   ).	
head(Y,2,6,X) :- ( (X =:= 1;X =:= 0;X =:= 7) -> Y is 4 ;
		     (X =:= 3;X =:= 4;X =:= 5) -> Y is -4 
		   ).	
%%%%%%%%%%%%%
head_b(-1,0,7,_).
head_b(-2,0,6,_).
head_b(-3,0,5,_).  

head_b(1,7,0,_).  
head_b(2,6,0,_).  
head_b(3,5,0,_).
 
head_b(-2,1,7,_).
head_b(-3,1,6,_).

head_b(2,7,1,_).
head_b(3,6,1,_).

head_b(-3,2,7,_).

head_b(3,7,2,_).

head_b(Y,6,2,X) :- ( (X =:= 1;X =:= 0;X =:= 7) -> Y is -4 ;
		     (X =:= 3;X =:= 4;X =:= 5) -> Y is 4 
		   ).	
head_b(Y,2,6,X) :- ( (X =:= 1;X =:= 0;X =:= 7) -> Y is 4 ;
		     (X =:= 3;X =:= 4;X =:= 5) -> Y is -4 
		   ).	
%%%%%%%%%%%%%%%%%%%%%
del_noi_1(B,E,E1) :-pri_long([P1,P2|_]),sec_long(S), 
			(
			B =:= 6 -> 
				retract(f_line(_)),assert(f_line([100,B,E1|E])),retract(sec_long(_)),assert(sec_long([P2,P1|S]))
					,!;
			B =:= 2 -> chk_del_noi1(B,E1,E)
					,!;
			B =:= 5 -> 
					retract(f_line(_)),assert(f_line([100,B,E1|E])),retract(sec_long(_)),assert(sec_long([P2,P1|S]))
					,!;
			B =:= 7 -> 
					retract(f_line(_)),assert(f_line([100,B,E1|E])),retract(sec_long(_)),assert(sec_long([P2,P1|S]))
					,!;
			retract(f_line(_)),assert(f_line([100,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S]))
			),!.
del_noi_2(B,E,E1) :- pri_long([P1,P2|_]),sec_long(S), 
			(
			B =:= 6 -> 
					retract(f_line(_)),assert(f_line([200,B,E1|E])),retract(sec_long(_)),assert(sec_long([P2,P1|S]))
					,!;
			B =:= 2 -> chk_del_noi2(B,E1,E)
					,!;
			B =:= 5 -> 
					retract(f_line(_)),assert(f_line([200,B,E1|E])),retract(sec_long(_)),assert(sec_long([P2,P1|S]))
					,!;
			B =:= 7 -> 
					retract(f_line(_)),assert(f_line([200,B,E1|E]))	,retract(sec_long(_)),assert(sec_long([P2,P1|S]))		
					,!;
			retract(f_line(_)),assert(f_line([200,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S]))

			),!.

chk_del_noi1(B,E1,E) :- pri_long([P1,P2|_]),sec_long(S),

			 (
			E1 =:= 6 -> retract(f_line(_)),assert(f_line([100,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			E1 =:= 2 -> retract(f_line(_)),assert(f_line([100,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			E1 =:= 5 -> retract(f_line(_)),assert(f_line([100,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;

			E1 =:= 7 -> retract(f_line(_)),assert(f_line([100,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			 retract(f_line(_)),assert(f_line([100,B,E1|E])),
			retract(sec_long(_)),assert(sec_long([P2,P1|S]))
			),!.

chk_del_noi2(B,E1,E) :-pri_long([P1,P2|_]),sec_long(S),
			 (
			E1 =:= 6 -> retract(f_line(_)),assert(f_line([200,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			E1 =:= 2 -> retract(f_line(_)),assert(f_line([200,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			E1 =:= 5 -> retract(f_line(_)),assert(f_line([200,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			E1 =:= 7 -> retract(f_line(_)),assert(f_line([200,E1|E])),
			retract(sec_long(_)),assert(sec_long([P1|S])),!;
			 retract(f_line(_)),assert(f_line([200,B,E1|E])),
			retract(sec_long(_)),assert(sec_long([P2,P1|S]))
			),!.

find_final_line(H) :- f_line(X),len(X,XX),
			( XX =:= 0 -> retract(f_line(_)),assert(f_line(H))
			; G is 5
			),!.

find_final_long :- pri_long(X),reverse(X,XX),sec_long(Y),len(Y,YY),
			( YY =:= 0 -> retract(sec_long(_)),assert(sec_long(XX))
			; G is 5
			),!.


%%%%%%%%%%%%%%%%%%%%
run_min_H :-  use([A_,A1_|T_]),len(T_,TL_),N_X_ is (TL_/10),
			max_H(A1_,T_,B_,N_X_),
			use([A,A1|T]),len(T,TL),N_X is (TL/10),
			min_H(A,T,B,N_X).

min_H(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
min_H(A,[A1,_|T],B,N) :-( A < A1 -> B is A; B is A1 ),
			( N < 3 -> NN is 0  ;
			NN is N-2 ),
			min_H(B,T,C,NN).

max_H(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
max_H(A,[_,A1|T],B,N) :-( A > A1 -> B is A; B is A1 ),
			( N < 3 -> NN is 0  ;
			NN is N-2 ),
			max_H(B,T,C,NN).





%%%%%%%%%%FIND MIN AND MAX VALUE
ini_be_X_Y :- use([H1,H2|T]),run_min_H,use(Ref),reverse(T,Re_T),retract(use(_)),
			assert(use(Re_T)),use([T1,T2|_]),
				be_X_Y(BE),retract(be_X_Y(_)),assert(be_X_Y([H2,T1,H1,T2|BE])),
				retract(use(_)),assert(use(Ref)),!.

find_min:-  ini_be_X_Y,
			use([A,A1|T]),len(T,TL),N_X is TL,
			min_x1(A,T,B,N_X),
			use([C,C1|Tail]),len(Tail,T_L),N_Y is T_L,
		    max_x1(C,Tail,R,N_Y),

			use([D,D1|Tail_y1]),len(Tail_y1,T_y1),N_Y1 is T_y1,
		    min_y1(D1,Tail_y1,R1,N_Y1),
			use([E,E1|Tail_y2]),len(Tail_y2,T_y2),N_Y2 is T_y2,
		    max_y1(E1,Tail_y2,R2,N_Y2),			
			use(Mid_max),len(Mid_max,M_max),use([M1,M2|Mid]),N_mid is M_max/2,
			find_mid(M2,Mid,R_mid,N_mid),be_X_Y(S),			
			be_X_Y([Head_min,Y_max,Y_min,X_max,X_min|_]),
			use([H1,H2|_]),
			(Y_max-H2 =:= 0 -> S_ver is 0 ;
			S_ver is ((Y_max - Y_min)/(Y_max-Head_min))
			),
			(X_max - H1 =:= 0 -> S_hor is 0 ;
			S_hor is ((Y_max - Y_min)/(X_max-H1))
			),
			(X_max-X_min =:= 0 -> S_ref is 0 ;
			S_ref is ((Y_max - Y_min)/(X_max-X_min))
			),
			
			retract(be_X_Y(_)),assert(be_X_Y([S_ver,S_hor,S_ref|S])),!.
min_x1(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
min_x1(A,[A1,_|T],B,N) :-( A < A1 -> B is A; B is A1 ),
			NN is N-2,
			min_x1(B,T,C,NN).

max_x1(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
max_x1(A,[A1,_|T],B,N) :-( A > A1 -> B is A; B is A1 ),
			NN is N-2,
			max_x1(B,T,C,NN).


min_y1(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
min_y1(A,[_,A1|T],B,N) :-( A < A1 -> B is A; B is A1 ),
			NN is N-2,
			min_y1(B,T,C,NN).

max_y1(W,Q,E,0):- be_X_Y(M),
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
max_y1(A,[_,A1|T],B,N) :-( A > A1 -> B is A; B is A1 ),
			NN is N-2,
			max_y1(B,T,C,NN).

find_mid(W,Q,E,0):- be_X_Y(M),nl,
				retract(be_X_Y(_)),assert(be_X_Y([W|M])).
find_mid(A,[_,A1|T],B,N) :-( A < A1 -> B is A; B is A1 ),
			(N =:= 3 -> NN is 0;
			NN is N-2),
			find_mid(B,T,C,NN).
%%%%mouse up
f_mouse_up :- use(L),len(L,Ln),m_up(L,Ln),!.

m_up(T,6000) :- reverse(T,Tr),retract(use(_)),assert(use(Tr)),!.
m_up(T,0)    :- mouse_up(M),reverse(M,MM),retract(use(_)),assert(use(MM)),!.
m_up([H1|T],N) :- ( H1 =:= 4000 -> NN is 6000 ;
					mouse_up(M),retract(mouse_up(_)),assert(mouse_up([H1|M]))
					),
					NN is N-1,
					m_up(T,NN),!.
%%%%%%%%% END OF CALCULUS PHASE %%%%%%%%%%%%%%%%%%%

% EXIT the window upon request
getmouse_handler( (user_dialog,1001), msg_button, _, done ) :- 
		!.   
							
% CLEAR the window upon request
getmouse_handler( (user_dialog,1000), msg_paint, button_down, _ ) :- 
        gfx_window_redraw( (user_dialog,9000) ),
        gfx_window_redraw( (user_dialog,9001) ),
	init_getmouse,
        !.        	 
% RECOGNIZE
getmouse_handler( (user_dialog,1002), msg_button, _, _ ) :-
	
	use(GG),len(GG,L_G),write(L_G),nl,
(
	L_G > 5 -> 
	(
	retractall(use(_)),
	reverse(GG,NN),
	assert(use(NN)),nl,
	find_min,
	use_mm(Srt),
	retractall( use_mm(_)),
	assert( use_mm([2|Srt])),
	use(New_list),
	use([_,_|H]),
	retractall(use(_)),
	assert(use(H)),
	len(H,AA),write(AA),nl,J is ((AA/2) - 2),write(J),nl,
	use([H1,H2|_]),G1 is H1,G2 is H2,	
	ini_loop(G1,G2),
	sun_loop(J,H1,H2),
	find_last,
	for_line1,
	for_line,retractall(t_line(_)),assert(t_line([])),
	f_line(Y_for_case),nl,write(Y_for_case),write(`f_line`),nl,
	len(Y_for_case,YY),
	find_yag(Y_for_case),
	optim(YY), 
	retractall(f_line(_)),assert(f_line([])),
	t_line(DC),reverse(DC,DW),
	write(DW),nl,
	
	len(DW,DF),
	opti(DF),
	f_line(MM),write(MM),nl,

	len(MM,LM),
	find_head(LM),
	use_mm(Degree),
	reverse(Degree,Rdegree),
	retractall(use_mm(_)),
	assert(use_mm(Rdegree)),
	find_final_line(MM),
	f_line(FL),nl,write(FL),nl,
	mouse_up(MUP),len(MUP,L_MUP),
	exam_test(FL,L_MUP,MM) 
	) ; init_getmouse	,        msgbox(`กรุณาเขียนใหม่`,`กดปุ่มเขียนไหม่ก่อนครับ`,16'00000020,_)
  
),
	!.          

%HELP 
getmouse_handler( (user_dialog,1004), msg_button, _, _ ) :-
   help_dialog,
   !.

help_dialog :- 
   _S1 = [dlg_ownedbyprolog,ws_sysmenu,ws_caption],
   _S2 = [ws_child,ws_visible,ss_center],
   _S3 = [ws_child,ws_visible,ss_left],
   _S4 = [ws_child,ws_visible,ws_tabstop,bs_pushbutton],
   wdcreate(  help_dialog,        `การใช้งานโปรแกรม`,                                                   258, 307, 362, 261, _S1 ),
   wccreate( (help_dialog,10000), static, `วิธีการใช้งานโปรแกรมเขียนลายมือไทย เวอร์ชัน 1.0`,             30,  10, 310,  20, _S2 ),
   wccreate( (help_dialog,10001), static, `1. เขียนตัวอักษรพยัญชนะไทยลงในหน้าต่างรับลายมือเขียน`,        30,  40, 310,  20, _S3 ),
   wccreate( (help_dialog,10002), static, `2. จากนั้นกดปุ่มทำการรู้จำ จะได้ผลการรู้จำออกมาจากหน้าต่าง`,  30,  70, 320,  20, _S3 ),
   wccreate( (help_dialog,10003), static, `    แสดงผลการรู้จำตัวอักษร`,                                  30, 100, 310,  20, _S3 ),
   wccreate( (help_dialog,10004), static, `3. ถ้าต้องการเขียนใหม่เลือกปุ่มเขียนใหม่`,                    30, 130, 310,  20, _S3 ),
   wccreate( (help_dialog,10005), static, `4. เมื่อต้องการออกจากโปรแกรม เลือกปุ่มออกจากโปรแกรม`,         30, 160, 310,  20, _S3 ),
   wccreate( (help_dialog,1000),  button, `ปิดหน้าต่างการใช้งานโปรแกรม`,                                 90, 200, 180,  30, _S4 ),
   call_dialog(help_dialog,_).

%Select something in Listbox                     
getmouse_handler( (user_dialog,4000), msg_select, _, _ ) :-
        wlbxsel((user_dialog,4000),N,1),
        wlbxget((user_dialog,4000),N,L),
        !.   

% <=== Send to Edit Window
getmouse_handler( (user_dialog,1003), msg_button, _, _ ) :-
!. 

%END MENU
disp(X) :-  
			
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001))    
			,!.		


%%%% Test
exam_test(Y,L_MUP,MM) :- 
	(  L_MUP > 5 -> 
		(	rule3(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001))  ,write(`rule3`)  ;
		
			X=`Reject`, 
			gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',50,bold),	
			gfx((font = big -> text(40,50,X))),
        		gfx_end(( user_dialog,9001 ))
		);	
		(	rule7(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001))  , write(`rule6`)
			;rule6(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001)),write(`rule`)
			;rule(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001)),write(`rule`)
			; rule2(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001)) ,write(`rule2`)
			;rule4(X,MM)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001))  , write(`rule4`)

			;rule5(X,Y)->
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',200,bold),	
			gfx((font = big -> text(40,-10,X))),
        		gfx_end(( user_dialog,9001))  , write(`rule5`)
			
			;X=`Reject`, 
			gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',50,bold),	
			gfx((font = big -> text(40,50,X))),
        		gfx_end(( user_dialog,9001 ))
		)	
	)
		,!.
%%%%%cal_w
cal_w :- X=`มีหยัก`,
			  gfx_begin(( user_dialog,9001 )),
		        gfx_font_create(big,'MS Sans Serif',50,bold),	
			gfx((font = big -> text(20,80,X))),
        		gfx_end(( user_dialog,9001 ))
				,!.

%%%%%%find_yag
find_yag(X) :- len(X,Y),reverse(X,XX),
				(Y > 5 ->
				find_yag2(XX,XX,0) ; G is 5 )

,!.

find_yag2(X,U,4).
find_yag2([X2,X3,X4|XX],[X5|X6],Y) :- yag(YAG),
								( yag_mid(X4,X3) -> retract(yag(_)),assert(yag([1|YAG])),%cal_w,
									Y2 is 4;
								yag_mid(X4,X3,X2) -> retract(yag(_)),assert(yag([1|YAG])),%cal_w,
									Y2 is 4;
								Y2 is Y+1),
					find_yag2(X6,X6,Y2),!.
%%%%%% Rules Base Zone
yag_mid(7,1).
yag_mid(7,2).
yag_mid(6,1).
yag_mid(6,2).

yag_mid(7,0,1).
yag_mid(7,0,2).
yag_mid(6,0,1).
yag_mid(6,0,2).
yag_mid(6,0,6).
yag_mid(7,0,6).
yag_mid(0,1,6).
yag_mid(2,7,0).
yag_mid(2,0,1).

%yag_mid(2,1,2).
%yag_mid(2,0,2).
yag_mid(2,7,2).
yag_mid(2,6,2).

yag_mid(7,2,7).
yag_mid(7,1,7).
yag_mid(7,0,7).
%yag_mid(7,6,7).

yag_mid(1,2,1).
yag_mid(1,0,1).
yag_mid(1,7,1).
yag_mid(1,6,1).

yag_mid(0,2,0).
%yag_mid(0,1,0).
%yag_mid(0,7,0).
yag_mid(0,6,0).

yag_mid(6,2,6).
yag_mid(6,1,6).
%yag_mid(6,0,6).
%yag_mid(6,7,6).

?-consult(r_base1).
?-consult(r_base2).
?-consult(r_base3).
?-consult(r_base4).
?-consult(r_base5).