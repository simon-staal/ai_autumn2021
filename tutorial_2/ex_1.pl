/*
* Two Beer Glass Problem

* State Representation: 2-tuple (Int, Int)
* First int is amount of beer in 7 pint glass
* Second int is amount of beer in 5 pint glass

* Initial state: (0, 0)

* Goal state: (4, _)

*/

state_change(fill7, (S, F), (7, F)) :-
    S < 7.

state_change(fill5, (S, F), (S, 5)) :-
    F < 5.

state_change(empty7, (S, F), (0, F)) :-
    S > 0.

state_change(empty5, (S, F), (S, 0)) :-
    F > 0.

state_change(pour7to5, (S, F), (R, 5)) :-
    Total is S + F,
    Total > 5,
    R is Total - 5.

state_change(pour7to5, (S, F), (0, R)) :-
    R is S + F,
    R =< 5.

state_change(pour5to7, (S, F), (7, R)) :-
    Total is S + F,
    Total > 7,
    R is Total - 7.

state_change(pour5to7, (S, F), (R, 0)) :-
    R is S + F,
    R =< 7.

goal_state((4, _)).

% Converts state to a node
make_node(_, NewState, NewState).

% Finds state of a node, in this case our node == state
state_of(State, State).

% Initial state and query:
% search( [[(0, 0)]], SolnPath).
% SolnPath = [(4, 5),  (7, 2),  (0, 2),  (2, 0),  (2, 5),  (7, 0),  (0, 0)].