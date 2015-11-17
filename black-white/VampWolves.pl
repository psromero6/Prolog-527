:- [adts].

go(Start,Goal):-
	empty_stack(Empty),
	stack([Start, nil], Empty, Open_stack),
	empty_set(Closed_set),
	%writelist([Open_stack,Goal,Closed_set]),
	path(Open_stack,Goal,Closed_set).

	%%% path predicates %%%
	
path(Open_stack,_,Closed_Set) :-
empty_stack(Open_stack),
	write('No solution' ), nl,
	 reverse_print_stack(Closed_Set).

path(Open_stack,Goal,_):-
	=([State_Tupole|Open_States],Open_stack),
	=([State|_],State_Tupole),
	State=Goal,
	nl, write('The solution is:').

	
	
	

	
path(Open_stack,Goal,Closed_Set) :-

	=([State_Tupole|Open_States],Open_stack),
	=([State|_],State_Tupole),
	findall([Next_State|State],move(State,Next_State,Closed_Set,Open_States),Next_states),
	append(Next_states,Open_States,New_Open_stack),
	stack(State,Closed_Set,New_Closed_Set),
	path(New_Open_stack,Goal,New_Closed_Set).
	
	
	
%%% move predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%
	
move(state(Vampires_East,Werewolves_East,B),state(Vampires_West,Werewolves_West,F),Closed_set,Open_stack) :-
	member(VWm,[[2,0],[1,0],[1,1],[0,1],[0,2]]),
	[Vm|Wl]=VWm,
	[Wm|_]=Wl,
	%writelist(['boat_direction',B,Vampires_East,Vm,Vampires_West],
	boat_direction(B,Vampires_East,Vm,Vampires_West,F),
	boat_direction(B,Werewolves_East,Wm,Werewolves_West,F),
	not(illegal(state(Vampires_West,Werewolves_West,F))),
	not(member(state(Vampires_West,Werewolves_West,F),Closed_set)),
	not(member(state(Vampires_West,Werewolves_West,F),Open_stack))	.	
	%writelist(['V=',Vampires_West,'W=',Werewolves_West]).
		
		
	%boat location predicates%
	
boat_direction(true,East,Boat,West,F)
		:- West is East-Boat,=(F,false).
		
boat_direction(false,East,Boat,West,F)
		:- West is East+Boat,=(F,true).
	

	%%% Illegal States%%%
	%%%%%%%%%%%%%%%%%%%%%
	
illegal(state(_,W,_)) 
	:- W>3;
		W<0.
	
illegal(state(V,_,_)) 
	:- V>3;
		V<0.
		
illegal(state(V,W,_))
	:- member([V|W],[[1,2],[2,3],[1,2],[2,0],[1,0],[2,1]]).
