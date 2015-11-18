To run the various prolog algorithms on our problems simple run the launch.pl file. 
This will load in all of the algorithms. 

It is currently set to load the rules of vampires and werewolves (vamp_wolves). 
To test black and white, uncomment line 3 ":- [black_white]." and comment line 2.

you can test each algorithm with default settings by running one of the following:

go_dfs().
go_bfs().
go_best().

They are equivilent to testing with the default search setting with each algorithm.

You can make specific tests with various states by putting Start and Goal into each "go" call.

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
