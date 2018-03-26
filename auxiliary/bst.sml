datatype tree = Empty | Node of tree * int * tree;
exception EmptyTree;

fun println s = print (s ^ "\n")
fun max x y = if x >= y then x else y;
val test = Node(Node(Empty, 1, Empty), 2, Node(Node(Empty, 3, Empty), 4, Node(Empty, 5, Empty)))

fun inorder ( t : tree ) =
  case t of
    Empty => []
    | Node(l, k, r) => (inorder l) @ [k] @ (inorder r);

fun postorder ( t : tree ) =
  case t of
      Empty => []
      | Node(l, k, r) => (postorder l) @ (postorder r) @ [k];

fun preorder ( t : tree ) =
  case t of
      Empty => []
      | Node (l, k, r) => [k] @ (preorder l) @ (preorder r);

fun height ( t : tree ) =
  case t of
    Empty => 0
    | Node (Empty, k, Empty) => 1
    | Node (l, k, r) => let
                          val hl = 1 + (height l);
                          val hr = 1 + (height r);
                        in
                          max hl hr
                        end

fun cntnodes ( t : tree ) =
  case t of
    Empty => 0
    | Node (l, k, r) => let
                          val nl = cntnodes l;
                          val nr = cntnodes r;
                        in
                          1 + nl + nr
                        end


fun query Empty _  = false
  | query (Node(l, d, r))  x =
     case (x = d, x < d) of
        (true, _) => true
      | (_, true) => query l  x
      | (_, false) => query r  x


fun minimum ( t : tree ) =
  case t of
    Empty => ~1
    | Node ( Empty, k, Empty ) => k
    | Node ( l, k, r) => minimum l;

fun maximum ( t : tree ) =
  case t of
    Empty => ~1
    | Node ( Empty, k, Empty ) => k
    | Node ( l, k, r) => maximum r;


fun sum ( t : tree ) =
  case t of
    Empty => 0
    | Node (Empty, k, Empty) => k
    | Node (l, k, r) => let
                          val sx = sum l;
                          val sy = sum r;
                        in
                          sx + sy + k
                        end

fun border ( t : tree ) =
  case t of
    Empty => []
    | Node (Empty, k, Empty) => [k]
    | Node (l, k, r) => let
                          val bl = border l;
                          val br = border r;
                        in
                          bl @ br
                        end

fun insert Empty x = Node (Empty, x, Empty)
  | insert (Node (l, k, r)) x =
      if x <= k then Node (insert l x, k, r)
      else Node(l, k, insert r x);


fun makeBST [] = Empty
    | makeBST (x::xs)  =
        let
            val tree = Empty
        in
            insert (makeBST xs) x
        end;
