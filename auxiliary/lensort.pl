lenpair(L, Q) :-
  Q = N-L,
  length(L, N).

list_len_pair([], []).
list_len_pair([X | Xs], [Y | Ys]) :-
  lenpair(X, Y),
  list_len_pair(Xs, Ys).

lensort(InList, OutList) :-
  list_len_pair(InList, AuxList),
  keysort(AuxList, R),
  list_len_pair(OutList, R).

hasLength(X, N, Res) :-
   length(X, R),
   (
      R =:= N -> Res = 1;
      Res = 0
   ).

  countSameLength(0, [], _).
  countSameLength(Count, [Head|Tail], N) :-
    countSameLength(TailCount, Tail, N),
    hasLength(Head, N, Q),
    Count is TailCount + Q.

lenfreqpair(L, Q, X) :-
  Q = S-L,
  length(L, N),
  countSameLength(S, X, N).

list_lenfreq_pair([], [], _).
list_lenfreq_pair([X | Xs], [Y | Ys], L) :-
  lenfreqpair(X, Y, L),
  list_lenfreq_pair(Xs, Ys, L).

value(X-Y, Y).
getvalues([], []).
getvalues([X | Xs], [Y | Ys]) :-
  value(X, Y),
  getvalues(Xs, Ys).

lenfreqsort(L, S) :-
  list_lenfreq_pair(L, X, L),
  keysort(X, Out),
  getvalues(Out, S).
