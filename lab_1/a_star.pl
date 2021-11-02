% Implements A* search
choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, AllPaths) :-
    append(OtherPaths, NewPaths, AllPaths).

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
    