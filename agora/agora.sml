fun first (x, _) = x
fun second (_, y) = y

fun gcd (a : IntInf.int)  (b : IntInf.int) = if a = 0 then b else gcd (b mod a) a;
fun lcm (a,b) = (a * b) div (gcd a b)
fun min x y = if (x < y) then x else y;

(* read the input file *)
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
                scanner (i - 1) (d :: acc)
            end
    in
        (n, rev(scanner n []))
    end;

(* generate lcm prefix array *)
fun prefixLcm l =
  let
    fun prefixLcm' (lcms, []) = lcms
      | prefixLcm' ([], x::xs) = prefixLcm' ([x],xs)
      | prefixLcm' (y::ys, x::xs) = prefixLcm' ( (lcm (x, y) ) ::y::ys,xs);
  in
    prefixLcm' ([], l)
  end;


(* solution functino that computes the optimal solution from the two arrays *)
fun solution left_lcm right_lcm opt min_index i N =
  if (i > N) then (opt, min_index)
  else
    let
      val l = Array.sub (left_lcm, i - 1);
      val r = Array.sub (right_lcm, i + 1);
      val tmp = lcm (l,r);
      val result = if (tmp < opt) then (tmp, i) else (opt, min_index)
    in
      solution left_lcm right_lcm (first result) (second result) (i+1) N
    end

(* total solution *)
fun agora fileName =
  let
    val pp = parse fileName;
    val N = first pp;
    val a = List.map Int.toLarge (1 :: (second pp) @ [1]);
    val left_lcm = Array.fromList ( rev ( prefixLcm a ) );
    val right_lcm =Array.fromList ( prefixLcm ( rev a ) );
    val opt = Array.sub( left_lcm, N);
    val (opt, min_index) = solution left_lcm right_lcm opt ~1 1 N;
    val min_index = if min_index = ~1 then 0 else min_index
  in
    print ( (IntInf.toString opt) ^ " " ^ ( Int.toString min_index ) ^ "\n")
  end;
