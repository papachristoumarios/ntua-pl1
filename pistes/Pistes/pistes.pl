% pista parser
getKeys([H | _], H).
getStars([_, _, S | _], S).
getRewards([_, R | _], R).

% sublist from stack overflow
sublist(L, M, N, S) :-
    findall(E, (nth1(I, L, E), I >= M, I =< N), S).

getPistaKeys(L, Keys) :-
	getKeys(L, C),
	M is C + 3,
	sublist(L, 4, M, Keys).

getPistaRewards(L, Rewards) :-
	getRewards(L, C),
	getKeys(L, N),
	M is N + 4,
	Z is M + C,
	sublist(L, M, Z, Rewards).

parsePista(L, Result) :-
	getStars(L, Stars),
	getPistaKeys(L, Keys),
	getPistaRewards(L, Rewards),
	Result = [Keys, Rewards, Stars].

% file parser returns output to form
% ?- read_input('p1.txt', N, L).
% N = 5,
% L = [[[], [1], 0], [[1], [], 200], [[1], [1, 3], 150], [[2, 1], [], 120], [[3], [1, 2], 140]].

read_input_aux(File, N, L) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, M),
		N is M + 1,
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

read_input(File, N, Q) :-
	read_input_aux(File, N, L),
	maplist(parsePista, L, Q).
