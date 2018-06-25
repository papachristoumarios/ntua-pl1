taill([H | T], T).
head([H | T], H).

running_sum(X, [], X).

running_sum([],[H|T],P):-
    running_sum([H],T,P).

running_sum([H1|T1],[H2|T2],P):-
    K is H1 + H2,
    running_sum([K,H1|T1],T2,P).


running_sum([H|T],Z):-
    (
    var(Z) -> running_sum([],[H|T],K),
    reverse(K, Z);

    inverse_subsum(X, Z , []),
    head(Z, H),
    append([H], X, [H | T])
    ).


inverse_subsum(X, [S1, S2 | Ss], Acc) :-
  Y is S2 - S1,
  write(Y), nl,
  append(Acc, [Y], NAcc),
  write(NAcc), nl,
  (
  length([S1, S2 | Ss], 2) -> write('foo'), X = NAcc;
  inverse_subsum(X, [S2 | Ss], NAcc)
  ).

powerset([], []).
powerset([H|T], P) :- powerset(T,P).
powerset([H|T], [H|P]) :- powerset(T,P).

subsum(Sum, X, L) :-
  powerset(L, X),
  running_sum([], X, S),
  head(S, H),
  H is Sum.


subset_sum(Set, Sum, Subset) :-
  findall(X, subsum(Sum, X, Set), Subset).


weight([food(H, _) | T], S, Result) :-
  W is H + S,
  (
    T = [] -> Result = W;
    weight(T, W, Result)
  ).

calories([food(_, H) | T], S, Result) :-
  W is H + S,
  (
    T = [] -> Result = W;
    calories(T, W, Result)
  ).

calories(K, W) :- calories(K, 0, W).
weight(K, W) :- weight(K, 0, W).
weight([], 0).
calories([], 0).

knapsackDecide(L, C, Opt, Sol) :-
  powerset(Sol, L),
  weight(Sol, W),
  W =< C,
  calories(Sol, K),
  K >= Opt.

foldl([H | T], XInit, Result) :-
  f(H, XInit, W),
  (
    T = [] -> Result = W;
    foldl(T, W, Result)
  ).

% height of tree
height(t(_, L, R), H) :-
  height(L, HL),
  height(R, HR),
  max(HL, HR, HH),
  H is HH + 1.

height(nil, 0).

tree_height(T, H) :- once(height(T, H)).

find_depth(nil, _, 0).

find_depth([t(K, L, R) | T], X, D) :-
  X =:= K;
  D1 is D + 1,
  find_depth(L, X, D1);
  D2 is D + 1,
  find_depth(R, X, D2).

ordered([]).
ordered([X]).
ordered([X1, X2 | Xs]) :-
  X1 =< X2,
  ordered([X2 | Xs]).
