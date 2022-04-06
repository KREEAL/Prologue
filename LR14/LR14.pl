read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List):-read_str(A,_,Flag),read_list_str([A],List,Flag).
read_list_str(List,List,1):-!.
read_list_str(Cur_list,List,0):-
	read_str(A,_,Flag),append(Cur_list,[A],C_l),read_list_str(C_l,List,Flag).
	
read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).	

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

%Задание 1
%1
symbolsstring(A,S):-symbolsstring(A,S,0).
symbolsstring([],G,G):-!.
symbolsstring([_|T],S,C):-C1 is C + 1, symbolsstring(T,S,C1),!.

task1_1:-read_str(A,X,0),write_str(A),write(", "),write_str(A),write(", "),write_str(A),write(" , "),write(X).

%2 
task1_2:-read_str(A,_),countwords(A,K),write(K).

countwords(A,C):-countwords(A,0,C).
countwords([],K,K):-!.
countwords(Str,I,K):-skipspace(Str,Snew),getword(Snew,Word,Snew1),Word \=[],I1 is I+1,countwords(Snew1,I1,K),!.
countwords(_,K,K).

skipspace([32|T],A1):-skipspace(T,A1),!.
skipspace(A1,A1).

getword([],[],[]):-!.
getword(A,Word,A2):-getword(A,[],Word,A2).
getword([],Word,Word,[]).
getword([32|T],Word,Word,T):-!.
getword([H|T],W,Word,A2):-append(W,[H],W1),getword(T,W1,Word,A2).

%3
task1_3:-read_str(A,_),getwords(A,Words,_),unique(Words,Uwords),
		counts(Uwords,C,Words),indOfMax(C,Ind),elbyindex(Uwords,Ind,El), write_str(El).

getwords(A,Words,K):-getwords(A,[],Words,0,K).
getwords([],B,B,K,K):-!.
getwords(A,Temp,B,I,K):- skipspace(A,A1),getword(A1,Word,A2),Word \=[],
		I1 is I+1,append(Temp,[Word],Tw),getwords(A2,Tw,B,I1,K),!.
getwords(_,B,B,K,K).

counts([],[],_):-!.
counts([Word|Twords],[Count|Tcounts],Words):-
	count(Word,Words,Count),counts(Twords,Tcounts,Words).

count(_, [], 0):-!.
count(Elem, List, X):- count(Elem, List, 0, X).
count(_, [], Count, Count):- !.
count(Elem, [Elem|T], Count, X):- Count1 is Count + 1, count(Elem, T, Count1, X), !.
count(Elem, [_|T], Count, X):- count(Elem, T, Count, X).

elbyindex(L,I,El):-elbyindex(L,I,El,0).
elbyindex([H|_],K,H,K):-!.
elbyindex([_|Tail],I,El,Cou):- I =:= Cou,elbyindex(Tail,Cou,El,Cou);Cou1 is Cou + 1, elbyindex(Tail,I,El,Cou1).

indOfMax(X,Y):-indexOfMin(X,Y).
indexOfMin([], -1):- !.
indexOfMin([H|T], X):-indexOfMin(T, 1, 1, X, H).
indexOfMin([], _, MinInd, MinInd, _):-!.
indexOfMin([H|T], CurInd, _, X, CurMin):- H > CurMin, NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, NewCurInd, X, H), !.
indexOfMin([_|T], CurInd, MinInd, X, CurMin):- NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, MinInd, X, CurMin).

unique([],[]):- !.
unique([H|T],L):-unique([H|T],L,[]).
unique([],Lis,Lis):-!.
unique([H|T],List,[]):-unique(T,List,[H]),!.
unique([H|T],List,List1):-not(contains(List1,H)),append(List1,[H],List2),unique(T,List,List2),!.
unique([_|T],List,List1):-unique(T,List,List1).

contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

%4
task1_4:-read_str(A,N),(N>5->wr_3(A),N4 is N -3, N1 is N - 1,srez(A,N4,N1,R),wr_3(R);elbyindex(A,0,El),wrsymn(El,N)).

wr3([Primero,Segundo,Tercero|_]):-name(Pr,[Primero]),name(Se,[Segundo]),name(Te,[Tercero]),write(Pr),write(Se),write(Te),!.

wrsymn(A,N):-wrsymn(A,0,N).
wrsymn(_,K,K):-!.
wrsymn(A,C,N):-C1 is C + 1, name(A1,[A]),write(A1),wrsymn(A,C1,N),!.

srez(L,I1,I2,R):-srez(L,I1,I2,R,-1,[]).
srez(_,_,O2,Res,O2,Res):-!.
srez([_|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1, Curi<I1,!,srez(T,I1,I2,R,Curi,Lis).%до I1
srez([_|_],I1,I2,R,Ci,Lis):- Curi is Ci + 1, Curi>I2,!,srez([],I1,Curi,R,Curi,Lis).%после I2
srez([H|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1, append(Lis,[H],List),!,srez(T,I1,I2,R,Curi,List).%между I1 и I2
