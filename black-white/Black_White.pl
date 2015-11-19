
	%%% move predicate %%%
	%%%%%%%%%%%%%%%%%%%%%%%

move(X,Y,Closed_set,Open_stack):-
	list_i_j_swapped(X,I,J,Y),
	nth0(I,X,e),
	<(abs(-(I,J)),4),
	>(abs(-(I,J)),0),
	not(member(Y,Closed_set)),
	not(member(Y,Open_stack)).
		
	
	
list_i_j_swapped(A,I,J,C) :-
   same_length(A,C),
   append(BeforeI,[AtI|PastI],A),
   append(BeforeI,[AtJ|PastI],B),
   append(BeforeJ,[AtJ|PastJ],B),
   append(BeforeJ,[AtI|PastJ],C),
   length(BeforeI,I),
   length(BeforeJ,J).	
	
	
		%%% goal predicate %%%
		%%%%%%%%%%%%%%%%%%%%%%%
		
is_Goal(State,Goal):-
	delete(Goal,e,Goal_simple),
	delete(State, e, State_simple),
	=(Goal_simple,State_simple).
	
	
		%%% heuristic predicate %%%
		%%%%%%%%%%%%%%%%%%%%%%%
	heuristic(State,Goal,H):-
	delete(Goal,e,Goal_simple),
	delete(State, e, State_simple),
		elComp(State_simple,Goal_simple,0,H).
		
		
		elComp([F|Ftail],[S|Stail],Sum,Counter):-
			not(=(F,S)),
			T is Sum+1,
			elComp(Ftail,Stail,T,Counter).
			
		elComp([F|Ftail],[F|Stail],Sum,Counter):-
		
			elComp(Ftail,Stail,Sum,Counter).
			
		elComp([],[],Sum,Counter):- =(Sum,Counter).
	
	cost(State,Next,G_new,G):-
			nth0(I,State,e),
			nth0(J,Next,e),
			C is abs(I-J),
			G_new is G + C.
		
			
	%%%%%% Default problem%%%%%%%%%%%
	default_problem(Start_state,Goal_state):-
		=(Start_state,[b,b,b,e,w,w,w]),
		=(Goal_state,[w,w,w,e,b,b,b]).		