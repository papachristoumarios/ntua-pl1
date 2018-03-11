datatype btree = Empty | Leaf | Node of btree * btree;

fun max x y = if x >= y then x else y;

fun cntleaves Empty = 0
    | cntleaves Leaf = 1
    | cntleaves (Node (left, right)) = ( cntleaves left ) + ( cntleaves right );

fun height Empty = 0
    | height Leaf = 1
    | height (Node (left, right)) = 1 + max ( height left ) ( height right );


val tree = Node (Node (Leaf, Leaf), Leaf);
