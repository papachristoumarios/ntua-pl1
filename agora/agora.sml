

fun first (x, _) = x
fun second (_, y) = y

fun gcd (a : IntInf.int)  (b : IntInf.int) = if a = 0 then b else gcd (b mod a) a;
fun lcm (a,b) = (a div (gcd a b)) * b;
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
                scanner (i - 1) ((Int.toLarge d) :: acc)
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


(* total solution *)
fun agora fileName =
  let
    val pp = parse fileName;
    val N = first pp;
    val x = Int.toLarge 1;
    val a = x :: second pp @ [x];
    val left_lcm = prefixLcm a;
    val opt = hd left_lcm
    val left_lcm = rev left_lcm
    val right_lcm = tl (tl ( prefixLcm ( rev a ) ) );

    fun solution left right opt min_index i N =

      if (right = []) then (opt, min_index)
      else
        let
          val l = hd left;
          val r = hd right;
          val tmp = lcm (l,r);
          val result = if (tmp < opt) then (tmp, i) else (opt, min_index)
        in
          solution (tl left) (tl right) (first result) (second result) (i+1) N
        end

    val (opt, min_index) = solution left_lcm right_lcm opt ~1 1 N;
    val min_index = if min_index = ~1 then 0 else min_index
  in
    print ( (IntInf.toString opt) ^ " " ^ ( Int.toString min_index ) ^ "\n")
    (* (left_lcm, right_lcm, opt) *)
  end;
