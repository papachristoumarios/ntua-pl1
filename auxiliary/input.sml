fun parse file =
    let
	(* a function to read an integer from an input stream *)
        fun next_int input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
	(* a function to read a real that spans till the end of line *)
        fun next_real input =
	    Option.valOf (TextIO.inputLine input)
	(* open input file and read the two integers in the first line *)
        val stream = TextIO.openIn file
        val n = next_int stream
        val l = next_int stream
	val _ = TextIO.inputLine stream
	(* a function to read the pair of integer & real in subsequent lines *)
        fun scanner 0 acc = acc
          | scanner i acc =
            let
                val d = next_int stream
                val (SOME v) = Real.fromString (next_real stream)
            in
                scanner (i - 1) ((d, v) :: acc)
            end
    in
        (n, l,  rev(scanner n []))
    end
