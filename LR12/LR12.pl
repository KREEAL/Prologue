%11 maximalnii prostoy delitel chisla
easy(X):-easy(2,X).
easy(X,X):-!.
easy(K,X):- Ost is X mod K, Ost=0,!,fail.
easy(K,X):-K1 is K+1,easy(K1,X).

maxEasyDer(X,N):- maxEasyDer(X,X,N),!.
maxEasyDer(X,K,K):- O is X mod K, O = 0,easy(K),!.
maxEasyDer(X,K,N):-K1 is K-1,maxEasyDer(X,K1,N).

%12GCD max odd unEasyDelitel & proizvedenije cifr

maxUnEasyOddDer(X,N):- maxUnEasyOddDer(X,X,N),!.
maxUnEasyOddDer(X,K,K):- O is X mod K, O = 0,not(easy(K)),K mod 2 =\= 0,!.
maxUnEasyOddDer(X,K,N):-K1 is K-1,maxUnEasyOddDer(X,K1,N).

appCifr(X,A):-appCifr(X,1,A).
appCifr(0,F,F):-!.
appCifr(X,S,A):-X1 is X div 10,S1 is S * (X mod 10),appCifr(X1,S1,A).

gcd(0, X, X):- X > 0, !.
gcd(X, Y, Z):- X >= Y, X1 is X-Y, gcd(X1,Y,Z).
gcd(X, Y, Z):- X < Y, X1 is Y-X, gcd(X1,X,Z).

task2(N,A):-
	N1 is N,
	maxUnEasyOddDer(N1,MU),
	MaxUd is MU,
	N2 is N,
	appCifr(N2,AC),
	AppC is AC,
	gcd(MaxUd,AppC,A),!.
	

%13 Найдите число d, меньшее 1000, для которого десятичная дробь 1/d содержит самый длинный период

%делит на 2 пока делится
der2(1,1):-!.
der2(X,R):- 
	X1 is X div 2,
	Os is X mod 2,!,
	der2(X1,R1),!,
	(Os = 0,R is R1;R is X),!.
	
%делит на 5 пока делится
der5(5,1):-!.
der5(4,1):-!.
der5(3,1):-!.
der5(2,1):-!.
der5(1,1):-!.
der5(X,R):- 
	X1 is X div 5,
	Os is X mod 5,
	der5(X1,R1),!,
	(Os = 0,R is R1;R is X),!.


periodL(X,L):-X1 is X,der2(X1,R2),der5(R2,R5),periodL(R5,L,0,1).
periodL(_,G,G,1):-!.
periodL(N,L,K,R):- R > 1, R1 is (R * 10)  mod N,K1 is K + 1,!,periodL(N,L,K1,R1);periodL(N,L,K,0).

%14 получить длину списка

listleng([],0).
listleng([_|T],I):-listleng(T,J),I is J + 1.
