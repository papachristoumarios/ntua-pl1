fun first (x, _) = x
fun second (_, y) = y

fun gcd a b = if a = 0 then b else gcd (b mod a) a;
fun lcm a b = (a * b) div (gcd a b)
fun min x y = if (x < y) then x else y;
val MAX = 1000000;

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

fun build tree arr node start eend =
  if (start = eend) then Array.update(tree, node, Array.sub ( arr, start ))
  else
    let
      val mid = ( start + eend ) div 2;
      val xx = 2 * node;
    in
      build tree arr xx start mid;
      build tree arr ( xx+1 ) ( mid+1 ) eend;
      Array.update(tree, node, lcm (Array.sub(tree, xx)) (Array.sub(tree, xx + 1)))
    end

fun query tree node start eend l r =
    if (eend < l orelse start > r) then 1
    else if (l <= start andalso r >= eend) then Array.sub(tree, node)
    else
      let
        val mid = (start + eend) div 2;
        val xx = 2 * node;
        val (left_lcm : int) = query tree xx start mid l r;
        val (right_lcm : int) = query tree ( xx+1 ) ( mid+1 ) eend l r;
      in
        lcm left_lcm right_lcm
      end

fun solution tree i N opt min_index =
  if i >= N then (opt, min_index + 1)
  else
    let
      val tmp = if i = 0 then query tree 1 0 (N-1) 0 (N-1)
                else if i = (N - 1) then query tree 1 0 (N-1) 0 (N-2)
                else lcm (query tree 1 0 (N-1) 0 (i-1)) (query tree 1 0 (N-1) (i+1) (N-1))
      val x = if(tmp < opt) then i else min_index
    in
      solution tree (i + 1) N (min opt tmp) x
    end

fun agora fileName =
  let
    val pp = parse fileName;
    val N = first pp;
    val arr = Array.fromList (second pp);
    val tree = Array.array( 4 * MAX, 0 );
    val bbuild = build tree arr 1 0 (N-1);
    val opt = query tree 1 0 (N-1) 0 (N-1);
    val (opt, min_index) = solution tree 0 N opt ~1;
  in
    print ( (Int.toString opt) ^ " " ^ ( Int.toString min_index ) ^ "\n" )
  end;
