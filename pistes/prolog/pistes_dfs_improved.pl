head([X|_],X).
head([],[]).
taill([_|X],X).
taill([],[]).
list_empty([], true).
list_empty([_|_], false).
isEqual(A,A).
isNotEqual(A,B):- A\=B.
pushFront(Item,List,[Item|List]).
getKeys([H | _], H).
getStars([_, _, S | _], S).
getRewards([_, R | _], R).
getRewards([H],H).
getKeys([],[]).

max(A,B,C):-
    A>B, C is A; C is B.

power(X,Y,Z):- Z is X**Y.


remfirocc(_, [], []):-!.
remfirocc(Term, [Term|Tail], Tail):-!.
remfirocc(Term, [Head|Tail], [Head|Result]) :-
  remfirocc(Term, Tail, Result),!.

sub([],[],[]).
sub(A, [], A).
sub([H1|T1],[H2|T2],C):- %apo ti 1i afairo ti 2i
	remfirocc(H2,[H1|T1],A),
	head(T2,B),
	remfirocc(B,A,C).

find(_,[],C):-C=false,!.
find(Item,[H|T],C):-
    (isEqual(H,Item), C =true,!; find(Item,T,C)).

valid([],[H|T],C):-C=false,!.
valid([],[],C):-C=true,!.
valid([H|T],[],C):-C=true,!.	%i 2i lista na yparxei mesa sti 1i
valid([H1|T1],[H2|T2],C):-
	find(H2,[H1|T1],Res),
	(\+(Res), C =false,!; sub([H1|T1],[H2],Res1), valid(Res1,T2,C)).
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

state(A,B,[],C, U):-
    % writeln(B),
    % write('foo'),
    U = B.
state(Keys, Score,Pistes,Head, U) :- % head einai to kefali tis arxikis listas apo pistes
    head(Pistes,H),
    getKeys(H, K),
    getRewards(H, S),
    getStars(H, R),
    valid(Keys,K,Res),
    New_score is Score + R,


    (Res, sub(Keys,K,Rest),
                append(Rest,S,New_keys),
                taill(Pistes,T),
                head(T,Hea),
                state(New_keys,New_score,T,Hea, U);
    taill(Pistes,T1),
    append(T1,[H],T),
    head(T,H1), (
        isNotEqual(H1,Head),
        state(Keys,Score,T,Head, U);
        % writeln(Score),
        U = Score,
        !)
    ).

start_state([],Keys,Score,Lista,A,B,C):-
	A = Keys, B = Score, C = Lista,!.
    	%head(Lista,H),
	%state(Keys,Score,Lista,H,U).

start_state(L,Keys,Score,Lista,A,B,C):-
	head(L,H),
	taill(L,T),
	getKeys(H,K),
	(isEqual(K,[]), 
	 getRewards(H,S),
	 getStars(H,R),
	 New_score is Score + R,
	 append(S,Keys,New_keys),
	 start_state(T,New_keys,New_score,Lista,A,B,C)
	 ; append(Lista,[H],Lista1),
 	 start_state(T,Keys,Score,Lista1,A,B,C) ).


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


solution(File, Solutions) :-
    read_input(File, N, Pistes),
    % mideniki pista
    head(Pistes, Head),
    getStars(Head, InitialScore),
    start_state(Pistes,[],0,[],A,B,C),
    head(C,HH),
    findall(Z, state(A, B, C, HH, Z), Solutions)
    .

pistes(File, Q) :-
    once(solution(File, S)),
    maxList(S, Q).

maxList([P|T], O) :- maxList(T, P, O).

maxList([], P, P).
maxList([H|T], P, O) :-
    (    H > P
    ->   maxList(T, H, O)
    ;    maxList(T, P, O)).
        
