%HELPFUL &&&&&&&&&&&&&&&&&&&&&&&&

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

unique_elems([], []):- !.
unique_elems([H|T], List2):- unique_elems([H|T], List2, []).
unique_elems([], CurList, CurList):- !.
unique_elems([H|T], List, []):- unique_elems(T, List, [H]), !.
unique_elems([H|T], List, CurList):- not(contains(CurList, H)), append(CurList, [H], NewList), unique_elems(T, List, NewList), !.
unique_elems([_|T], List, CurList):- unique_elems(T, List, CurList).

contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

count(_, [], 0):-!.
count(Elem, List, X):- count(Elem, List, 0, X).
count(_, [], Count, Count):- !.
count(Elem, [Elem|T], Count, X):- Count1 is Count + 1, count(Elem, T, Count1, X), !.
count(Elem, [_|T], Count, X):- count(Elem, T, Count, X).

listleng([],0).
listleng([_|T],I):-listleng(T,J),I is J + 1.

writelist([]):-!.
writelist([H|T]):- write(H),write(' '),writelist(T).

readlist(X,Y):-readlist([],X,0,Y).
readlist(A,A,G,G):-!.
readlist(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readlist(A1,B,C1,D).

frequency(L,El,F):- frequency(L,El,F,0).
frequency([],_,G,G):-!.
frequency([H|T],El,F,C):-H=:=El, C1 is C + 1,!,frequency(T,El,F,C1);frequency(T,El,F,C),!.

elbyindex(L,I,El):-elbyindex(L,I,El,0).
elbyindex([H|_],K,H,K):-!.
elbyindex([_|Tail],I,El,Cou):- I =:= Cou,elbyindex(Tail,Cou,El,Cou);Cou1 is Cou + 1, elbyindex(Tail,I,El,Cou1).

getindex(L,El,I):-getindex(L,El,I,0).
getindex([],_,G,G):-!.
getindex([H|T],El,I,C):- H=\=El,C1 is C + 1,!,getindex(T,El,I,C1);getindex([],El,I,C),!.

%HELPFUL &&&&&&&&&&&&&&&&&&&&&&&&

%11(39) Дан целочисленный массив. Необходимо вывести вначале его элементы с четными индексами, а затем - с нечетными.

chetnechet(L):-listleng(L,Len),chetnechet(L,0,Len,[],[]).
chetnechet([],F,F,A,B):-append(A,B,C),writelist(C).
chetnechet([H|T],In,Le,Ch,Nch):- In mod 2 =:= 0,append(Ch,[H],Ch1),In1 is In + 1,chetnechet(T,In1,Le,Ch1,Nch),!;append(Nch,[H],Nch1),In2 is In +1,chetnechet(T,In2,Le,Ch,Nch1),!.

task11:- read(N),readlist(L,N),chetnechet(L),!.

%12(45) Дан целочисленный массив и интервал a..b. Необходимо найти сумму элементов, значение которых попадает в этот интервал.

sumlist(List,A,B,Sum):-sumlist(List,A,B,0,Sum).
sumlist([],_,_,Su,Su):-!.
sumlist([H|T],A,B,S,Sum):- H> A,H< B,S1 is S+H,sumlist(T,A,B,S1,Sum),!;sumlist(T,A,B,S,Sum).

task12:- read(N),readlist(L,N),read(A),read(B),sumlist(L,A,B,Sum),write(Sum).

%13(51) Для введенного списка построить два списка L1 и L2, где элементы L1 это неповторяющиеся элементы исходного списка, а элемент списка L2 с номером i показывает, сколько раз элемент списка L1 с таким номером повторяется в исходном.

unique([],[]):- !.
unique([H|T],L):-unique([H|T],L,[]).
unique([],Lis,Lis):-!.
unique([H|T],List,[]):-unique(T,List,[H]),!.
unique([H|T],List,List1):-not(contains(List1,H)),append(List1,[H],List2),unique(T,List,List2),!.
unique([_|T],List,List1):-unique(T,List,List1).

pointer(Common,Uniq,Res):-pointer(Common,Uniq,Res,[]).
pointer(_,[],R,R):-!.
pointer(Common,[H|T],Res,Acc):-frequency(Common,H,F),F1 is F,append(Acc,[F1],Acc1),pointer(Common,T,Res,Acc1).

task13:- read(N),readlist(L,N),unique(L,Uniq),pointer(L,Uniq,Res),writelist(L),nl,writelist(Uniq),nl,writelist(Res),!. 