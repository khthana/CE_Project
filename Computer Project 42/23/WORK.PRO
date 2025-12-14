
domains
    b1,b2,b3,b4,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11 = string
    c1,c2,c3,c4,c5,c6 = string
    strv = string
	
predicates

    go
    s(b1)
    np(string)
    np1(string)
    np2(string)
    npv(string)
    npv1(string)
    npv2
    verb(string)
    art(string)
    number(string)
    pronoun(string)
    adj(string)
    noun(string)
    
clauses

    go :- 
	write("Please insert Sentence"),nl,
	readln(Str),
	s(Str).
    s(Str) :-
    	np(Str).
    	
    np(Str) :-
    	fronttoken(Str,Sart,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	art(Sart),
    	write("Article = ",Sart),nl,
    	np1(Remain).
    np(Str) :-
    	fronttoken(Str,Snumber,Remain_),
    	frontchar(Remain_,Delee,Remain),   	
    	number(Snumber),
    	write("Number = ",Snumber),nl,
    	np1(Remain).
    np(Str) :-
    	fronttoken(Str,Spronoun,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	pronoun(Spronoun),
    	write("Pronoun = ",Spronoun),nl,
    	np2(Remain).
    	
    np(Str) :-
    	fronttoken(Str,Snoun,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	noun(Snoun),
    	write("Noun = ",Snoun),nl,
    	np2(Remain).
    np1(Str) :-
    	fronttoken(Str,Sadj,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	adj(Sadj),
    	write("Adjective = ",Sadj),nl,
    	np1(Remain).
    np1(Str) :-
    	fronttoken(Str,Snoun,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	noun(Snoun),
    	write("Noun = ",Snoun),nl,    	
    	np2(Remain).
    	
    np2(Str) :-
    	fronttoken(Str,Sverb,Remain_),
    	frontchar(Remain_,Delee,Remain),
    	verb(Sverb),
    	write("Verb = ",Sverb),nl,
    	npv(Remain).
    	
    np2(Str) :-
	verb(Str),
    	write("Verb = ",Str),nl.
	
    	    	
    npv(Str) :-
    	fronttoken(Str,Sartv,Remain_),
    	art(Sartv),
    	write("Article = ",Sartv),nl,    	
    	frontchar(Remain_,Delee,Remain),    	
    	npv1(Remain).
    npv(Str) :-
    	fronttoken(Str,Snumberv,Remain_),
    	number(Snumberv),
    	write("Number = ",Snumberv),nl,    	
    	frontchar(Remain_,Delee,Remain),    	
    	npv1(Remain).
    npv(Str) :-
    	fronttoken(Str,Spronounv,Remain_),
    	pronoun(Spronounv),
    	write("Pronoun = ",Spronounv),nl,    	
    	npv2.
    npv(Snounv) :-
    	noun(Snounv),
    	write("Noun = ",Snounv),nl,    	
    	npv2.    	
    npv1(Str) :-
    	fronttoken(Str,Sadjv,Remain_),
    	adj(Sadjv),
    	write("Adjective = ",Sadjv),nl,    	
    	frontchar(Remain_,Delee,Remain),
    	npv1(Remain).
    npv1(Str) :-
    	fronttoken(Str,Snounv,Remain_),
    	noun(Snounv),
    	write("Noun = ",Snounv),nl,    	
    	npv2.
    	
    npv2 .
    
/*  Data Jaaaaaa */

	art("A").
	art("The").	
	number("One").
	pronoun("It").
	pronoun("He").
	pronoun("She").
	adj("good").
	adj("bad").
	adj("smart").
	noun("man").
	noun("girl").
	noun("Sak").
	noun("Yo").
	noun("computer").
	verb("is").
	verb("are").
	verb("rest").
	verb("play").