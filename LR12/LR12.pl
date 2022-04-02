%11
easy(X):-easy(2,X).
easy(X,X):-!.
easy(K,X):- Ost is X mod K, Ost=0,!,fail.
easy(K,X):-K1 is K+1,easy(K1,X).

maxEasyDer(X,N):- maxEasyDer(X,X,N),!.
maxEasyDer(X,K,K):- O is X mod K, O = 0,easy(K),!.
maxEasyDer(X,K,N):-K1 is K-1,maxEasyDer(X,K1,N).
