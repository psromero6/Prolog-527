go(Start,Goal):-
	empty_stack(Empty_been_stack),
	stack(Start,Empty_been_stack,Been_stack),
	path(Start,Goal,Been_stack).

path(Goal,Goal,Been_stack) :-
	write('Solution Path Is:' ), nl,
	reverse_print_stack(Been_stack).

path(State,Goal,Been_stack) :-
	move(State,Next_state),
	not(member_stack(Next_state,Been_stack)),
	stack(Next_state,Been_stack,New_been_stack),
	path(Next_state,Goal,New_been_stack),!.
	
	
	
move(X,Y):-
	list_i_j_swapped(X,I,J,Y),
	nth0(I,X,e),
	<(abs(-(I,J)),4),
	>(abs(-(I,J)),0).
	
	
list_i_j_swapped(A,I,J,C) :-
   same_length(A,C),
   append(BeforeI,[AtI|PastI],A),
   append(BeforeI,[AtJ|PastI],B),
   append(BeforeJ,[AtJ|PastJ],B),
   append(BeforeJ,[AtI|PastJ],C),
   length(BeforeI,I),
   length(BeforeJ,J).

   /*stack operations*/

member(X,[X|_]).
member(X,[_|T]):-member(X,T).

empty_stack([]).



member_stack(E, S) :- member(E, S).


stack(E, S, [E|S]).
   
   /*
 * Definitions of writelist, and opp.
 */

writelist([]) :- nl.
writelist([H|T]):- print(H), tab(1),  /* "tab(n)" skips n spaces. */
                   writelist(T).

opp(e,w).
opp(w,e).

reverse_print_stack(S) :-
        empty_stack(S).
reverse_print_stack(S) :-
        stack(E, Rest, S),
        reverse_print_stack(Rest),
        write(E), nl.

   /*

state(X):-
	is_list(X),

	permutation([b,b,b,e,w,w,w], X).
	
	

start_q(X):-
	state(X),
	=(X,[b,b,b,e,w,w,w]).
	
	

end(X):-
	state(X),
	delete(X, e, [w,w,w,b,b,b]).
	
equals(X,Y):-
	state(X),
	state(Y),
	=(X,Y).
	
	

   
 
cost(X,C):-
	=(abs(X),1) -> =(C,1);
	=(C,abs(X)-1).
   
move(X,Y):-
	list_i_j_swapped(X,I,J,Y),
	nth0(I,X,e),
	<(abs(-(I,J)),4),
	>(abs(-(I,J)),0).	
	
	
search(State,Open_Stack,Closed_Stack):-
	findall(C,move(State,C,Cost),Y),
	=([H|T],Y),
	search(State,Open_Stack,Closed_Stack).
	
goalcheck(List,Goal):-
	=([H|Tail],List),
	(end(H)-> =(Goal,H);
	goalcheck(Tail,Goal)).
*/