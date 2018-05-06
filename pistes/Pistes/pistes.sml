fun max a b = if a >= b then a else b;

fun removeFirstOccurrence (item, list) =
    case list of
    [] => []
      | xs::ys => if item = xs then removeFirstOccurrence(~item,ys)
          else xs::removeFirstOccurrence(item,ys)

fun find item [] = false
  | find item (h::t) =
    if h = item then true
    else find item t

fun pistes fileName =
  let
    val k = Array.array(43, 0);
    val r = Array.array(43, 0);
    val s = Array.array(43, 0);
    val opt = 0;
    val keys = Array2.array(43, 10, 0);
    val rewarded = Array2.array(43, 10, 0);

    fun next_int input =
      Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    val stream = TextIO.openIn fileName;

    val N = (next_int stream) + 1;

    fun generate_list l i =
      if (i < 1) then l
      else generate_list (i :: l) (i - 1)


    val idx = Array.fromList ( 0 :: generate_list [] (N - 1) );


    fun swap i j =
      let
      val t = Array.sub(idx, j);
      val u = Array.sub(idx, i);
      in
        Array.update(idx, j, u);
        Array.update(idx, i, t)
      end





    fun asList i j arr total l =
        if i >= total then l
        else asList (i + 1) j arr total (Array2.sub(arr, i, j) :: l)

    fun holding j = asList 0 j rewarded (Array.sub(r, j)) [];

    fun canGo current hh =
      let
        val upper = Array.sub(k, current);
        fun canGoHelper i flag h =
          if (i >= upper) then (flag, h)
          else (
              let
                val q = Array2.sub(keys, current, i);
                val found = find q h;
                val hnew = if found = true then removeFirstOccurrence (q, h) else h;
              in
                print (Int.toString q);
                canGoHelper (i + 1) found hnew
              end
            )
      in
        canGoHelper 0 true hh
      end




    fun readInts f j arr total input =
      if f >= total then ()
      else (
        Array2.update(arr, f, j, next_int input);
        readInts (f + 1) j arr total input
      )
    fun parsePistes i input =
        if (i < N) then (
          let

            val kk = next_int input;
            val rr = next_int input;
            val ss = next_int input;
          in
            readInts 0 i keys kk input;
            readInts 0 i rewarded rr input;
            Array.update(k, i, kk);
            Array.update(s, i, ss);
            Array.update(r, i, rr);

            parsePistes (i + 1) input
          end
        )
        else ()

    val prs = parsePistes 0 stream;

  in
    canGo 2 (holding 0)
  end
