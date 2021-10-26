% Implements breadth first search
choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, AllPaths) :-
    append(OtherPaths, NewPaths, AllPaths).