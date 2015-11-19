go(Start, Goal) :-
    write('dfs missionaries and canibbals:'),nl,
    empty_stack(Empty_open),
    stack([Start, nil], Empty_open, Open_stack),
    empty_set(Closed_set),
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
    write('got moves'),nl,
    move(State, Next),
    not(member_stack([Next,_], Rest_open_stack)),
    not(member_set([Next,_], Closed_set)).
/*
move(State,Next) :-
    write('got state: '),write(State),nl.
*/

move(state(Left,Right),state(NewL,NewR)) :-
    write('received state '),write(Left),write(', '),write(Right),
    [C | NewL]=Left,
    append([C],Right,NewR),
    write('Done with jump').



%%% stack predicates %%%
%%%%%%%%%%%%%%%%%%%%%%%%
add_list_to_stack(Children, Rest_open_stack,New_open_stack) :-
    append(Children, Rest_open_stack, New_open_stack).

writelist([]) :- nl.
writelist([H|T]):- print(H), nl,
		   writelist(T).

%representative string:
%go(state([a,b,c],[d,e,f]),state([d,e,f],[a,b,c])).
