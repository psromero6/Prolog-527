	%%%BestFirstSearch%%%%%
state_record(State, Parent, G, H, F, [State, Parent, G, H, F]).

precedes([_,_,_,_,F1], [_,_,_,_,F2]) :- F1 =< F2. 

go_best():-
	default_problem(Start_default,Goal_default),
	go_best(Start_default,Goal_default).

go_best(Start,Goal):-
	empty_set(Closed),
    empty_sort_queue(Empty_open),
	heuristic(Start, Goal, H),
	 state_record(Start, nil, 0, H, H, First_record),
	insert_sort_queue(First_record, Empty_open, Open),
	path_best(Open,Goal,Closed).

	%%% path_best predicates %%%
	
path_best(Open,_,_) :-
	empty_sort_queue(Open),
	write('No solution' ), nl.

path_best(Open,Goal,Closed):-
	remove_sort_queue(First_record, Open, _),
    state_record(State, _, _, _, _, First_record),
	is_Goal(State,Goal),
	nl, write('The solution is:'),nl,
	
	print_solution_best(First_record, Closed).

		
path_best(Open,Goal,Closed) :-
    remove_sort_queue(First_record, Open, Rest_of_open),
    (bagof(Child,  moves_best(First_record, Open, Closed, Child, Goal), Children);Children = []),
    insert_list(Children, Rest_of_open, New_open), 
    add_to_set(First_record, Closed, New_closed),
	write('we now try:'),write(First_record),nl,
    path_best(New_open,Goal,New_closed),!.
	
moves_best(State_record, Open, Closed, Child,Goal) :-
    state_record(State, _, G, _,_, State_record),
    move(State, Next,[],[]),
    state_record(Next, _, _, _, _, Test),
    not(member_sort_queue(Test, Open)),
    not(member_set(Test, Closed)),
	G_new is G + 1,
    heuristic(Next, Goal, H),
    F is G_new + H,
    state_record(Next, State, G_new, H, F, Child).
insert_list([], L, L).

insert_list([State | Tail], L, New_L) :-
    insert_sort_queue(State, L, L2),
    insert_list(Tail, L2, New_L).

print_solution_best(Next_record, _):-  
    state_record(State, nil, _, _,_, Next_record),
    write(State), nl.
print_solution_best(Next_record, Closed) :-
    state_record(State, Parent, _, _,_, Next_record),
    state_record(Parent, _, _, _, _, Parent_record),
    member_set(Parent_record, Closed),
    print_solution_best(Parent_record, Closed),
    write(State), nl.