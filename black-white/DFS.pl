	%%%DFS%%%%%
go_dfs():-
	default_problem(Start_default,Goal_default),
	go_dfs(Start_default,Goal_default).

go_dfs(Start,Goal):-
	empty_stack(Empty),
	stack([Start, nil], Empty, Open_stack),
	empty_set(Closed_set),
	path_dfs(Open_stack,Goal,Closed_set).

	%%% path_dfs predicates %%%
	
path_dfs(Open_stack,_,Closed_Set) :-
empty_stack(Open_stack),
	write('No solution' ), nl,
	 reverse_print_stack(Closed_Set).

path_dfs(Open_stack,Goal,Closed_set):-
	=([State_Tupole|_],Open_stack),
	=([State|_],State_Tupole),
	is_Goal(State,Goal),
	nl, write('The solution is:'),nl,
	reverse_print_stack(Closed_set),
	write(State).

		
path_dfs(Open_stack,Goal,Closed_Set) :-

	=([State_Tupole|Open_States],Open_stack),
	=([State|_],State_Tupole),
	findall([Next_State|State],move(State,Next_State,Closed_Set,Open_States),Next_states),
	append(Next_states,Open_States,New_Open_stack),
	stack(State,Closed_Set,New_Closed_Set),
	write('we now try:'),write(State),nl,
	path_dfs(New_Open_stack,Goal,New_Closed_Set).

	