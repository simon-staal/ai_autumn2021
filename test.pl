% A Graph is a list of paths
% A path is a list of nodes
% A node is your state-space representation
ibbs_search(Graph, SolnPath, Beam) :-
    search(Graph, Solnpath, Beam),
    !.

ibbs_search(Graph, SolnPath, Beam) :-
    Beamplus is Beam + 1,
    ibbs_search(Graph, Solnpath, Beamplus).


search(Graph, [Node|Path], _):-
	choose([Node|Path], Graph,_),
	state_of(Node, State),
	goal_state(State)
    . % This cut is for breadth-first search only, find 1 optimal solution

search(Graph, SolnPath, Beam) :-
	choose(Path, Graph, OtherPaths), % Defined in graph search algorithm
	one_step_extensions( Path, NewPaths),
	add_to_paths(NewPaths, OtherPaths, GraphPlus, Beam), % Also defined in graph search algorithm
	search(GraphPlus, SolnPath).

% Implements breadth first search
choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, GraphPlus, Beam) :-
    insert_in_order(NewPaths, OtherPaths, AllPaths),
    prune(AllPaths, Beam, GraphPlus).

prune([], _, []).
prune(_, 0, []) :- !.
prune([H|T1], Beam, [H|T2]) :-
    NarrowBeam is Beam - 1,
    prune(T1, NarrowBeam, T2).

insert_in_order([], AllPaths, AllPaths).
insert_in_order(Allpaths, [], AllPaths).
insert_in_order([H1|T1], [H2|T2], [H1|Res]) :-
    getCost(H1, Cost1),
    getCost(H2, Cost2),
    Cost1 > Cost2,
    insert_in_order(T1, [H2|T2], Res), !.

insert_in_order(New, [H2|T2], [H2|Res]) :-
    insert_in_order(New, T2, Res).


getCost([(_, Cost)|_], Cost).

goal_state((4, _)).

% Converts state to a node
make_node(Rule, NewState, (NewState, Rule)).

% Finds state of a node, we are including rules as part of the node so we strip that part to find our state
state_of((State, _), State).