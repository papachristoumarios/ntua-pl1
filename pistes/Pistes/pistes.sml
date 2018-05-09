fun max a b = if a >= b then a else b;
(* compute L2 - L1 *)
fun subtract (L2 : int list) (L1 : int list) = List.filter (fn x => List.all (fn y => x <> y) L1) L2

fun printList (l : int list) =
  if l = [] then print "\n"
  else (
      print ((Int.toString (hd l)) ^ ", ");
      printList (tl l)
  )


fun removeFirstOccurrence (item, list) =
    case list of
    [] => []
      | xs::ys => if item = xs then removeFirstOccurrence(~item,ys)
          else xs::removeFirstOccurrence(item,ys)

fun mySubtract L2 [] = L2
  | mySubtract L2 (h :: t) =
    let
      val newList = removeFirstOccurrence(h, L2);
    in
      mySubtract newList t
    end




fun find item [] = false
  | find item (h::t) =
    if h = item then true
    else find item t

fun pistes fileName =
  let
    (* parsing the input *)
    val k = Array.array(43, 0);
    val r = Array.array(43, 0);
    val s = Array.array(43, 0);
    val opt = 0;
    val keys = Array.array(43, [0]);
    val rewarded = Array.array(43, [0]);

    fun next_int input =
      Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    fun next_n_int n input =
      let
        fun helper i n l =
          if (i >= n) then l
          else helper (i + 1) n ((next_int input) :: l);
      in
        helper 0 n []
      end



    val stream = TextIO.openIn fileName;

    val N = (next_int stream) + 1;

    fun generate_list l i =
      if (i < 1) then l
      else generate_list (i :: l) (i - 1)


    val idx = Array.fromList ( 0 :: generate_list [] (N - 1) );

    fun asList i j arr total l =
        if i >= total then l
        else asList (i + 1) j arr total (Array2.sub(arr, i, j) :: l)

    fun getRewards j = Array.sub(rewarded, j);
    fun getKeys j = Array.sub(keys, j);

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
            Array.update(keys, i, next_n_int kk input);
            Array.update(rewarded, i, next_n_int rr input);
            (* readInts 0 i keys kk input; *)
            (* readInts 0 i rewarded rr input; *)
            Array.update(k, i, kk);
            Array.update(s, i, ss);
            Array.update(r, i, rr);

            parsePistes (i + 1) input
          end
        )
        else ()

    val prs = parsePistes 0 stream;

    (* q0 *)
    val index = 0;
    val score = Array.sub(s, 0);
    val total = 1;
    val notVisited = generate_list [] (N - 1);
    val hold = getRewards 0;
    val q0 = (index, score, total, notVisited, hold);

    (* prepeare the queue *)
    val q = Queue.mkQueue(): ( int * int * int * int list * int list) Queue.queue;
    val dummy = Queue.enqueue(q, q0);

    fun getNewState (tmp, current, keysFrom) =
      let
        val (index, score, total, notVisited, hold) =  tmp;
        val new_score = score + Array.sub(s, current);
        val new_total = total + 1;
        val new_index = current;
        val new_rewards = getRewards current;
        val new_hold = (mySubtract hold keysFrom) @ new_rewards;
        val new_notVisited = removeFirstOccurrence (current, notVisited);
        val new = (new_index, new_score, new_total, new_notVisited, new_hold);
      in
        Queue.enqueue(q, new);
        new
      end

    fun hasKeys j existingKeys =
      let
        val req = getKeys j;
        val findResults = List.map (fn x => find x existingKeys) req;
      in
        (List.all (fn x => x) findResults, j, req)
      end

    fun getNeighbors existingKeys notVisited =
        let
          val hasKeysTo = List.map (fn x => hasKeys x existingKeys) notVisited;
        in
          List.filter (fn (x, y, z) => x) hasKeysTo
        end


    fun bfs (opt : int) =
      if Queue.isEmpty q then opt
      else (
        let
          (* pop from queue *)
          val tmp = Queue.dequeue q;
          val (index, score, total, notVisited, hold) =  tmp;

          val boo = print ((Int.toString index) ^ "\n");
          val foo = print "Holding keys: \n";
          val foo = printList hold;
          (* get Neighbors that can be visited *)
          val neigh = getNeighbors hold notVisited;
          val new_opt = if neigh = [] then score else opt;

          (* if you cannot visit anyone then update opt *)
          (* else for each neighbor get a new tuple  *)
          val nextStates = List.map (fn (_, current, keysFrom) => getNewState (tmp, current, keysFrom)) neigh;

        in
          if (total = N + 1) then max opt score else bfs new_opt

        end
      );

  in
    print ((Int.toString (bfs 0)) ^ "\n")
  end
