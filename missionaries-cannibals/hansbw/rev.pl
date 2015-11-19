/*
after writing rev, I learned that reverse is a built in function
(which I had tried and failed to use)
*/

rev(Forward,Backward) :-
    write('start of reverse function'),nl,
    [H | T]=Forward,
    write('H='),write(H),write(', T='),write(T),write(', Forward='),write(Forward),
    reverse(T,Temp),
    append(Temp, [H], Backward).

revhelper(state(Left,Right),state(Tfel,Right)) :-
    rev(Left,Tfel).


%make Goal be lists in correct direction, reverse left list of state to get correct direction
goalcheck(state(Sl,Sr),state(Gl,Gr)) :-
    rev(Sl,X),
    append(X,Sr,State),
    append(Gl,Gr,Goal),
    write('State='),write(State),write(', Goal'),write(Goal),nl,
    State=Goal.

/*
test case:
goalcheck(state([c,b,a],[d,e,f]),state([a,b,c],[d,e,f])).
goalcheck(state([a],[b,c]),state([a],[b,c])).
*/
    
move(state(Left,Right), state(NewL,NewR)) :-
    write(state(Left,Right)),nl,
    [C | NewL]=Left,
    append([C], Right, NewR),
    reverse(Left,Templ),reverse(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail jumped'),nl.

/*
move(state(Left,Right), state(NewL,NewR)) :-
    [D | NewR]=Right,
    append([D], Left, NewL),
    rev(Left,Templ),rev(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail jumped'),nl.
*/


/*
Left=[a],
Right=[b],
[C | NewL]=Left,
append([C], Right, NewR),
rev(Left,Templ),rev(NewL,TempNew),
    write(Templ),write(', '),write(Right),write('--> '),
    write(TempNew),write(', '),write(NewR),write(' right tail jumped'),nl.
*/
