% Return first element of a list
first(X, [X|_]).

% Return last element of a list
last(X, [X]).

last(X, [_|Tail]) :-
    last(X, Tail),
    !.

% Return middle of a list

% Find if an element is a member of a list
find(X, [X|_]).

find(X, [_|Tail]) :-
    find(X, Tail),
    !.

% Append two lists together to form a third list
concat([], X, X).

concat([X|L1], L2, [X|L3]) :-
    concat(L1, L2, L3).

% Reverse a list
reverse([X], [X]).

reverse([X|L], R) :-
    reverse(L, R_prev),
    append(R_prev, [X], R),
    !.

% Reverse a list (not using append)

% Delete the first occurence of an element from a list
del_one(X, [X|L], L).

del_one(X, [Y|L], [Y|R]) :-
    del_one(X, L, R),
    !.

% Delete all occurrences of an element from a list
del_all(_, [], []).

del_all(X, [X|L], R) :-
    del_all(X, L, R),
    !.

del_all(X, [Y|L], [Y|R]) :-
    del_all(X, L, R),
    !.

% Substitute all occurences of one element for another in a list
substitute(_, [], _, []).

substitute(X, [X|L], Y, [Y|R]) :-
    substitute(X, L, Y, R),
    !.

substitute(X, [Z|L], Y, [Z|R]) :-
    substitute(X, L, Y, R),
    !.

% Test for a sub-list (Unfinished)
is_sub([X], [X|_]).

is_sub([X|S], [X|L]) :-
    is_sub(S, L),
    !.

is_sub([X|S], [_|L]) :-
    is_sub([X|S], L),
    !.