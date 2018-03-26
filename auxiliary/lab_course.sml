fun forup n lim =
  if n > lim then ()
  else ( print (Int.toString (n*n)) ; forup (n + 1) lim )

fun forlst n acc =
  if n < 0 then acc
  else  forlst (n- 1) ( (n * n) :: acc )

(* implying argument *)
fun make_list n =
  let fun loop 0 result = result
    | loop i result = loop (i-1) (i :: result)
    in
      loop n []
    end

(* head recursion  *)
fun len [] = 0
  | len (h :: t) = 1 + len t

(* tail recursion *)
fun len2 l =
  let fun aux [] i = i
    | aux (h::t) i = aux t (i+1)
  in
    aux l 0
  end

(* pattern matching  *)
fun factorial 0 = 1
  | factorial n = n * factorial (n-1)

fun length [] = 0
  | length (h :: t) = 1 + length t

(* pattern matching with case *)

fun factorial_case  n =
  case n of 0 => 1
    | m => m * factorial_case (m - 1)

fun length_case l =
      case n of [] => 0
        | h :: t => 1 + length_case t

(* pattern matching with tuples *)
fun fst (x, _) = x;
fun snd (_, x) = x;

(* tuple indices TUPLES START FROM 1*)
val y = #3 (1,2,3);

(* int to 64-bit int *)
val z = Int64.fromInt 42
