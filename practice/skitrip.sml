val INT_MIN = ~1073741824;

(* comparator *)
fun first (x, _) = x
fun second (_, y) = y
fun min x y = if x < y then x else y;
fun max x y = if x > y then x else y;

fun cmp x y = if second x = second y then first x < first y else second x < second y;

fun halve nil = (nil, nil)
  | halve [a] = ([a], nil)
  | halve (a::b::cs) =
  let
    val (x, y) = halve cs
  in
    (a::x, b::y)
  end;

fun merge (nil, ys) = ys
  | merge (xs, nil) = xs
  | merge (x::xs, y::ys) =
    if cmp x y then x :: merge (xs, y::ys)
    else y :: merge (x::xs, ys);


fun mergeSort nil = nil
   | mergeSort [a] = [a]
   | mergeSort theList =
   let
   val (x, y) = halve theList
   in
    merge (mergeSort x, mergeSort y)
   end;

fun forsol [] _ _ opt = opt
    | forsol (x :: xs) n k opt =
    let
      val dist = (first x) - k
      val oppt = max opt dist
      val kk = min k (first x)
    in
      if n < 0 then opt
      else forsol xs (n - 1) kk oppt
    end;

fun forsolcur (h :: t) N = forsol (h :: t) N (first h) INT_MIN

fun parse file =
    let
      fun next_int input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val stream = TextIO.openIn file
        val n = next_int stream
	      val _ = TextIO.inputLine stream
	      fun scanner 0 acc = acc
          | scanner i acc =
            let
                val d = next_int stream
            in
                scanner (i - 1) ((d, n - i) :: acc)
            end
    in
        (n, rev(scanner n []))
    end;

fun skitrip fileName =
    let
      val pp = parse fileName;
      val N = first pp
      val l = mergeSort (second pp)
    in
      forsolcur l N
    end;
