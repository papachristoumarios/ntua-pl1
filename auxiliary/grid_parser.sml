(* Read a file, line by line *)
fun parse file =
    let
      val inStream = TextIO.openIn file
      val string   = TextIO.inputAll inStream
    in
      String.tokens Char.isSpace string
    end

(* Make a list of characters from the input file *)

fun solve1 file = map explode (parse file)

fun solve2 file =
    let
      fun get f = map explode (parse f)
    in
      Array2.fromList(get file)
    end

