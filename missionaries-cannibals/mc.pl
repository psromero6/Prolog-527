%%% heuristic predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

heuristic(state(M,C,B), Goal, H) :-
    TempH is M+C,
        H is TempH+B.

%%% move predicate %%%
%%%%%%%%%%%%%%%%%%%%%%%
    
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

