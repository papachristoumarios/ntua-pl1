fun first (x, _) = x;
fun second (_, x) = x;
fun min (x, y) = if x < y then x else y;

fun bfs grid q depth N M =
  let
    val INT_MAX = Option.valOf (Int.maxInt);
    val stars = Queue.mkQueue(): ( int * int ) Queue.queue;

    (* valid blocks not outside the grid *)
    fun isValid i j =
      if (i >= 0 andalso i <= N - 1 andalso j >= 0 andalso j <= M - 1) then [(i, j)]
      else [];

    (* get Neighbors in grid that are not X *)
    fun getNeighbors u v =
      let
        val inside = (isValid (u-1) v) @
                      (isValid (u+1) v) @
                      (isValid u (v+1)) @
                      (isValid u (v-1));
        fun notObstacle (a,b) = Array2.sub(grid, a, b) <> "X" andalso Array2.sub(grid, a, b) <> "\n";
      in
        List.filter notObstacle inside
      end

    fun kaboom u v i j =
      (Array2.sub(grid, u, v) = "+" andalso Array2.sub(grid, i, j) = "-") orelse
      (Array2.sub(grid, u, v) = "-" andalso Array2.sub(grid, i, j) = "+");


    fun explore p opt qq =
      let
        val u = first p;
        val v = second p;
        val i = first qq;
        val j = second qq;
        fun get_opt u v i j =
          if (Array2.sub(grid, i, j) = Array2.sub(grid, u, v)) then opt
          else if (Array2.sub(grid, i, j) = ".") then (
            Array2.update(depth, i, j, (Array2.sub(depth, u, v) + 1));
            Array2.update(grid, i, j, Array2.sub(grid, u, v));
            Queue.enqueue(q, (i, j));
            opt
            )
          else if (kaboom u v i j) then (
            (* print "kaboom\n"; *)
            Queue.enqueue(stars, (i, j));
            min (opt, Array2.sub(depth, u, v) + 1)
            )
          else opt

      in
        get_opt u v i j
      end

    (* bfs helper *)
    fun bfs_aux opt =
      if Queue.isEmpty q then opt
      else (
        let
            val p = Queue.dequeue q;
            val neigh = getNeighbors (first p) (second p);
            (* opt results *)
            val new_opt = if Array2.sub(depth, first p, second p) = opt then opt
                          else foldl min opt (List.map (explore p opt) neigh);

        in
            (* print (Int.toString (first p) ^ " " ^ Int.toString (second p) ^ "\n"); *)
            bfs_aux new_opt
        end
      )

  in
    (bfs_aux INT_MAX, stars)
  end


fun doomsday fileName =
  let
    val INT_MAX = Option.valOf (Int.maxInt);


    (* parse file *)
    val instream = TextIO.openIn fileName;
    fun toStr c = if c = #"\n" then "\n" else (Char.toString c);
    fun toChar s = map toStr (String.explode (Option.valOf s))
    fun parseIns l x =
      if x = NONE then l
      else parseIns (x :: l) (TextIO.inputLine instream);

    (* list and dimensions *)
    val l = List.map toChar (parseIns [] (TextIO.inputLine instream));
    val N = length l;
    val M = (length (hd l) - 1);
    (* grid and depth *)
    val grid = Array2.fromList l;
    val depth = Array2.array(N, M, ~1);

    val q = Queue.mkQueue(): ( int * int ) Queue.queue;

    fun isSpecial c = (c = "+" orelse c = "-")
    fun init z = (Queue.enqueue(q, z); Array2.update(depth, first z, second z, 0); true);

    fun findSpecialRow res [] _ j = res
      | findSpecialRow res (x :: xs) i j =
        if isSpecial x then findSpecialRow ((j, i)::res) xs (i + 1) j
        else findSpecialRow res xs (i + 1) j;

    fun findSpecial ll j M =
      if (j >= M orelse ll = []) then ()
      else (
        let
          val x = hd ll;
          val xs = tl ll;
          val rowres = findSpecialRow [] x 0 j;
        in
          List.map init rowres;
          findSpecial xs (j + 1) M
        end
      )

    val thingsAdded = findSpecial l 0 M;
    val result = bfs grid q depth N M;
    val stars = second result;
    val safe = Queue.isEmpty stars;

    fun printGrid i N M =
      if (i >= N) then ()
      else
        (
          let
            fun printRow j M =
              if (j >= M + 1) then ()
              else (print (Array2.sub(grid, i, j)); printRow (j+1) M)
          in
            printRow 0 M;
            printGrid (i + 1) N M
          end
        )

    fun printResult r =
      if r <> INT_MAX then (
        print ((Int.toString r) ^ "\n");
        printGrid 0 N M
      )
      else
        (
          print "the world is saved\n";
          printGrid 0 N M
        )

    fun fillStars x =
      if Queue.isEmpty stars then ()
      else (
        let
          val p = Queue.dequeue stars;
        in
          Array2.update(grid, first p, second p, "*");
          fillStars x
        end
        )

  in
    fillStars nil;
    printResult (first result)
  end
