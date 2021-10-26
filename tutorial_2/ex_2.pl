/* The ISN System utilises three letters of the alphabet, I, S  and  N. Sequences of the ISN System are composed of just these three characters. There are four rules for generating a new sequence from an old one. Letting x and y stand for arbitrary sequences of I, S and N, these four rules are: 
    1. From xS, generate xSN
    2. From Ix, generate Ixx
    3. From xSSSy, generate xNy
    4. From xNNy, generate xy
The problem is to show that from the sequence IS, the ISN-system can generate the sequence IN.
*/

state_change(rule1, Xs, Xsn) :-
    append(X, [s], Xs),
    append(X, [s, n], Xsn).

state_change(rule2, [i|X], [i|XX]) :-
    append(X, X, XX).

state_change(rule3, XsssY, XnY) :-
    append(X, [s, s, s|Y], XsssY),
    append(X, [n|Y], XnY).

state_change(rule4, XnnY, XY) :-
    append(X, [n,n|Y], XnnY),
    append(X, Y, XY).

goal_state([i,n]).

% Converts state to a node
% In this case, our state and our node is the same
make_node(_, NewState, NewState).

% Finds state of a node, in this case our node == state
state_of(State, State).

% Initial state and query:
% search([[[i, s]]], SolnPath).
% No solution possible
% input to search is a graph, which is an array of paths
% a path is an array of nodes
% a node is an array of characters => triple nested list
