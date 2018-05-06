% gcd(+Integer, +Integer, -Integer)
gcd(X, 0, X) :- !.
gcd(X, Y, Z) :-
   H is X rem Y,
   gcd(Y, H, Z).

lcm(X, Y, L) :- gcd(X, Y, G), L is (G // X) * Y.
