knight(Start,Goal) :-
	empty_stack(Empty_been_stack),
	stack(Start,Empty_been_stack,Been_stack),
	path(Start,Goal,Been_stack).
    
path(Goal, Goal,Been_stack) :-
    write('Solution sequence is: '), nl,
    reverse_print_stack(Been_stack).
    
path(Start, Start, L).
path(Start,Goal, L) :-
	move(Start, Z), not(member(Z, L)),
	path(Z, Goal, [Z | L]).

move(1,8).
move(1,6).
move(2,9).
move(2,7).

move(3,4).
move(3,8).
move(4,9).
move(4,3).

move(6,1).
move(6,7).
move(7,2).
move(7,6).

move(8,3).
move(8,1).
move(9,2).
move(9,4).

