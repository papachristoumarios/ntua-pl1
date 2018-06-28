read_input(File, N, Teams) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, N),
    read_lines(Stream, N, Teams).

read_lines(Stream, N, Teams) :-
    ( N == 0 -> Teams = []
    ; N > 0  -> read_line(Stream, Team),
                Nm1 is N-1,
                read_lines(Stream, Nm1, RestTeams),
                Teams = [Team | RestTeams]).

read_line(Stream, team(Name, P, A, B)) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat([Name | Atoms], ' ', Atom),
    maplist(atom_number, Atoms, [P, A, B]).

% [team(monaco, 2, 10, 2), team(andorra, 2, 11, 4), team(sanmarino, 1, 1, 4), team(liechtenstein, 1, 0, 7)]

beats(team(WName, WAgones, WEvale, WEfage), team(LName, LAgones, LEvale, LEfage)) :-
	WEvale > LEvale.

iswinner(team(Name, Agones, Evale, Efage)) :-
	Agones > 1.

isloser(team(Name, Agones, Evale, Efage)) :-
	Agones =:= 1.

split_teams(Teams, Winners, Losers) :-
	exclude(iswinner, Teams, Losers),
	exclude(isloser, Teams, Winners).

split_teams_finals(Teams, Winners, Losers) :-
	(
		Teams = [X, Y] -> Winners = [X], Losers = [Y];
		split_teams(Teams, Winners, Losers)
	).

valid([], []).
valid([W | Ws], [L | Ls]) :-
	beats(W, L), valid(Ws, Ls).

valid_round([], []).
valid_round(W, L, X) :-
	permutation(W, X),
	valid(X, L).

play_together([], [], [], []).
play_together(
	[team(WName, WAgones, WEvale, WEfage) | Ws],
 	[team(LName, LAgones, LEvale, LEfage) | Ls],
	[M | Matches], [NW | NewWinners]) :-
		NWAgones is WAgones - 1,
		NWEvale is WEvale - LEfage,
		NWEfage is WEfage - LEvale,
		M = match(WName, LName, LEfage, LEvale),
		NW = team(WName	, NWAgones, NWEvale, NWEfage),
		play_together(Ws, Ls, Matches, NewWinners).

% solve([team(WName, WAgones, WEvale, WEfage)], [team(LName, LAgones, LEvale, LEfage)], [Final]) :-
% 	WEvale >= 0, WEfage >= 0,
% 	LEvale >= 0, LEfage >= 0,
% 	WEvale =\= LEvale,
% 	Final = match(WName, LName, WEvale, LEvale).



solve(Winners, Losers, [M | Matches]) :-
  (
    Winners = [team(WName, WAgones, WEvale, WEfage)],
    Losers = [team(LName, LAgones, LEvale, LEfage)],
    WEvale >= 0, WEfage >= 0,
  	LEvale >= 0, LEfage >= 0,
  	WEvale =\= LEvale -> write('Le poule'), M = match(WName, LName, WEvale, LEvale), !;

    valid(Winners, Losers),
    play_together(Winners, Losers, M, TempWinners),
    write(M), nl,
    write('Temp Winners'),
    write(TempWinners), nl,
    once(split_teams(TempWinners, NewWinners, NewLosers)),
    write('New Winners'), nl,
    write('New Losers'), nl,
    write(NewWinners), nl,
    valid_round(NewWinners, NewLosers, CorrectWinners),
    solve(CorrectWinners, NewLosers, Matches)
  ).


mundial(File, Matches) :-
	read_input(File, N, Teams),
	split_teams(Teams, W, L),
	once(valid_round(W, L, InitWin)),
	write(InitWin), nl, write(L), nl,
	solve(InitWin, L, Matches).
