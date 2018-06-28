heapify(void,void).
heapify(tree(X,L,R),Heap) :-
   heapify(L,HeapL), heapify(R,HeapR), adjust(X,HeapL,HeapR,Heap).

adjust(X,HeapL,HeapR,tree(X,HeapL,HeapR)) :-
    greater(X,HeapL), greater(X,HeapR).
adjust(X,tree(X1,L,R),HeapR,tree(X1,HeapL,HeapR)) :-
    X < X1, greater(X1,HeapR), adjust(X,L,R,HeapL).
adjust(X,HeapL,tree(X1,L,R),tree(X1,HeapL,HeapR)) :-
    X < X1, greater(X1,HeapL), adjust(X,L,R,HeapR).

greater(X,void).
greater(X,tree(X1,L,R)) :- X >= X1.
