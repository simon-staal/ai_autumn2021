/* You are given 7 balls of identical size, shape, colour, texture, but one ball is slightly heavier than the others.

You are also given a weighing maachine with two pans. The machine tells you which of the 2 pans is heavier, but you can only use it twice. Find how to weigh the balls so that you can identify which one is the heavier one.

scale can lean left, right, or middle

State representation
(List1, List2, List3, N)
List1 is Balls not in a Pan
List2 is LeftPan
List3 is RightPan
N is number of weighs

Start state
([1, 2, 3, 4, 5, 6, 7], [], [], 0)

Goal State
(L, [], [], N), length(L, 1), N < 3

Actions:
-Distribute
-Weight

*/

state_change(distribute, (OldP, [], [], N), (NewP, LP, RP, N)) :-
    append(LP, Temp, OldP),
    append(RP, NewP, Temp),
    length(LP, X),
    length(RP, X).

state_change(weigh, (OldP, LP, RP, N), (NewP, [], [], N1)) :-
    weigh(LP, RP, Result),
    in_pan_or_out(Result, OldP, NewP),
    N1 is N + 1.

in_pan_or_out([], OldP, OldP) :- !.
in_pan_or_out(L, _, L).

weigh(LP, _, LP):- 
    htto(H),
    member(H, LP),
    !.

weigh(_, RP, RP) :-
    htto(H),
    member(H, RP),
    !.

weigh(_, _, []).

htto(4). % Defines which ball is the heaviest

