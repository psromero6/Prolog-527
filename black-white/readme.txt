This implementation was written and tested in SWI prolog

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%	launch.pl file	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

To run the various prolog algorithms on our problems, first load the launch.pl file, like:
['path/to/directory/launch.pl'].
This will load in all of the algorithms. 

Because both problems (VW and BW) use the 'move' predicate, only one problem can be tested at a time.
It is currently set to load the rules of vampires and werewolves (vamp_wolves). 
To test black and white, uncomment line 3 ":- [black_white]." and comment line 2 in the launch.pl file.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%	search implementations	%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Our search implementations were guided by George Luger's example search implementations
from his book "AI Algorithms, Data Structures and Idioms in Prolog, Lisp, and Java".
You can test each algorithm with default settings by calling one of the following:

go_dfs().
go_bfs().
go_best().

with the appropriate arguments.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	example calls	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vampire/werewolf problem:
go_bfs(state(3,3,true),state(0,0,_)).

Black/white problem:
go_bfs([b,b,b,e,w,w,w],[w,w,w,b,b,b]).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	explanation of states %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

go_bfs(state(0,0,false),state(3,3,_)) will do a best first search of moving from the west shore to the eastshore,
without caring about where the boat ends up.

The state formats are as follows:
vamps_wolves:
 state(EastShoreVamps,EastShoreWolves,IsTheBoatEast)
 example:
 Start=state(3,3,true)

black_white
  b for black, w for white, e for empty, in a list that represents the state.

  example:
  Start=[b,b,b,e,w,w,w]

  Because the location of the empty does not matter for the goal our goal state can, but not must, 
	be represented without the 'e'.
  Goal=[w,w,w,b,b,b] or [w,w,w,b,b,e,b].
