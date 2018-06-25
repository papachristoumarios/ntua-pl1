max(A, B, M) :-
  C is A - B,
  (
    C > 0 -> M = A;
    M = B
  ).

height(nil, 0).

height([L, R], H) :-
  height(L, HL),
  height(R, HR),
  max(HL, HR, U),
  H is U + 1.

inorder(t(K,L,R), List):-
  inorder(L,LL),
  inorder(R, LR),
  append(LL, [K|LR],List).

inorder(nil, []).

preorder(t(K, L, R), List) :-
  preorder(L, LL),
  preorder(L, RR),
  append([K | LL], RR, List).

preorder(nil, []).

postorder(t(K, L, R), List) :-
  postorder(L, LL),
  postorder(R, RR),
  append(LL, RR, Tmp),
  append(Tmp, [K], List).

postorder(nil, []).
