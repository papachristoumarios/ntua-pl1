fun munge f g [] = []
   | munge f g (h::t) = f(h) :: g(h) :: (munge f g t) ;

fun maxSumSublist2 l =
   let
     val pos = List.filter (fn x => x > 0) l;
   in
     foldl op + 0 pos
   end;

fun maxSumSublist [] = 0
  | maxSumSublist (h :: t) =
    if h > 0 then h + (maxSumSublist t)
    else maxSumSublist t;

(* fun listify_aux l x i =
  if i mod 2 = 0 then List.partition (fn u => u <= x) l
  else List.partition (fn u => u > x) l; *)


fun lenfreqsortaux l =
  let
    fun lenfreqhelp elem =
      let
        val n = length elem;
        val q = map (fn x => if length x = n then 1 else 0) l;
      in
        (foldl (op +) 0 q, elem)
      end
  in
    map lenfreqhelp l
  end

fun compare ((x, _), (z, _)) = x < z;


fun merge(_, [], ys) = ys
  |	merge(_, xs, []) = xs
  |	merge(f, x::xs, y::ys) =
  	if f(x, y) then
  		x::merge(f, xs, y::ys)
  	else
  		y::merge(f, x::xs, ys);

fun split [] = ([],[])
  |	split [a] = ([a],[])
  |	split (a::b::cs) =
  		let val (M,N) = split cs
      in
        (a::M, b::N)
  		end

fun mergesort [] _ = []
  |	mergesort [a] _ = [a]
  |   mergesort [a,b] f =	if f(a, b) then
  							[a,b]
  						else [b,a]
  |   mergesort L f =
          let val (M,N) = split L
          in
            merge (f, mergesort M f, mergesort N f)
          end;

fun lenfreqsort l =
  let
    val f = lenfreqsortaux l;
    val result = mergesort f compare;
  in
    map (fn (_, y) => y) result
  end;


fun split_at_n n i (h::t) acc =
    if i < n then split_at_n n (i + 1) t (h :: acc)
    else (rev acc, h :: t)

fun find_index [] _ _ _ = 0
  | find_index (h::t) f x i =
      if f(x, h) <> true then i
      else find_index t f x (i + 1);

fun mysplice l f x =
  let
    val i = find_index l f x 0;
  in
    split_at_n i 0 l []
  end

fun listify l x i =
  let
    val f = if i mod 2 = 0 then op > else op <
    val (left, right) = mysplice l f x;
  in
    listify right x (i + 1)
  end
