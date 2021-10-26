/*
* Two Beer Glass Problem

* State Representation: 2-tuple (Int, Int)
* First int is amount of beer in 7 pint glass
* Second int is amount of beer in 5 pint glass

* Initial state: (0, 0)

* Goal state: (4, _)

*/

statechange(fill7, (S, F), (7, F)) :-
    S < 7.

statechange(fill5, (S, F), (S, 5)) :-
    F < 5.

statechange(empty7, (S, F), (0, F)) :-
    S > 0.

statechange(empty5, (S, F), (S, 0)) :-
    F > 0.

statechange(pour7to5, (S, F), (R, 5)) :-
    Total is S + F,
    Total > 5,
    R is Total - 5.

statechange(pour7to5, (S, F), (0, R)) :-
    R is S + F,
    R =< 5.

statechange(pour5to7, (S, F), (7, R)) :-
    Total is S + F,
    Total > 7,
    R is Total - 7.

statechange(pour5to7, (S, F), (R, 0)) :-
    R is S + F,
    R =< 7.

goal_state((4, _)).

% Initial state and query:
% id_search( [[(is, (0, 0))]], SolnPath, 0)
% Apprently GTA told khayle this, no clue what it is