	%%% move predicate %%%
	%%%%%%%%%%%%%%%%%%%%%%%
	
move(state(Vampires_East,Werewolves_East,B),state(Vampires_West,Werewolves_West,F),Closed_set,Open_stack) :-
	member(VWm,[[2,0],[1,0],[1,1],[0,1],[0,2]]),
	[Vm|Wl]=VWm,
	[Wm|_]=Wl,
	boat_direction(B,Vampires_East,Vm,Vampires_West,F),
	boat_direction(B,Werewolves_East,Wm,Werewolves_West,F),
	not(illegal(state(Vampires_West,Werewolves_West,F))),
	not(member(state(Vampires_West,Werewolves_West,F),Closed_set)),
	not(member(state(Vampires_West,Werewolves_West,F),Open_stack)).
		
		
	%%% boat location predicates%%%%%
	
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
	:- member([V,W],[[1,3],[2,3],[1,2],[2,0],[1,0],[2,1]]).
	
	%%%% Goal States %%%%
	%%%%%%%%%%%%%%%%%%%%%
	
is_Goal(State,Goal):-
	=(State,Goal).
	
	
	%%%% Heruristc States %%%%
	%%%%%%%%%%%%%%%%%%%%%	
	
heuristic(state(Vampires_East,Werewolves_East,_),state(Vampires_West,Werewolves_West,_),H):-
		square(-(Vampires_East,Vampires_West),A),
		square(-(Werewolves_East,Werewolves_West),B),
		H is sqrt(A+B).

		cost(_,_,G_new,G):-
	G_new is G + 1 .		
		
square(X,Y):-
		Y is X * X.
		
		
	 %%%%%% Default problem%%%%%%%%%%%
default_problem(Start_state,Goal_state):-
		=(Start_state,state(3,3,true)),
		=(Goal_state,state(0,0,false)).
		