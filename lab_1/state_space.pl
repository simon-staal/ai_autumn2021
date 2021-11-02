/*
The ‘ah’-puzzle (aka 8-puzzle) is played on a 3x3 board with 8 tiles and 1 ‘hole’ 
or ‘blank’ space, whereby one tile can slide into the hole/blank. The aim of the 
puzzle is to convert a starting arrangement into a particular goal arrangement, 
by finding a sequence of moves (sliding tiles)

State-space representation:
List of tuples (X, Y, V), where:
- X is the row number [1-3]
- Y is the column number [1-3]
Note top-left square is 1, 1, think matrix indices [row][col]
- V is the letter of the tile (x = empty)

Initial state:
[(1, 1, d), (1, 2, a), (1, 3, c), (2, 1, g), (2, 2, b), (2, 3, f), (3, 1, x), (3, 2, e), (3, 3, h)]

Goal state:
[(1, 1, a), (1, 2, b), (1, 3, c), (2, 1, d), (2, 2, e), (2, 3, f), (3, 1, g), (3, 2, h), (3, 3, x)]
*/

% Moves a tile up
state_change(swap, CurrBoard, NewBoard) :-
    member((X, Y, x), CurrBoard),
    adjecent((X, Y), (X1, Y1)),
    member((X1, Y1, Tile), CurrBoard),
    swap(x, Tile, CurrBoard, NewBoard).

adjecent((X, Y), (X1, Y)) :-
    X < 3,
    X1 is X + 1.

adjecent((X, Y), (X1, Y)) :-
    X > 1,
    X1 is X - 1.

adjecent((X, Y), (X, Y1)) :-
    Y < 3,
    Y1 is Y + 1.

adjecent((X, Y), (X, Y1)) :-
    Y > 1,
    Y1 is Y - 1.

% swap(Tile1, Tile2, CurrBoard, NewBoard) takes 2 tiles in currboard and swaps them, returning newBoard
swap(_, _, [], []).

swap(T1, T2, [(X, Y, T1)|Tail], [(X, Y, T2)|Res]) :-
    swap(T1, T2, Tail, Res).
swap(T1, T2, [(X, Y, T2)|Tail], [(X, Y, T1)|Res]) :-
    swap(T1, T2, Tail, Res).

swap(T1, T2, [(X, Y, T3)|Tail], [(X, Y, T3)|Res]) :-
    T1 \= T3,
    T2 \= T3,
    swap(T1, T2, Tail, Res).