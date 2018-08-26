
          
appendlist([], X, X).
appendlist([T|H], X, [T|L]) :- appendlist(H, X, L).

permutation([], []).
permutation([X], [X]) :-!.
permutation([T|H], X) :- permutation(H, H1), appendlist(L1, L2, H1), appendlist(L1, [T], X1), appendlist(X1, L2, X).


head([X|_],X).
head([],[]).
taill([_|X],X).
taill([],[]).
list_empty([], true).
list_empty([_|_], false).
isEqual(A,A).
isNotEqual(A,B):- A\=B.
pushFront(Item,List,[Item|List]).


sign(A,B):- C is A - B, C>0.

sign1(A,B):- C is A - B, C>=0.


getname(team(R, _, _,_), R).
getname([team(R, _, _,_)], R).
getmatches(team(_, R, _, _), R).
getebale(team(_, _, R, _), R).
getebale([team(_, _, R, _)], R).
getefage(team(_, _, _, R), R).
getefage([team(_, _, _, R)], R).

getnameniki(team(R, _, _,_), R).
getebaleniki(team(_, _, R, _), R).
getefageniki(team(_, _, _, R), R).

getlist([],Res):- Res=[].
getlist([H|T],Res):-
    (nonvar(H),Res=H,!;
    getlist(T,Res)).


team(monaco, 2, 10, 2).
team(andorra, 2, 6, 4).
team(sanmarino, 1, 1, 4).
team(liechtenstein, 1, 0, 7).


category([],A,B,Res1,Res2):- A = Res1, B = Res2,!.	
category(L,Losers,Winners,Res1,Res2):-
    head(L,H),
    taill(L,T),
    getmatches(H,M),
    (isEqual(M,1),
    append(Losers,[H],Losers1),
    category(T,Losers1,Winners,Res1,Res2);
 	append(Winners,[H],Winners1),
    category(T,Losers,Winners1,Res1,Res2)).

categorize(L,Loser,Winner):-
    category(L,[],[],Loser,Winner),!.

    

valid(HW,HL,M,Refr):-
    getebale(HW,Ebale),
    getefage(HL,Efage),
    getebale(HL,Scor),
    getefage(HW,Scor1),
    (Ebale >= Efage, Scor1 >= Scor, 
    %isNotEqual(Ebale,Scor),
    isNotEqual(Efage,Scor),
    getname(HW,Nikitis), 	
    getname(HL,Xamenos), 
    M = match(Nikitis,Xamenos,Efage,Scor),
    New_ebale is Ebale - Efage,
    New_efage is Scor1 - Scor,
    getmatches(HW, R),
    New_matches is R - 1,
    (isEqual(1,New_matches),
    New_efage>New_ebale;
    true
    ),	
    Refr = team(Nikitis,New_matches,New_ebale,New_efage),
    !;
    M = [],!).

valid1(HW,HL,M,Refr):-
    getebale(HW,Ebale),
    getefage(HL,Efage),
    getebale(HL,Scor),
    getefage(HW,Scor1),
    (Ebale >= Efage, Scor1 >= Scor, 
    %isNotEqual(Ebale,Scor),
    isNotEqual(Efage,Scor),
    getname(HW,Nikitis), 	
    getname(HL,Xamenos), 
    M = match(Nikitis,Xamenos,Efage,Scor),
    New_ebale is Ebale - Efage,
    New_efage is Scor1 - Scor,
    getmatches(HW, R),
    New_matches is R - 1,	
    Refr = team(Nikitis,New_matches,New_ebale,New_efage),
    !;
    M = [],!).

check([],[],Res,New_winners,Result,N):-
    categorize(New_winners,Loser,Winner),
    (isEqual(Winner,[]),
    head(Loser,H),
    taill(Loser,T),
    getname(H,Nikitis),
    getname(T,Xamenos),
    getebale(H,Ebale),
    getefage(H,Efage),
    getefage(T,Scor),
    getebale(T,Scor1),
    isEqual(Scor,Ebale),isEqual(Scor1,Efage),isNotEqual(Ebale,Efage),	
    M = match(Nikitis,Xamenos,Ebale,Efage),
    append(Res,[M],Res1),
    Result = Res1,!;
    NN is N/2,
    find_valid_matcharisma(Loser,Winner,Res,[],Result,NN)
    ).

check(Los,Win,Res,New_winners,Result,N):-
    head(Los,HL),
    head(Win,HW),
    (N =< 2,
    valid1(HW,HL,M,Refr);
    valid(HW,HL,M,Refr)),
    isNotEqual(M,[]),
    append(Res,[M],Res1),
    append(New_winners,[Refr],New_winners1),
    taill(Los,TL),
    taill(Win,TW),
    check(TL,TW,Res1,New_winners1,Result,N).

find_valid_matcharisma(Loser,Winner,Res,_,Result,N):- 
    %permutation(Loser,LPerm),!,
    permutation(Winner,WPerm),
    check(Loser,WPerm,Res,[],Result,N).
    
    
    
play(L,Z,N):-
    categorize(L,Loser,Winner),
    %head(Loser,HL),
    once(find_valid_matcharisma(Loser,Winner,[],[],Z,N)).


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

mundial(File,Q):-
    read_input(File, N, Teams),
    play(Teams,Q,N).

