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
	
