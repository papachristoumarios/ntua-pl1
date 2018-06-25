% Set Cover Problem in Prolog
% Weber Book pg. 524 ex. 5

powerset([], []).
powerset([H | T], [H | R]) :- powerset(T, R).
powerset(X, [_ | R]) :- powerset(X, R).

coverDecision(Set, Subsets, Goal, Cover) :-
  powerset(Cover, Subsets),
  flatten(Cover, FlatCover),
  covers(FlatCover, Set),
  length(Cover, CoverLength),
  CoverLength =< Goal.

covers(_, []).

covers(FlatCover, [SetHead | SetTail ]) :-
  member(SetHead, FlatCover),
  covers(FlatCover, SetTail).

setCoverOptimization(Set, Subsets, Cover) :-
  setCoverOptimization(Set, Subsets, Cover, 1).

setCoverOptimization(Set, Subsets, Cover, Goal) :-
  length(Subsets, LenSub),
  Goal =< LenSub,
  (
    coverDecision(Set, Subsets, Goal, TmpCover) -> Cover = TmpCover, !;
    NewGoal is Goal + 1,
    setCoverOptimization(Set, Subsets, Cover, NewGoal)
  ).
