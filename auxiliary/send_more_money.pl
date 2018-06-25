send_more([X | Xs], [Y | Ys], [Z | Zs]) :-
  triplette(Z, Y, X),
  send_more(Xs, Ys, Zs).

send_more([], [], []).

% find X, Y, Z in [0, 9] s.t. X = Y + Z
valid_number(1).
valid_number(2).
valid_number(3).
valid_number(4).
valid_number(5).
valid_number(6).
valid_number(7).
valid_number(8).
valid_number(9).

triplette(X, Y, Z) :-
  (
    var(X) ->
      valid_number(Y),
      valid_number(Z),
      X is Y + Z,
      X =< 9, X >= 0;
    var(Y) ->
      valid_number(X),
      valid_number(Z),
      Y is X - Z,
      Y >= 0, Y =< 9;
    var(Z) ->
      valid_number(X),
      valid_number(Y),
      Z is X - Y,
      Y >= 0, Y =< 9;
    nonvar(X), nonvar(Y), nonvar(Z) -> X is Y + Z
  ).
