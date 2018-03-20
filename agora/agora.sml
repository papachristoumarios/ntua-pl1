fun first (x, _) = x
fun second (_, y) = y

fun gcd a b = if a = 0 then b else gcd (b mod a) a;
fun lcm a b = (a * b) div (gcd a b)

fun constructLevel [] = []
  | constructLevel [a] = [a]
  | constructLevel [a, b] = [lcm a b]
  | constructLevel (a :: b :: t) = (lcm a b) :: (constructLevel t)

fun constructSegmentList [] = [[]]
  | constructSegmentList [a] = [[a]]
  | constructSegmentList [a, b] = [[lcm a b]]
  | constructSegmentList l =
    let
      val tmp = constructLevel l;
    in
      tmp :: [(constructLevel tmp)]
    end;

fun mergeSegmentList [[]] = []
   | mergeSegmentList [[a]] = [a]
   | mergeSegmentList (h :: t) = (mergeSegmentList t) @ h

fun segmentTree [] = Array.fromList []
  | segmentTree [a] = Array.fromList [a]
  | segmentTree l =
  let
    val ll = mergeSegmentList (constructSegmentList l);
  in
    Array.fromList (0 :: (ll @ l))
  end;


fun query tree node start eend l r =
  if (eend < l orelse start > r) then 1
  else if (l <= start andalso r >= eend) then Array.sub(tree, node)
  else
    let
      val mid = (start + eend) div 2;
      val x = 2 * node;
      val y = x + 1;
      val z = mid + 1;
    in
      lcm ( query tree x start mid l r ) ( query tree y z eend l r )
    end




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

fun getTmp s N i =
  if ( i = 0 ) then query s 1 1 (N - 1) 1 (N - 1)
  else if ( i = N - 1) then query s 1 1 (N - 1) 0 (N - 2)
  else
    let
      val ll = query s 1 1 (N - 1) 0 (i - 1);
      val rr = query s 1 1 (N - 1) (i + 1) (N - 1);
    in
      lcm ll rr
    end

fun forsol tree N n minimum min_index =
  if (n < 0) then (minimum, min_index)
  else
    let
      val tmp = getTmp tree N n;
      val qq = n - 1;
      val (a, b) =  if (tmp < minimum) then forsol tree N qq tmp n
      else forsol tree N qq minimum min_index;
    in
      (a, b)
    end

fun agora fileName =
let
  val pp = parse fileName;
  val N = first pp;
  val NN = N - 1;
  val l = second pp;
  val s = segmentTree l;
  val x0 = query s 1 NN 0 NN;
in
  forsol s N NN x0 ~1
end;


val l = [1,2,3,4];
val NN = length l;
val s = segmentTree l;
