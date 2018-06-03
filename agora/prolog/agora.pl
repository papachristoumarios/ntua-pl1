% helper functions          
head([X|_],X).
taill([_|X],X).

gcd(X, 0, X) :- !.
gcd(X, Y, Z) :-
    H is X rem Y,
    gcd(Y, H, Z).

lcm(X,Y,K):-
    gcd(X,Y,H),
    K is (X div H)*Y.

% prefix lcm calculation
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

check(A,B,C):-
C is A-B.

anath(A,B):-
B is A.

% solution by iterating on the prefix lcm arrays
solution(_,[],Opt,Min_index,_,_, Aux, Aux2):-
    Aux2 is Opt+0,
    (Min_index<0, Aux is Min_index+1;
    Aux is Min_index+0).

solution(Left,Right,Opt,Min_index,I,N, Aux, Aux2):-
    head(Left,L),
    head(Right,R),
    lcm(L,R,Temp),
    check(Temp,Opt,B),
    II is I+1,
    taill(Left,LL),
    taill(Right,RR),
    (B<0 ->solution(LL,RR,Temp,I,II,N, Aux, Aux2); solution(LL,RR,Opt,Min_index,II,N, Aux, Aux2)).

pushFront(Item,List,[Item|List]).
pushBack(N, [], [N]).
pushBack(N, [H|T], [H|R]) :- pushBack(N, T, R).

agora1(N,[H|T], When, Aux):-
    pushBack(1,[H|T],AA),
    pushFront(1,AA,A),
    prefixlcm(A,Left_lcm1),
    head(Left_lcm1,Opt),
    rev(Left_lcm1,Left_lcm),
    rev(A,B), prefixlcm(B,C), taill(C,D),
    taill(D,Right_lcm),
    solution(Left_lcm, Right_lcm, Opt, -1, 1, N, Aux, When).

% input parsing
read_input(File, N, L) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, N),
        read_list(Stream, N, L).

read_list(Stream, N, L) :-
    (
        N == 0 -> L = [];
        N > 0 -> read_line_to_codes(Stream, Line2),
                         atom_codes(Atom2, Line2),
                         atomic_list_concat(S, ' ', Atom2),
    		 		 maplist(atom_number, S, L)
        ).

solve(File, When, Missing) :- read_input(File, N, L), agora1(N, L, When, Missing).

agora(File, When, Missing) :- once(solve(File, When, Missing)).