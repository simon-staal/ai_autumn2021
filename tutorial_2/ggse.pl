% A Graph is a list of paths
% A path is a list of nodes
% A node is your state-space representation
search(Graph, [Node|Path]):-
	choose([Node|Path], Graph,_),
	state_of(Node, State),
	goal_state(State),
    !.

search(Graph, SolnPath) :-
	choose(Path, Graph, OtherPaths),
	one_step_extensions( Path, NewPaths),
	add_to_paths(NewPaths, OtherPaths, GraphPlus),
	search(GraphPlus, SolnPath).

one_step_extensions([Node|Path], NewPaths):-
	state_of(Node, State),
	findall([NewNode,Node|Path],
		(state_change(_, State, NewState),
		 new_state_on_path( NewState, Path ),
		 make_node(Node, NewState, NewNode)),
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

