% Exercise 2.1
analyse_list(List) :- 
    List = [Head|Tail],
    write('This is the head of your list: '),
    write(Head), nl,
    write('This is the tail of your list: '),
    write(Tail), nl.

analyse_list([]) :-
    write('This is an empty list.'), nl.
    
% Exercise 2.2
membership(Elem, List) :-
    List = [Elem|_].

membership(Elem, List) :-
    List = [_|Tail],
    membership(Elem, Tail).

% Exercise 2.3
remove_duplicates([Elem|Tail], Unique) :-
    membership(Elem, Tail), % Element is repeated
    remove_duplicates(Tail, Unique), % Discard it
    !. % No alternate solutions allows >:(

remove_duplicates([Elem|Tail], Unique) :- % Element is unique
    /* This is an alternate solution, using cuts (!) is another option to solve
    \+ membership(Elem, Tail), % This is required so only the single correct solution is given
    */
    Unique = [Elem|Tail2],
    remove_duplicates(Tail, Tail2),
    !. % No alternate solutions allows >:(

remove_duplicates([], []).

% Exercise 2.4
reverse_list([], []). % If both lists are empty we are done

/* A reversed list = The reversed tail of the original list + the head appended at the back of the list */
reverse_list([Elem|Tail], Reverse) :-
    reverse_list(Tail, RevTail),
    append(RevTail, [Elem], Reverse).

% Exercise 2.5
whoami([]).

whoami([_, _ | Rest]) :-
    whoami(Rest).

/* For whoami to succeed, the list must have an even number of elements */

% Exercise 2.6
last1([Last], Last). % If there is a singleton element it's the last one

last1([_|Tail], Elem) :- % Else recurse
    last1(Tail, Elem).

last2(List, Elem) :- % This shit got me fucked up, basically use append in reverse to get a singleton list as the second list
    append(_, [Elem], List).

% Exercise 2.7
replace([], _, _, []).

replace([Old|Tail], Old, New, [New|Res]) :-
    replace(Tail, Old, New, Res).

replace([Head|Tail], Old, New, [Head|Res]) :-
    Head \= Old,
    replace(Tail, Old, New, Res).

% Exercise 2.8
% This one is a doozy, found soln on stackoverflow and tried to understand it

% generate takes a single element and an existing set, and returns a set containing all the combinations

% Base case, if Y is a set containing a single element, the only combination that can be made is [X|Y|[]]. This is returned as a list of lists since we will append it to our existing powerset
generate(X, [Y], [[X| Y]]).

generate(X, S, P) :- 
        S = [H| T], % Splits existing set into first element H (a list) and T (list of lists)
        append([X], H, Temp), % Temp = H+X (X appended to H), the new element we are adding
        generate(X, T, Rest), % We generate recursively with the tail of S, since we call power on a set every element in the input list is unique, so X will have a unique combination with every element of S, and so we need to append X with every element of the existing powerset S.
        append([Temp], Rest, P), % Append the new term to the rest of the terms generated, and store that in P
        !. % We don't want backtracking from here

power([], [[]]). % Base casae for power set

power(Set, P) :-
        Set = [H| T], % Split our set into Head and Tail
        power(T, PsT), % Find power set for the Tail
        generate(H, PsT, Ps), % Generate new terms in Ps resulting from adding H to our existing power set
        append(Ps, PsT, P), % Combine terms to form our overall powerset
        !. % No backtracking!

