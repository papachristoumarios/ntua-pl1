% valid moves
valid(X/Y, N) :-
  X >= 1, X =< N,
  Y >= 1, Y =< N.

jump(N, X/Y, U/V) :-
  U is X + 1, V is Y + 3, V < N, U < N;
  Y > 4, U is X + 1, V is Y - 3, V > 1;
  X > 1, U is X - 1, V is Y + 3, V < N,
  X > 1, U is X - 1, V is Y - 3, V > 1;
  U is Y + 1, V is X + 3, V < N, U < N;
  X > 4, U is Y + 1, V is X - 3, V > 1;
  Y > 1, U is Y - 1, V is X + 3, V < N;
  Y > 1, U is Y - 1, V is X - 3, V > 1.

knightpath(_, []).
knightpath(_, [X/Y]) :- X > 1, Y < N, X < N, Y > 1.

knightpath(N, [X/Y, U/V | T]) :-
  valid(X/Y, N),
  jump(N, X/Y, U/V),
  \+ member(X/Y, [U/V | T]),
  knightpath(N, [U/V | T]).

getlast([X], X).
getlast([H | T], X) :-
  getlast(T, X).

solve(P) :-
  knightpath(8, [1/2 | T]),
  P = [ 2/1 | T],
  P = [ 2/1, _, _, _, 5/4],
  getlast(P, 8/_).
