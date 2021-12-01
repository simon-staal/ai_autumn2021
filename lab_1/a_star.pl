% Implements A* search
% Paths are sorted by FCost
choose(Path, [Path|OtherPaths], OtherPaths).

% Ensure our paths maintain sorted order when we add to graph
add_to_paths(NewPaths, OtherPaths, AllPaths) :-
    insert_in_order(NewPaths, OtherPaths, AllPaths).

insert_in_order([], Graph, Graph).

insert_in_order([Path|Paths], OtherPaths, Graph) :-
    insert_one(Path, OtherPaths, OtherPathsPlus),
    insert_in_order(Paths, OtherPathsPlus, Graph).

insert_one([Node1|Path1], [[Node2|Path2] | Paths], Graph) :-
    fcost_of(Node1, F1),
    fcost_of(Node2, F2),
    F1 < F2, !,
    Graph = [[Node1|Path1], [Node2|Path2] | Paths].

insert_one(Path, [CheaperPath|Paths], [CheaperPath|Graph]) :-
    insert_one(Path, Paths, Graph).

insert_one(Path, [], [Path]).

% Heuristics
out_of_place([], [], 0).

out_of_place([(X, Y, T1)|Tail], [(X, Y, T2)|Tail2], N) :-
    T1 \= T2,
    out_of_place(Tail, Tail2, N1),
    N is N1 + 1.

out_of_place([(X, Y, T1)|Tail], [(X, Y, T1)|Tail2], N) :-
    out_of_place(Tail, Tail2, N).

distance(_, [], 0).

distance(CurrBoard, [(X, Y, Tile)|Tail], D) :-
    member((X1, Y1, Tile), CurrBoard),
    distance(CurrBoard, Tail, D1),
    D is D1 + abs(Y - Y1) + abs(X - X1).
    