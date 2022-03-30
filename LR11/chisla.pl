maxU(0,0):-!.
maxU(X,M):-
    X1 is X div 10,
    maxU(X1,M1),
    M2 is X mod 10,
    (M2 > M1, M2 mod 3 =\= 0 -> M is M2; M is M1).
	
%15
minU(0,10):-!.
minU(X,M):-
	/*X1 is X div 10,*/
	minU(X div 10,M1),
	M2 is X mod 10,
	(M2<M1, M is M2;M is M1). 

	
minD(0,10):-!.
minD(X,M):-
	X1 is X div 10,
	Cur is X mod 10,
	M1 is 0,
	if Cur < M then 
		M1 = Cur 
	else 
		M1 = M 
	end if,
	minD(X1,M1).
	