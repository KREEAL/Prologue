%15
minU(0,9):-!.
minU(X,M):-
	X1 is X div 10,
	minU(X1,M1),
	M2 is X mod 10,
	(M2<M1, M is M2;M is M1). 

%16
minD(X,M):- minD(X,9,M).
minD(0,M,M):-!.
minD(X,Y,M):-D is X mod 10, X1 is X div 10,D < Y,!,minD(X1,D,M); X2 is X div 10, minD(X2,Y,M).
%fhfhfh
	