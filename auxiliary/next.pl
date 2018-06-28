listof(0, _, []).

listof(N, X, [H | T]) :-
  listof(N1, X, T),
  H = X,
  N is N1 + 1.

streak_of([], _, _, 0).

streak_of([H | T], X, Acc, Res) :-
  (
    H =\= X -> Res = Acc;
    Acc1 is Acc + 1,
    streak_of(T, X, Acc1, Res)
  ).

next([], []).
next([X], [1, X]).

next(X, [ Y1, Y2 | T] ) :-
  var(X),
  once(listof(Y1, Y2, Z)),
  append(Z, U, X),
  next(U, T).

next(X, [ Y1, Y2 | T] ) :-
  nonvar(X),
  X = [H | P],
  \+ P = [],
  streak_of(X, H, 0, Y1),
  Y2 = H,
  once(listof(Y1, Y2, Z)),
  append(Z, U, X),
  next(P, T).

% Do this instead of drugs
precondition(Clause):-
  Clause =.. [_|ARGS],
  ( maplist(var,ARGS) -> true; Clause ).

next2( [], [] ).

next2( [X], [1, X] ) :- !.

next2( [H|Q], [1, H, HR,NR |QR] ) :-
   next2( Q, [NR, HR|QR] ),
   H \= HR,
   !.

next2( [H|Q], [NR,H|QR] ) :-
   precondition( succ(N,NR) ),
   next2( Q, [N,H|QR] ),
   succ(N,NR).
