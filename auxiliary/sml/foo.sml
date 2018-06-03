fun split k [] = ([], [])
  | split 0 l = ([], l)
  | split k (h :: t) =
    let
      val (l1, l2) = split (k - 1) t
    in
      (h :: l1, l2)
    end;

fun halve2 l =
  let
    val n = length l
  in
    split (n div 2) l
  end

(* unit testing *)
fun test_halve2 () =
  halve2 [] = ([], []) andalso
  halve2 [42] = ([42], []) andalso
  halve2 [17,4] = ([17], [4])
