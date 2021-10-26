% Exercise 3.1
% Write a Prolog predicate distance/3 to calculate the distance between 2 points in 2-dimensional space. Points are given as a pair of coordinates
distance((X1, Y1), (X2, Y2), D) :-
    D is sqrt((X2 - X1) ** 2 + (Y2 - Y1) ** 2).

% Exercise 3.2
% Write a program to print out a square of n x n given characters on the screen. The first argument should be a +ve integer, the second argument the character to be printed.
square(N, C) :-
    printLine(N, C, N).

printLine(N, C, I) :-
    I > 0,
    printChar(N, C, N),
    write('\n'),
    I_n is I - 1,
    printLine(N, C, I_n).

printLine(_, _, 0).

printChar(N, C, I) :-
    I > 0,
    write(C),
    I_n is I - 1,
    printChar(N, C, I_n).

printChar(_, _, 0).

% Exercise 3.3
% Write a program fibonacci/2 to ocmpute the nth fibonacci number
fibonacci(0, 1) :- !.
fibonacci(1, 1) :- !.

fibonacci(X, Res) :-
    X >= 2,
    X_ is X - 1,
    X__ is X - 2,
    fibonacci(X_, Res_),
    fibonacci(X__, Res__),
    Res is Res_ + Res__.

% Exercise 3.4
% Write a predicate element_at/3 that, given a list and a natrual number n, will return the nth element of that list
element_at([H|_], 1, H) :- !.

element_at([_|T], N, Res) :-
    N1 is N - 1,
    element_at(T, N1, Res).

% Exercise 3.5
% Write a predicate mean/2 to compute the arithmetic mean of a list of given numbers

mean(L, X) :-
    sum(L, S),
    n_of_elem(L, N),
    X is S / N.

sum([], 0).
sum([H|T], Res) :-
    sum(T, Res_),
    Res is Res_ + H.

n_of_elem([], 0).
n_of_elem([_|T], Res) :-
    n_of_elem(T, Res_),
    Res is Res_ + 1.

% Exercise 3.6
% Write a predicate range/3 to generate all integers between a given lower and upper bound

range(L, U, []) :-
    U < L,
    !. % Base case

range(L, U, [L|T]) :-
    L =< U,
    L_n is L + 1,
    range(L_n, U, T).

% Exercise 3.7
% Polynomials can be represented as lists of pairs of coefficients and exponents. Write a predicate poly_sum/3 for adding 2 polynomials using that representation. Try to find a solution that is independent of the ordering of the pairs inside the 2 given lists.

poly_sum([], L, L) :- !. 
poly_sum(L, [], L) :- !. % We try to empty list 1 first, but if L1 contains all the exponents of L2 and more we need this to terminate successfully

% If the exponents of the heads of the lists match, sum their coefficients and add them to result
poly_sum([(C1, E)|T1], [(C2, E)|T2], [(C3, E)|Res]) :-
    C3 is C1 + C2,
    poly_sum(T1, T2, Res),
    !.

% If the exponents of the 2 heads do not match, we search L2 for a matching exponent
poly_sum([(C1, E)|T1], [(C2, E2)|T2], Res) :-
    E =\= E2,
    poly_sum_help([(C1, E)|T1], T2, Res, [(C2, E2)]).

% If the entire L2 has been searched and there is no exponent match, we add the term to result and continue our sum
poly_sum_help([(C, E)|T], [], [(C, E)|Res], L2) :-
    poly_sum(T, L2, Res),
    !.

% As we search through the list, we store elements of L2 that don't match E into L2
poly_sum_help([(C1, E)|T1], [(C2, E2)|T2], Res, L2) :-
    E =\= E2,
    poly_sum_help([(C1, E)|T1], T2, Res, [(C2, E2)|L2]),
    !.

% If we find a matching exponent, we concatenate our 2 segments of L2 together and continue our sum
poly_sum_help([(C1, E)|T1], [(C2, E)|T2], [(C3, E)|Res], L2) :-
    C3 is C1 + C2,
    append(L2, T2, L),
    poly_sum(T1, L, Res),
    !.

/* Simpler solution using select/3 predicate?
poly_sum([(C1, E)|T1], L2, [(C3, E)|Res]) :-
    select((C2, E), L2, L2_),
    C3 is C1 + C2,
    poly_sum(T1, L2_, Res).

poly_sum([(C1, E)|T1], L2, [(C1, E)|Res]) :-
    \+ select((_, E), L2, _),
    poly_sum(T1, L2, Res).
*/