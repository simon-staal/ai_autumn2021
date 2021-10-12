/*
Sample Queries: copy and paste

tower( 1, table ). 
tower( 2, table ). 
tower( 3, table ). 
tower( 4, table ). 
towerIs( 1, table, [], X ).
towerIs( 2, table, [], X ).
towerIs( 3, table, [], X ).
*/

/*
** Initial description of the micro-world arrangement
** Facts
*/
on( green, red ).	%green bock on red block
on( yellow, green ).	%etc
on( red, table ).
on( blue, table ).

/*
** for testing the extension
*/
on( orange, table ).
on( magenta, vermillion ).
on( vermillion, pink ).
on( pink, table ).

/*
** above vertically in a tower
** can be extended so above blocks in other towers?
*/
above( X, Y ) :-	%X is above Y, if
	on( X , Y ).	%X is on Y

above( X, Y ) :-	%X is above Y, if
	on( X, Z ),	%X is on some other block Z, and
	above( Z, Y ).	%Z is above Y
/*
** tower of height N is provably true
** note that for towers based on the table, we have to query
** ?- tower( N, table).
*/
tower( 1, B ) :-	%there is a tower of height 1 above B, if
	!,		%cut, because can't have a tower less than one
	on( A, B ),	%some block is on B
	\+ on( _, A ).	%there is nothing on A

tower( N1, B ) :-	%there is a tower of height N1 above B, if
	on( A, B ),	%some block A is on B, and
	N is N1 - 1,
	tower( N, A ).	%there is a tower of height N above A

/*
** tower of height N is provably true, and a tower that makes it true is...
** note that SoFar is used as an "accumulator"
** so that in the initial query, SoFar is initialised to the empty list
*/
towerIs( 1, B, SoFar, [A|SoFar] ) :-
	!,
	on( A, B ),
	\+ on( _, A ).

towerIs( N1, B, SoFar, Result ) :-
	on( A, B ),
	N is N1 - 1,
	towerIs( N, A, [A|SoFar], Result ).

/*
** The extension:
** gather_towers gets all the blocks of height 1, 2 and 3 into one list
** guess (from the lectures) gets all the blocks on the table
** then to find all the blocks on the table, query:
** ?- gather_towers( Towers ), guess( Towers, OnTable ).
*/
gather_towers( Towers ) :-
	findall( T, (forall( 1, 3, N ), 
		     towerIs( N, table, [], T)), Towers ).

guess( [], [] ).		%base case
guess( [H|T1], [B|T2] ) :-
	last( H, B ),		%process head of list
	guess( T1, T2 ).	%recurse on tail if list

/*
** helper clauses:
** last returns the last element in a list
** forall returns all values between I and N inclusive
*/
last( [H], H ).			%single element list is last
last( [_|T], Last ) :-		%last of a list with head and tail is...
	last( T, Last ).	%...the last element of the tail

forall( I, N, _ ) :-
	I > N, !, fail.		%fail if I is greater than N
forall( I, _, I ).		% return I (I must be =< N)
forall( I, N, NextI ) :-
	I1 is I + 1, 		%increment I, and ...
	forall( I1, N, NextI ).	%...try again
