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

%15 - 20
readlist(X,Y):-readlist([],X,0,Y).
readlist(A,A,G,G):-!.
readlist(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readlist(A1,B,C1,D).

writelist([]):-!.
writelist([H|T]):- write(H),write(' '),writelist(T).

%15(3) Дан целочисленный массив и натуральный индекс (число, меньшее размера массива). Необходимо определить является ли элемент по указан-ному индексу глобальным максимумом.

%индексируется с нуля
elbyindex(L,I,El):-elbyindex(L,I,El,0).
elbyindex([H|_],K,H,K):-!.
elbyindex([_|Tail],I,El,Cou):- I =:= Cou,elbyindex(Tail,Cou,El,Cou);Cou1 is Cou + 1, elbyindex(Tail,I,El,Cou1).

maxel(L,El):-maxel(L,[],-999,El).
maxel([],_,M,M):-!.
maxel([H|T],X,Mx,El):-H>Mx,!,append(X,T,List1),maxel(T,List1,H,El);append(X,T,List2),!,maxel(T,List2,Mx,El).

task15:- read(N),readlist(L,N),read(I),elbyindex(L,I,Elind),maxel(L,Elmax),(Elind =:= Elmax,write(yes);write(net)),!.

%16(11)Дан целочисленный массив, в котором лишь один элемент отличается от остальных. Необходимо найти значение этого элемента.

%сколько раз встретится элемент в списке
frequency(L,El,F):- frequency(L,El,F,0).
frequency([],_,G,G):-!.
frequency([H|T],El,F,C):-H=:=El, C1 is C + 1,!,frequency(T,El,F,C1);frequency(T,El,F,C),!.

imposter(L,I):-imposter(L,L,I,0).
imposter([],_,K,K):-!.
imposter([H|T],L,Y,Z):-frequency(L,H,R),R =:= 1,!,imposter(T,L,Y,H);imposter(T,L,Y,Z),!.

task16:- read(N),readlist(L,N),imposter(L,I),write(I),!.

%17(13)Дан целочисленный массив. Необходимо разместить элементы, расположенные до минимального, в конце массива.

minel(L,El):-minel(L,[],999,El).
minel([],_,M,M):-!.
minel([H|T],X,Mx,El):-H<Mx,!,append(X,T,List1),minel(T,List1,H,El);append(X,T,List2),!,minel(T,List2,Mx,El).

getindex(L,El,I):-getindex(L,El,I,0).
getindex([],_,G,G):-!.
getindex([H|T],El,I,C):- H=\=El,C1 is C + 1,!,getindex(T,El,I,C1);getindex([],El,I,C),!.

%делает срез списка  - элементы с индексами I1 и I2 включительно. Индексация с нуля.
srez(L,I1,I2,R):-srez(L,I1,I2,R,-1,[]).
srez(_,_,O2,Res,O2,Res):-!.
srez([_|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1, Curi<I1,!,srez(T,I1,I2,R,Curi,Lis).%до I1
srez([_|_],I1,I2,R,Ci,Lis):- Curi is Ci + 1, Curi>I2,!,srez([],I1,Curi,R,Curi,Lis).%после I2
srez([H|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1, append(Lis,[H],List),!,srez(T,I1,I2,R,Curi,List).%между I1 и I2

task17:-read(N),readlist(Lis,N),minel(Lis,Emin),
getindex(Lis,Emin,In),srez(Lis,0,In-1,Before),srez(Lis,In,N-1,Aft),
append(After,Before,Res),writelist(Res),!.