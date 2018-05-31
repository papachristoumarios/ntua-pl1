head([X|_],X).
taill([_|X],X).
list_empty([], true).
list_empty([_|_], false).
isEqual(A,A).
isNotEqual(A,B):- A\=B.
pushFront(Item,List,[Item|List]).
getKeys([H | _], H).
getStars([_, _, S | _], S).
getRewards([_, R | _], R).

max(A,B,C):-
	A>B, C is A; C is B.

printlist(L):-
	list_empty(L,XC),	
	(XC, nl; head(L,H), write(H), taill(L,T), list_empty(T,XCC),(XCC,nl; write(', '),printlist(T))).

power(X,Y,Z):- Z is X**Y. 


remfirocc(_, [], []):-!.
remfirocc(Term, [Term|Tail], Tail):-!.
remfirocc(Term, [Head|Tail], [Head|Result]) :-
  remfirocc(Term, Tail, Result),!.

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
	getPistaKeys(H, K),
	getPistaStars(H, S),
	getPistaRewards(H, R),
	valid(Keys,K,Res),
	(Res, New_score is Score + R, sub(Keys,K,Rest), append(Rest,S,New_keys), taill(Pistes,T), head(T,Hea), state(New_keys,New_score,T,Hea); taill(Pistes,T1), append(T1,H,T), head(T,H1), (isNotEqual(H1,Head), state(Keys,Score,T,Head); writeln(Score))  ).
	
	
	


	

