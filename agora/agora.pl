% gcd(+Integer, +Integer, -Integer)
gcd(X, 0, X) :- !.
gcd(X, Y, Z) :-
   H is X rem Y,
   gcd(Y, H, Z).

lcm(X, Y, L) :- gcd(X, Y, G), L is (G // X) * Y.

append([], X, X).
append([X|Y], Z, [X|W]) :- append(Y, Z, W).

sumlist([], 0).
sumlist([H | T ], S) :- sumlist(T, R), S is H + R.

gcdlist([], 1).
gcdlist([X], X).
gcdlist([H | T], S) :- gcdlist(T, R), gcd(H, R, S).

lcmlist([], 1).
lcmlist([Y], Y).
lcmlist([H | T], S) :- lcmlist(T, R), lcm(H, R, S).


prlcmlist([H], [H]).
prlcmlist([H | T], [Z, W | U]) :- prlcmlist(T, [W | U]), lcm(H, W, Z).
