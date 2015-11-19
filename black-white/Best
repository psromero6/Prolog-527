:- [adts].
:- [black_white].
%%%BFS%%%%%
state_record(State, Parent, [State, Parent]).

go(Start,Goal):-
	empty_queue(Empty),
	state_record(Start, nil, State),
	add_to_queue(State, Empty, Open),
	empty_set(Closed_set),
	path(Open,Goal,Closed_set).

	%%% path predicates %%%
	
path(Open,_,_) :-
empty_queue(Open),
	write('No solution' ), nl.

path(Open,Goal,Closed):-
	%=([State_Tupole|_],Open),
	%=([State|_],State_Tupole),
	remove_from_queue(Next_record, Open, _),
    state_record(State, _, Next_record),
	is_Goal(State,Goal),
	nl, write('The solution is:'),nl,
	
	print_solution(Next_record, Closed).

		
path(Open,Goal,Closed) :-
    remove_from_queue(Next_record, Open, Rest_of_open),
    (bagof(Child, moves(Next_record, Open, Closed, Child), Children);Children = []),
	
    add_list_to_queue(Children, Rest_of_open, New_open), 
    add_to_set(Next_record, Closed, New_closed),
    path(New_open,Goal,New_closed),!.
	
moves(State_record, Open, Closed, Child_record) :-
    state_record(State, _, State_record),
    move(State, Next,[],[]),
    state_record(Next, _, Test),
    not(member_queue(Test, Open)),
    not(member_set(Test, Closed)),
    state_record(Next, State, Child_record).
	
add_list_to_queue([], Queue, Queue).

add_list_to_queue([H|T], Queue, New_queue) :-
    add_to_queue(H, Queue, Temp_queue),
    add_list_to_queue(T, Temp_queue, New_queue).

print_solution(State_record, _):- 
    state_record(State,nil, State_record),
    write(State), nl.
print_solution(State_record, Closed) :-
    state_record(State, Parent, State_record),
    state_record(Parent, _, Parent_record),
    member(Parent_record, Closed),
    print_solution(Parent_record, Closed),
    write(State), nl.

	