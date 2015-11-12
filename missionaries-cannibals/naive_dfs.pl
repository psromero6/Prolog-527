%%%%% Basic depth first path algorithm in PROLOG %%%%%%%
%%%
%%% This is one of the example programs from the textbook:
%%%
%%% Artificial Intelligence: 
%%% Structures and strategies for complex problem solving
%%%
%%% by George F. Luger and William A. Stubblefield
%%% 
%%% Corrections by Christopher E. Davis (chris2d@cs.unm.edu)
%%%
%%% These programs are copyrighted by Benjamin/Cummings Publishers.
%%%
%%% We offer them for use, free of charge, for educational purposes only.
%%%
%%% Disclaimer: These programs are provided with no warranty whatsoever as to
%%% their correctness, reliability, or any other property.  We have written 
%%% them for specific educational purposes, and have made no effort
%%% to produce commercial quality computer programs.  Please do not expect 
%%% more of them then we have intended.
%%%
%%% This code has been tested with SWI-Prolog (Multi-threaded, Version 5.2.13)
%%% and appears to function as intended.

	
go(Start, Goal) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list),
	path(Start, Goal, Been_list).
	
	% path implements a depth first search in PROLOG
	
	% Current state = goal, print out been list
path(Goal, Goal, Been_list) :-
	reverse_print_stack(Been_list).
	
path(State, Goal, Been_list) :-
	move(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list),
        path(Next, Goal, New_been_list), !.

%%%%%%%%%%% move predicates
    
%%% boat %%%
%%%%%%%%%%%%
    
move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-1, Can_v is Can-1,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-2, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.
    
move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis, Can_v is Can-2,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-1, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis, Can_v is Can-1,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

%%% noboat %%%
%%%%%%%%%%%%%%
        
move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+1, Can_v is Can+1,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+2, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.
    
move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis, Can_v is Can+2,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+1, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis, Can_v is Can+1,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    
    /*simple test
    move(state(Mis,Can,1), state(2,2,0))
         :- write('try subtraction').
    */    

    
    
%%% illegal predicates %%%
    
illegal(state(M,C,B)) :- M < 0.
illegal(state(M,C,B)) :- M > 3.
illegal(state(M,C,B)) :- C < 0.
illegal(state(M,C,B)) :- C > 3.

illegal(state(1,3,B)).
illegal(state(2,3,B)).
illegal(state(1,2,B)).

illegal(state(2,0,B)).
illegal(state(1,0,B)).
illegal(state(2,1,B)).
	
reverse_print_stack(S) :-
	empty_stack(S).
reverse_print_stack(S) :-
	stack(E, Rest, S),
	reverse_print_stack(Rest),
	write(E), nl.
