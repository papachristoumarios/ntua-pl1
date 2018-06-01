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

getname(team(R, _, _,_), R).
getmatches(team(_, R, _, _), R).
getebale(team(_, _, R, _), R).
getefage(team(_, _, _, R), R).

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

valid(HW,HL,M):-
	getebale(HW,Ebale),
	getefage(HL,Efage),
	getebale(HL,Scor),
	getefage(HW,Scor1),
	(sign(Ebale,Efage), sign(Scor1,Scor), 
	getname(HW,Nikitis), 	
	getname(HL,Xamenos), 
	M = match(Nikitis,Xamenos,Efage,Scor),!;
	M = [],!).

find_valid_matcharisma([],[],Head,Res):- writeln(Res).
find_valid_matcharisma(Loser,Winner,Head,Res):- %kefali listas loser
	head(Loser,HL),
	head(Winner,HW),
	valid(HW,HL,M),
	taill(Loser,TL),
	taill(Winner,TW),
	( isEqual(M,[]),
	head(TL,New_l),
	append(TL,[HL],Loser1),
	(isNotEqual(Head,New_l),
	find_valid_matcharisma(Loser1,Winner,Head,Res);
	append(TW,[HW],Winner11),
	append(TL,[HL],Loser11),
	head(TL,HG),
	find_valid_matcharisma(Loser11,Winner11,HG,Res),!);
	head(TL,Hea),
	append(Res,M,Res1),
	find_valid_matcharisma(TL,TW,Hea,Res1) ).
	
play(L):-
	categorize(L,Loser,Winner),
	head(Loser,HL),
	find_valid_matcharisma(Loser,Winner,HL,[]).








