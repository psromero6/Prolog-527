go(Start, Goal) :-
    write('dfs black and white tile:'),nl,
    empty_stack(Empty_open),
    revhelper(Start,StartF),
    stack([StartF, nil], Empty_open, Open_stack),
    empty_set(Closed_set),
    path(Open_stack, Closed_set, Goal).

%%% path predicates %%%
%%%%%%%%%%%%%%%%%%%%%%%
    
path(Open_stack, _, _) :-
    %write('entered fail state test'),nl,
    empty_stack(Open_stack),
    write('No solution found with these rules').

path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], _, Open_stack),
    %%% State = Goal,
    goalcheck(State,Goal),
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
    not(member_stack([Next,_], Rest_open_stack)),
    not(member_set([Next,_], Closed_set)).


%%% move predicates %%%
%%%%%%%%%%%%%%%%%%%%%%%


%%% List 1 moves %%%
%%%%%%%%%%%%%%%%%%%%

move(state(Left,Right), state(NewL,NewR)) :-
    write('begin left jump attempt'),
    [C | NewL]=Left,
    append([C], Right, NewR),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' left tail jumped'),nl.

move(state(Left,Right), state(NewL,NewR)) :-
    [C,B | NewL]=Left,
    append([B],Right,Temp),
    append( [C],Temp, NewR),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' left tail-1 jumped'),nl.

move(state(Left,Right), state(NewL,NewR)) :-
    [C,B,A | NewL]=Left,
    append([A],Right,Temp1),
    append([C],Temp1,Temp2),
    append( [B],Temp2, NewR),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' left tail jumped'),nl.

%%% List 2 moves %%%
%%%%%%%%%%%%%%%%%%%%


move(state(Left,Right), state(NewL,NewR)) :-
    [D | NewR]=Right,
    append([D], Left, NewL),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail jumped'),nl.

move(state(Left,Right), state(NewL,NewR)) :-
    [D,E | NewR]=Right,
    append([E], Left, Temp),
    append([D], Temp, NewL),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail-1 jumped'),nl.

move(state(Left,Right), state(NewL,NewR)) :-
    [D,E,F | NewR]=Right,
    append([F],Left,Temp1),
    append([D],Temp1,Temp2),
    append([E],Temp2,NewL),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail-2 jumped'),nl.

add_list_to_stack(Children, Rest_open_stack,New_open_stack) :-
    append(Children, Rest_open_stack, New_open_stack).

writelist([]) :- nl.
writelist([H|T]):- print(H), nl,
		   writelist(T).

%assuming two lists of three as input
/*
given goal of [w,w,w][b,b,b]
actual goals are:
[][w,w,w,b,b,b]
[w,w,w,b,b,b][]
[w][w,w,b,b,b]
[w,w,w,b,b][b]
[w,w][w,b,b,b]
[w,w,w,b][b,b]
[w,w,w][b,b,b] (given)
*/

%%buildGoals(state(Left,Right),Goal) :-
    
    
%go(state([w,w,w],[b,b,b]),state([b,b,b],[w,w,w])).

/*
    A=state([b,b,b,w,w,w],[]),
    B=state([b,b,b,w,w,w], []),
    A=B.
 */

/*
todo reverse list implementation
goal checking for all 7 win states
*/
