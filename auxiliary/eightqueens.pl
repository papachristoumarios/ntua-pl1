nocheck(_, []).
nocheck(X/Y, [U/V | Rest]) :-
  X =\= U,
  Y =\= V,
  abs(U - X) =\= abs(Y - V),
  nocheck(X/Y, Rest).

legal([]).

legal([X/Y | T]) :-
  legal(T),
  between(1, 8, X),
  between(1, 8, Y),
  nocheck(X/Y, T).
  
eightqueens(X) :-
  X = [1/_, 2/_, 3/_, 4/_, 5/_, 6/_, 7/_, 8/_ ],
  legal(X).
