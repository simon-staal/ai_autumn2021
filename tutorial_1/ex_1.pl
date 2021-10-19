% Return first element of a list
first(X, [X|_]).

% Return last element of a list
last(X, [X]).

last(X, [_|Tail]) :-
    last(X, Tail),
    !. % Makes this only return 1 answer and not let you look for others

% Return middle of a list
middle([X], X). % 'X' is the middle of a list with a single element
middle([X, _], X). % 'X' is the middle of a list with 2 elements

middle([_|T], X) :-
    deleteLast(T, TWithoutLast),
    middle(TWithoutLast, X),
    !.

deleteLast([_], []).

deleteLast([H|T], [H|R]) :-
    deleteLast(T, R),
    !.

/* An alternate of deleteLast using append:
deleteLast(L, L1) :-
    append(L1, [_], L).
*/

% Find if an element is a member of a list
find(X, [X|_]).

find(X, [_|Tail]) :-
    find(X, Tail).

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

% Reverse a list (not using append) - kinda cheese approach I guess ( bad >:( )
/*reverse2([X], [X]).

reverse2(L, [H|R]) :-
    last(H, L),
    deleteLast(L, LWithoutLast),
    reverse2(LWithoutLast, R).
*/

% More elegant solution
reverse2([], Acc, Acc). % When the input list is empty, our accumulator = our reversed list

reverse2([H|T], X, Acc) :- % We add H to the front of our accumulator, and find the reverse of the tail
    reverse2(T, X, [H|Acc]).

% Call this function with reverse2(List, Result, []) (i.e. accumulator starts empty)

% Delete the first occurence of an element from a list
del_one(_, [], []).

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

% Test for a sub-list
is_segment([X], [X|_]).

is_segment([X|S], [X|L]) :-
    is_segment(S, L).

is_sub([X|S], [X|L]) :-
    is_segment(S, L).

is_sub([X|S], [Y|L]) :-
    dif(X, Y), % Same as X \= Y
    is_sub([X|S], L).

% Sieve a list (remove all elements less than a given element)
sieve([], _, []).

sieve([H|T], X, R) :-
    H < X,
    sieve(T, X, R).

sieve([H|T], X, [H|R]) :-
    H >= X,
    sieve(T, X, R).

% Partition a list into two lists
% partition(List, Elem, L1, L2)

partition([X|L2], X, [], [X|L2]).

partition([H|T], X, [H|L1], L2) :-
    dif(H, X),
    partition(T, X, L1, L2).