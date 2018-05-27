head([X|_],X).
taill([_|X],X).

gcd(X, 0, X) :- !.
gcd(X, Y, Z) :-
	H is X rem Y,
	gcd(Y, H, Z).

lcm(X,Y,K):-
	gcd(X,Y,H),
	K is (X div H)*Y.

prefixlcmm(Lcms,[],Lcms).
prefixlcmm([],[H|T],P):-
	prefixlcmm([H],T,P).
prefixlcmm([H1|T1],[H2|T2],P):-
	lcm(H1,H2,K),
	prefixlcmm([K,H1|T1],T2,P).

prefixlcm([H|T],K):-
	prefixlcmm([],[H|T],K).

rev1([H|T],A,R):-
	rev1(T,[H|A],R).
rev1([],A,A).
rev(L,R):-
	rev1(L,[],R).

isEqual(A,A).
isNotEqual(A,B):- A\=B.

solution(Left,[],Opt,Min_index,I,N,Opt,Min_index).
solution(Left,Right,Opt,Min_index,I,N,Opt,Min_index):-
	head(Left,L),
	head(Right,R),
	lcm(L,R,Temp),
	(Temp<Opt->Result11 is Temp,Result22 is I; Temp>=Opt-> Result11 is Opt, Result22 is Min_index),
	II is I+1,
	taill(Left,LL),
	taill(Right,RR),
	solution(LL, RR, Result11, Result22, II, N,Result11,Result22).

pushFront(Item,List,[Item|List]).
pushBack(N, [], [N]).
pushBack(N, [H|T], [H|R]) :- pushBack(N, T, R).

agora1(N,[H|T],Opt,Min_index):-
	pushBack(1,[H|T],AA),
	pushFront(1,AA,A),
	prefixlcm(A,Left_lcm1),
	head(Left_lcm1,Opt),
	rev(Left_lcm1,Left_lcm),
	rev(A,B), prefixlcm(B,C), taill(C,D),
	taill(D,Right_lcm),
	solution(Left_lcm, Right_lcm, Opt, -1, 1, N,Opt,Min_index1),
	(isEqual(Min_index1,-1)->Min_index is 0; Min_index is Min_index1).
