dfs(Start, Goal) :-
    write('dfs start'),nl,
    empty_stack(Empty_open),
    write('empty stack done'),nl,
    stack([Start, nil], Empty_open, Open_stack),
    write('stack function called'),nl,
    empty_set(Closed_set),
    write('empty closed set created'),nl,
    path(Open_stack, Closed_set, Goal).

%%% path predicates %%%
%%%%%%%%%%%%%%%%%%%%%%%
    
path(Open_stack, _, _) :-
    empty_stack(Open_stack),
    write('No solution found with these rules').

path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], _, Open_stack),
    State = Goal,
    nl, write('A Solution is Found!'), nl,
    printsolution([State, Parent], Closed_set).

path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], Rest_open_stack,
    Open_stack),
    get_children(State, Rest_open_stack, Closed_set, Children),
    add_list_to_stack(Children, Rest_open_stack, New_open_stack),
    union([[State, Parent]], Closed_set, New_closed_set),
    path(New_open_stack, New_closed_set, Goal), !.
    
get_children(State, Rest_open_stack, Closed_set, Children) :-
    bagof(Child, moves(State, Rest_open_stack, Closed_set, Child), Children).

printsolution(State_record, _):- 
    state_record(State,nil, State_record),
    write(State), nl.
printsolution(State_record, Closed) :-
    state_record(State, Parent, State_record),
    state_record(Parent, _, Parent_record),
    member(Parent_record, Closed),
    printsolution(Parent_record, Closed),
    write(State), nl.

%%% moveS predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%
    
moves(State, Rest_open_stack, Closed_set, [Next,State]) :-
    move(State, Next),
    %%%not(illegal(Next)), 
    not(member_stack([Next,_], Rest_open_stack)),
    not(member_set([Next,_], Closed_set)).




%%% stack predicates %%%
%%%%%%%%%%%%%%%%%%%%%%%%

add_list_to_stack(Children, Rest_open_stack,New_open_stack) :-
    append(Children, Rest_open_stack, New_open_stack).

writelist([]) :- nl.
writelist([H|T]):- print(H), nl,
		   writelist(T).
    
