valid(1).
valid(2).
valid(3).
valid(4).
valid(5).
valid(6).
valid(7).
valid(8).
valid(9).

triplette(X, Y, Z, S) :-
  valid(X),
  valid(Y),
  valid(Z),
  S is X + Y + Z.

magic_square([[V1, V2, V3], [V4, V5, V6], [V7, V8, V9]]) :-
  permutation([V1, V2, V3, V4, V5, V6, V7, V8, V9], [1, 2, 3, 4, 5, 6, 7, 8, 9]),
  triplette(V1, V2, V3, S),
  triplette(V3, V4, V5, S),
  triplette(V6, V7, V8, S).
  triplette(V1, V4, V7, S),
  triplette(V2, V5, V8, S),
  triplette(V3, V6, V9, S),
  triplette(V1, V5, V9, S),
  triplette(V7, V5, V3, S).
