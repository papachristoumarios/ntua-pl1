% returns a list of nodes at the given level of the tree
level( [], _, [] ).
level( [Element, _, _], 0, [Element] ) :- !.
level( [_, Left, Right], N, Result ) :-
    NewN is N - 1,
    level( Left, NewN, LeftResult ),
    level( Right, NewN, RightResult ),
    append( LeftResult, RightResult, Result ).

% does a bfs, returning a list of lists, where each inner list
% is the nodes at a given level
bfs( Tree, Result ) :-
    level( Tree, 0, FirstLevel ), !,
    bfs( Tree, 1, FirstLevel, [], BFSReverse ),
    reverse( BFSReverse, Result ).
bfs( _, _, [], Accum, Accum ) :- !.
bfs( Tree, Num, LastLevel, Accum, Result ) :-
    level( Tree, Num, CurrentLevel ), !,
    NewNum is Num + 1,
    bfs( Tree, NewNum, CurrentLevel, [LastLevel|Accum], Result ).
