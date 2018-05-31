read_input(File, N, L) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, N),
		read_lines(Stream, N,  L).


read_lines(Stream, N, L) :-
    ( N == 0 -> L = []
    ; N > 0  -> read_list(Stream, S),
                Nm1 is N-1,
                read_lines(Stream, Nm1, RestLines),
                L = [S | RestLines]).


read_list(Stream, L) :-
	read_line_to_codes(Stream, Line2),
	atom_codes(Atom2, Line2),
	atomic_list_concat(S, ' ', Atom2),
  maplist(atom_number, S, L).
