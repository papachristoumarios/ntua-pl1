head([], []).
head([X|_],X).
taill([_|X],X).
taill([], []).
list_empty([], true).
list_empty([_|_], false).
isEqual(A,A).
isNotEqual(A,B):- A\=B.
pushFront(Item,List,[Item|List]).
getKeys([H | _], H).
getStars([_, _, S | _], S).
getRewards([_, R | _], R).
pushBack(N, [], [N]).
pushBack(N, [H|T], [H|R]) :- pushBack(N, T, R).
second([A, B | T], B).
second([], []).
second([X], []).

max(A,B,C):-
	A>B, C is A; C is B.

printlist(L):-
	list_empty(L,XC),
	(XC, nl; head(L,H), write(H), taill(L,T), list_empty(T,XCC),(XCC,nl; write(', '),printlist(T))).

% remove first occurence
remfirocc(_, [], []):-!.
remfirocc(Term, [Term|Tail], Tail):-!.
remfirocc(Term, [Head|Tail], [Head|Result]) :-
  remfirocc(Term, Tail, Result),!.

% C = L1 - L2
sub([H1|T1],[H2|T2],C):- %apo ti 1i afairo ti 2i
	remfirocc(H2,[H1|T1],A),
	head(T2,B),
	remfirocc(B,A,C).

find(_,[],C):-C=false,!.
find(Item,[H|T],C):-
	(isEqual(H,Item), C =true,!; find(Item,T,C)).

valid([H|T],[],C):-C=true,!.	%i 2i lista na yparxei mesa sti 1i
valid([H1|T1],[H2|T2],C):-
	find(H2,[H1|T1],Res),
	(\+(Res), C =false,!; valid([H1|T1],T2,C)).

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

start([],0,Pistes).
state(Keys, Score,Pistes,Head):- % head einai to kefali tis arxikis listas apo pistes
	head(Pistes,H),
	getKeys(H, K),
	getStars(H, S),
	getRewards(H, R),
	valid(Keys,K,Res),
	(Res, New_score is Score + R, sub(Keys,K,Rest),
	 append(Rest,S,New_keys), taill(Pistes,T), head(T,Hea),
	 state(New_keys,New_score,T,Hea)
	 ; taill(Pistes,T1), append(T1,H,T), head(T,H1),
	 (isNotEqual(H1,Head), state(Keys,Score,T,Head); writeln(Score))  ).

% Parse input

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

range(Low, Low, High).
range(Out,Low,High) :- NewLow is Low+1, range([Low | Out], NewLow, High).

solve(File, Head, Q0, Queue, Result) :-
	read_input(File, N, Pistes),
	% mideniki pista
	head(Pistes, Head),
	getRewards(Head, Holding),
	getStars(Head, Score),
	N1 is N - 1,
	% not visited
	taill(Pistes, NotVisited),
	Q0 = [NotVisited, Score, Holding],
	% arxikopoiisi ouras me arxiki pista
	Queue = [Q0],
	bfs(Queue, Score, Result)
	.

bfs(Queue, Score, Result) :-
	(
		Queue = [] -> Result = Score
		;
		head(Queue, Current),
		taill(Queue, NewQueuePopped),
		head(Current, NotVisited),
		write('Begin!'), nl,
		write(NotVisited), nl,
		getNextStates(Current, NextStates, NotVisited, Score),
		write('Next please'), nl,
		write(NextStates), nl,
		% TODO Find valid nexts and append to queue
		append(NewQueuePopped, NextStates, NewQueue),
		bfs(NewQueue, Score, Result)
	).

getNextStates(Parent, NextStates, NotVisited, Optimal) :-
		(
			NotVisited = [] -> !
			;

			Parent = [NNotVisited, Score, Holding],
			head(Child, NotVisited),
			write('Holding '), write(Holding), nl,
			getKeys(Child, U),
			getKeys(U, R),
			getKeys(R, K),
			write('Keys '), write(K), nl,

			getStars(Child, S),
			getRewards(Child, R),
			valid(Holding, K, Res),
			write('Valid '),
			write(Child),
			write(Res), nl,
			(
				Res, New_score is Score + S,
							sub(Holding, K, New_Holding1),
							append(New_Holding1, R, New_Holding),
							max(New_score, Score, Optimal),
							write('New score is: '), nl,
							write(New_score), nl,
							sub(NotVisited, [Child], New_Not_Visited),
							QNext = [New_Not_Visited, New_score, New_Holding],
							taill(NotVisited, RestNotVisited),
							getNextStates(Parent, RestNextStates, RestNotVisited, Optimal),
							append([QNext], RestStates, NextStates)
							;
							taill(NotVisited, RestNotVisited),
							getNextStates(Parent, RestNextStates, RestNotVisited, Optimal)
				)


		).
