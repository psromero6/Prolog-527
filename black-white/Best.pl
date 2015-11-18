:- [adts].
:- [black_white].
%%%BFS%%%%%
state_record(State, Parent, G, H, F, [State, Parent, G, H, F]).
precedes([_,_,_,_,F1], [_,_,_,_,F2]) :- F1 =< F2. 

go(Start,Goal):-
	empty_set(Closed),
    empty_sort_queue(Empty_open),
	heuristic(Start, Goal, H),
	 state_record(Start, nil, 0, H, H, First_record),
	insert_sort_queue(First_record, Empty_open, Open),
	path(Open,Goal,Closed).

	%%% path predicates %%%
	
path(Open,_,_) :-
 empty_sort_queue(Open),
	write('No solution' ), nl.

path(Open,Goal,Closed):-
	remove_sort_queue(First_record, Open, _),
    state_record(State, _, _, _, _, First_record),
	is_Goal(State,Goal),
	nl, write('The solution is:'),nl,
	
	print_solution(First_record, Closed).

		
path(Open,Goal,Closed) :-
    remove_sort_queue(First_record, Open, Rest_of_open),
	
    (bagof(Child,  moves(First_record, Open, Closed, Child, Goal), Children);Children = []),
	
    insert_list(Children, Rest_of_open, New_open), 
    add_to_set(First_record, Closed, New_closed),
    path(New_open,Goal,New_closed),!.
	
moves(State_record, Open, Closed, Child,Goal) :-
    state_record(State, _, G, _,_, State_record),
    move(State, Next,[],[]),
    state_record(Next, _, _, _, _, Test),
    not(member_sort_queue(Test, Open)),
    not(member_set(Test, Closed)),
	G_new is G + 1,
    heuristic(Next, Goal, H),
    F is G_new + H,
    state_record(Next, State, G_new, H, F, Child).
	
    %insert_list inserts a list of states obtained from a  call to
    % bagof and  inserts them in a priotrity queue, one at a time
insert_list([], L, L).
insert_list([State | Tail], L, New_L) :-
    insert_sort_queue(State, L, L2),
    insert_list(Tail, L2, New_L).

    % Printsolution prints out the solution path by tracing
    % back through the states on closed using parent links.
print_solution(Next_record, _):-  
    state_record(State, nil, _, _,_, Next_record),
    write(State), nl.
print_solution(Next_record, Closed) :-
    state_record(State, Parent, _, _,_, Next_record),
    state_record(Parent, _, _, _, _, Parent_record),
    member_set(Parent_record, Closed),
    print_solution(Parent_record, Closed),
    write(State), nl.

/*
printsolution(Next_record, Closed) :-
    state_record(State, Parent, _, _,_, Next_record),
    state_record(Parent, Grand_parent, _, _, _, Parent_record),
    member_set(Parent_record, Closed),
    printsolution(Parent_record, Closed),
    write(State), nl.
*/
	