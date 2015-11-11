go(Start, Goal) :-
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
    write([State, Parent]), nl,
    writelist(Closed_set).

path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], Rest_open_stack,
    Open_stack),
    get_children(State, Rest_open_stack, Closed_set, Children),
    add_list_to_stack(Children, Rest_open_stack, New_open_stack),
    union([[State, Parent]], Closed_set, New_closed_set),
    path(New_open_stack, New_closed_set, Goal), !.
    
get_children(State, Rest_open_stack, Closed_set, Children) :-
    bagof(Child, moves(State, Rest_open_stack, Closed_set, Child), Children).

%%% moveS predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%
    
moves(State, Rest_open_stack, Closed_set, [Next,State]) :-
    move(State, Next),
    %%%not(illegal(Next)), 
    not(member_stack([Next,_], Rest_open_stack)),
    not(member_set([Next,_], Closed_set)).

%%% move predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%



    %%% boat %%%
    %%%%%%%%%%%%
    
    move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-1, Can_v is Can-1,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-2, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.
    
    move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis, Can_v is Can-2,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis-1, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,1), state(Mis_v,Can_v,0))
        :- Mis_v is Mis, Can_v is Can-1,
        not(illegal(state(Mis_v,Can_v,0))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    %%% noboat %%%
    %%%%%%%%%%%%%%
        
    move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+1, Can_v is Can+1,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+2, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.
    
    move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis, Can_v is Can+2,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis+1, Can_v is Can,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    move(state(Mis,Can,0), state(Mis_v,Can_v,1))
        :- Mis_v is Mis, Can_v is Can+1,
        not(illegal(state(Mis_v,Can_v,1))),
        write('missionaries='),write(Mis_v),write(', cannibals='),write(Can_v),nl.

    %%% illegal predicates %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    illegal(state(M,C,B)) :- M < 0.
    illegal(state(M,C,B)) :- M > 3.
    illegal(state(M,C,B)) :- C < 0.
    illegal(state(M,C,B)) :- C > 3.

    illegal(state(1,3,B)).
    illegal(state(2,3,B)).
    illegal(state(1,2,B)).

    illegal(state(2,0,B)).
    illegal(state(1,0,B)).
    illegal(state(2,1,B)).

    %%% stack predicates %%%
    %%%%%%%%%%%%%%%%%%%%%%%%

    add_list_to_stack(Children, Rest_open_stack,New_open_stack) :-
        append(Children, Rest_open_stack, New_open_stack).

    writelist([]) :- nl.
    writelist([H|T]):- print(H), nl,
         writelist(T).
    
