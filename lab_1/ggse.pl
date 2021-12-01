% A Graph is a list of paths
% A path is a list of nodes
% A node is your state-space representation
search(Graph, [Node|Path]):-
	choose([Node|Path], Graph,_),
	state_of(Node, State),
	goal_state(State)
    . % This cut is for breadth-first search only, find 1 optimal solution

search(Graph, SolnPath) :-
	choose(Path, Graph, OtherPaths), % Defined in graph search algorithm
	one_step_extensions( Path, NewPaths),
	add_to_paths(NewPaths, OtherPaths, GraphPlus), % Also defined in graph search algorithm
	search(GraphPlus, SolnPath).

one_step_extensions([Node|Path], NewPaths):-
	state_of(Node, State),
	gcost_of(Node, GPath), % Cost is # of moves
	findall([NewNode,Node|Path],
		(state_change(Rule, State, NewState, HCost), % Defined in state-space representation
		Gactual is GPath + 1,
		FCost is Gactual + HCost,
		new_state_on_path( NewState, Path ),
		make_node(Rule, NewState, Gactual, FCost, NewNode)), % Also defined in state-space representation
	NewPaths).

new_state_on_path( _, [] ).
new_state_on_path( State, [(State,_,_,_)|_] ) :-
	!, fail.
new_state_on_path( State, [_|Path] ) :-
	new_state_on_path( State, Path ).

write_graph( [] ) :-
	write( '=====' ), nl.
write_graph( [H|T] ) :-
	write( H ), nl,
	write_graph( T ).

