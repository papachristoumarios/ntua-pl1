(* Lab 2  *)

(* Tail recursive length *)
fun better_length l =
  let
    (* O(N) time and O(1) space *)
    fun better_length_aux [] n = n
      | better_length_aux (h::t) n = better_length_aux t (n + 1)
  in
    better_length_aux l 0
  end;

fun range x y =
  if x > y then []
  else x :: range (x+1) y

(* List of natural numbers a[] find the minimum natural number that does not exist in List *)
(* Tests *)

fun test_smallest f =
  f [2,4,6,9] = 0 andalso
  f [2,4,6,9,0] = 1


fun smallest1 l =
  let
    fun elem x [] = false
    | elem x (y :: ys) = (x = y) orelse elem x ys

    (* O(n |L|) complexity *)
    fun loop n l = if elem n l then loop (n+1) l else n;
  in
    loop 0 l
  end;

(* O(|L| log|L| + n) *)
fun smallest2 l  =
  let
    val sorted = ListMergeSort.sort (op >) l;
    fun loop n [] = n
        | loop n (x :: xs) = if n = x then loop (n+1) xs
                             else if n < x then n
                             else loop n xs
  in
    loop 0 sorted
  end

(* O(|L| solution *)
fun smallest3 l =
    let
      val n = length l
      val a = Array.array(n, false)
      fun loop1 [] = ()
        | loop1 (h::t) = (
          (if h < n then Array.update(a, h, true) else ());
          loop1 t
        )
      fun loop2 i =
          if i >= n then n
          else if Array.sub(a, i) then loop2 (i + 1)
          else i
    in
      loop1 l; loop2 0
    end
