fun first (x, _) = x;
fun second (_, x) = x;
fun min (x, y) = if x < y then x else y;

(* fun bfs grid q depth N M =
  let
    val INT_MAX = 2147483647;
    (* valid blocks not outside the grid *)
    fun isValid i j =
      if (i > 0 andalso i < N andalso j > 0 andalso j < M) then []
      else [(i,j)];

    (* get Neighbors in grid that are not X *)
    fun getNeighbors u v =
      let
        val inside = (isValid (u-1) v) @
                      (isValid (u+1) v) @
                      (isValid u (v+1)) @
                      (isValid u (v-1));
        fun notObstacle (a,b) = Array2.sub(grid, a, b) <> #"X";
      in
        List.filter notObstacle inside
      end

    fun explore p opt qq =
      let
        val u = first p;
        val v = second p;
        val i = first qq;
        val j = second qq;
        fun get_opt u v i j =
          if (opt < INT_MAX andalso Array2.sub(depth, i, j) > opt) then opt;
          else if (kaboom u v i j) then (Array2.update(grid, i, j, #"*"); (Array2.sub(depth, u, v) + 1))
          else (
            Array2.update(depth, i, j, Array2.sub(depth, u, v) + 1);
            Array2.update(grid, i, j, Array2.sub(grid, u, v));
            Queue.enqueue(q, qq);
            INT_MAX
            )
      in
          get_opt u v i j
      end;

    (* bfs helper *)
    fun bfs_aux opt =
      if ((Queue.isEmpty q) orelse (opt < INT_MAX) then opt
      else (
        let
            val p = Queue.dequeue q;
            val neigh = getNeighbors p;
            (* opt results *)
            val results = List.map (explore p opt) neigh;
        in
            bfs_aux (foldl min results opt)
        end
      )

  in
      bfs_aux INT_MAX
  end *)


fun doomsday fileName =
  let
    (* parse file *)
    val instream = TextIO.openIn fileName;
    fun toStr c = if c = #"\n" then "\n" else (Char.toString c);
    fun toChar s = map toStr (String.explode (Option.valOf s))
    fun parseIns l x =
      if x = NONE then l
      else parseIns (x :: l) (TextIO.inputLine instream);

    (* list and dimensions *)
    val l = List.map rev (List.map toChar (parseIns [] (TextIO.inputLine instream)));
    val N = length l;
    val M = (length (hd l) - 1);
    (* grid and depth *)
    val grid = Array2.fromList l;
    val depth = Array2.array(N, M, ~1);
    val q = Queue.mkQueue(): ( int * int ) Queue.queue;


    fun isSpecial c = (c = "+" orelse c = "-")
    fun printResult r = print ((Int.toString r) ^ "\n" ^ (Array2.fold Array2.RowMajor (op ^) "" grid) ^ "\n");

    val result = bfs grid q depth N M;

    (* TODO insert special chars to q *)

  in
    printResult result
  end
