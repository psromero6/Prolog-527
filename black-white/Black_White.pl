
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
	delete(State, e, Goal_simple),
	=(Goal,State).
	
	
	heuristic(State,Goal,H):-
		elComp(State,Goal,0,H).
		
		
		elComp([F|Ftail],[F|Stail],Sum,Counter):-
			S is Sum+1,
			elComp(Ftail,Stail,S,Counter).
			
		elComp([_|Ftail],[_|Stail],Sum,Counter):-
			elComp(Ftail,Stail,Sum,Counter).
			
		elComp([],[],Sum,Counter):- =(Sum,Counter).
			