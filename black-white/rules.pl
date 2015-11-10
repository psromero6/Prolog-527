

state(X):-
	is_list(X),
	permutation([b,b,b,e,w,w,w], X).
	
start(X):-
	state(X),
	=(X,[b,b,b,e,w,w,w]).
	
end(X):-
	state(X),
	delete(X, e, [w,w,w,b,b,b]).
	
equals(X,Y):-
	state(X),
	state(Y),
	=(X,Y).
	
	
	%% written similarly to http://stackoverflow.com/questions/26834387/swap-two-elements-from-list-with-specified-indices
	%%
list_i_j_swapped(A,I,J,C) :-
   same_length(A,C),
   append(BeforeI,[AtI|PastI],A),
   append(BeforeI,[AtJ|PastI],B),
   append(BeforeJ,[AtJ|PastJ],B),
   append(BeforeJ,[AtI|PastJ],C),
   length(BeforeI,I),
   length(BeforeJ,J).
   
cost(X,C):-
	=(abs(X),1) -> =(C,1);
	=(C,abs(X)-1).
   
move(X,Y,Cost):-
	list_i_j_swapped(X,I,J,Y),
	nth0(I,X,e),
	cost(I-J,Cost),
	<(abs(-(I,J)),4),
	>(abs(-(I,J)),0).	