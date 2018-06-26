last_but_one([A, B], A).
last_but_one([H | T], X) :- last_but_one(T, X).

nth_element([H | T], N, X) :-
  (
    N = 0 -> X = H;
    N1 is N - 1,
    nth_element(T, N1, X)

  ).

reverse2(X, Y) :- reverse2(X, Y, []).

reverse2([], Y, Y) :- !.

reverse2([H|T], Y, A) :- reverse2(T, Y ,[H | A]).


palindrome(X, Y) :-
  reverse2(X, Q),
  (
    Q = X -> Y = true, !;
    Y = false
  ).

duplicate(X, Y) :- duplicate(X, [], Y).
duplicate([X|Xs], Y, Z) :-
  append(Y, [X, X], Q),
  (
    Xs = [] -> Z = Q;
    duplicate(Xs, Q, Z)
  ).

adder2([X1, X2 | X3],[Y1, Y2 | Y3],Z):- W is X1 + Y1, U is X2 + Y2, Z = [W, U].
