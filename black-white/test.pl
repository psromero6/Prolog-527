move(state(Ve,We,B),state(Vw,Ww,not(B)))
	:- 
	write(['input']),
	% select passengers from a list of tuploles
	
		member(VWm,[[2,0],[1,0],[1,1],[0,1],[0,2]]),
		[Vm|Wl]=VWm,[Wm|_]=Wl,
		 boat_direction(B,Ve,Vm,Vw),
		 boat_direction(B,We,Wm,Ww),	
			
		writelist(['try one Vamp and one Wolf go west','V=',Vw,'W=',Ww]).
		
		
		
boat_direction(true,East,Boat,West)
		:- West is East-Boat.
		
boat_direction(false,East,Boat,West)
		:- West is East+Boat.
		
		
writelist([]) :- nl.

writelist([H|T]):- print(H), tab(1),  /* "tab(n)" skips n spaces. */
                   writelist(T).
				   
				   
				   