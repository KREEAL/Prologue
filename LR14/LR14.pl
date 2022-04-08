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
task1_1:-read_str(A,X,0),write_str(A),write(", "),write_str(A),write(", "),write_str(A),write(" , "),write(X).

symbolsstring(A,S):-symbolsstring(A,S,0).
symbolsstring([],G,G):-!.
symbolsstring([_|T],S,C):-C1 is C + 1, symbolsstring(T,S,C1),!.



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

%5
task1_5:- read_str(A,N),N1 is N-1, elbyindex(A,N1,El),show(A,El).

show(List,El):-show(List,El,0).
show([_],_,_):-!.
show([El|T],El,I):-write(I),write(' '),I1 is I + 1, show(T,El,I1),!.
show([_|T],El,I):-I1 is I+1,show(T,El,I1).

show_match([_],_,_):-!.
show_match([Elem|Tail],Elem,I):-write(I),nl,I1 is I+1,show_match(Tail,Elem,I1),!.
show_match([_|Tail],Elem,I):-I1 is I+1,show_match(Tail,Elem,I1).

/*******************************************************************************************************/
%Задание 2
%1
task2_1:-	see('D:/prologue/PrologLabFilp/LR14/2_1i.txt'),read_list_str(List),formlenlist(List,ListB),maxel(ListB,El),seen,
	tell('D:/prologue/PrologLabFilp/LR14/2_1o.txt'), write(El),told.
	
listleng([],0).
listleng([_|T],I):-listleng(T,J),I is J + 1.

formlenlist(ListA,ListB):-formlenlist(ListA,ListB,[]).
formlenlist([],K,K):-!.
formlenlist([H|T],B,C):-listleng(H,Len),Len2 is Len/2,append(C,[Len2],C1),formlenlist(T,B,C1).

maxel(L,El):-maxel(L,[],-999,El).
maxel([],_,M,M):-!.
maxel([H|T],X,Mx,El):-H>Mx,!,append(X,T,List1),maxel(T,List1,H,El);append(X,T,List2),!,maxel(T,List2,Mx,El).

writelist([]):-!.
writelist([H|T]):- write(H),write(' '),writelist(T).

%2
task2_2:-see('D:/prologue/PrologLabFilp/LR14/2_2i.txt'),read_list_str(List),countwnospaces(List,C),seen,
	tell('D:/prologue/PrologLabFilp/LR14/2_2o.txt'), write(C),told.
	
	
countwnospaces(Liststr,C):-countwnospaces(Liststr,C,0).
countwnospaces([],G,G):-!.
countwnospaces([H|T],C,K):-spacesexist(H,Bool),Bool=0,K1 is K + 1, countwnospaces(T,C,K1),!;countwnospaces(T,C,K).

spacesexist(Word,Bool):-spacesexist(Word,Bool,0).
spacesexist([],B,B):-!.
spacesexist([H|T],Bool,C):- H=:=32,C1 is C+1,spacesexist(T,Bool,C1),!;spacesexist(T,Bool,C).

%3
task2_3:-see('D:/prologue/PrologLabFilp/LR14/2_3i.txt'),read_list_str(List),counta(List,C),average(C,Ave),seen,
	tell('D:/prologue/PrologLabFilp/LR14/2_3o.txt'),biggera(List,Ave),told.


%Кол-во А по строкам
counta(L,C):-counta(L,0,C).
counta([],K,K):-!.
counta([H|T],I,Lc):-ainstr(H,Coua),append(I,[Coua],I1),counta(T,I1,Lc).
	
%kolvo A в строке
ainstr(L,N):-ainstr(L,0,N).
ainstr([],N,N):-!.
ainstr([H|T],I,N):-(H is 1040->I1 is I+1,ainstr(T,I1,N),!;ainstr(T,I,N)).

%Среднее значение списка
average(List,Ave):-average(List,0,Sum,0,N),Ave is Sum div N.
average([],Sum,Sum,N,N):-!.
average([H|T],I_Sum,Sum,I_N,N):-Sum1 is I_Sum+H,N1 is I_N+1, average(T,Sum1,Sum,N1,N).

biggera([],_):-!.
biggera([H|T],Ave):-ainstr(H,CountA),(CountA>Ave->name(H1,H),write_str(H1),biggera(T,Ave),!;biggera(T,Ave),!).

%4
task2_4:-see('D:/prologue/PrologLabFilp/LR14/2_4i.txt'),read_list_str(List),allwords(List,Words),unique(Words,Uniquewords),seen,
	counts(Uniquewords,Counted,Words),maxel(Counted,Maxel),getindex(Counted,Maxel,Maxi),elbyindex(Uniquewords,Maxi,Mostcoolword),name(Mcw1,Mostcoolword),
	tell('D:/prologue/PrologLabFilp/LR14/2_4o.txt'),write('Samoye povtoryayusheesya slovo: '),write(Mcw1),told.
	
%Все слова
allwords(Strings,Words):-allwords(Strings,[],Words).
allwords([],Lw,Lw):-!.
allwords([H|T],I,Listwords):-getwords(H,Words,_),append(I,Words,I1),allwords(T,I1,Listwords).

getindex(L,El,I):-getindex(L,El,I,0).
getindex([],_,G,G):-!.
getindex([H|T],El,I,C):- H=\=El,C1 is C + 1,!,getindex(T,El,I,C1);getindex([],El,I,C),!.

%5
	
%я шота условие не понял

/****************************************************************************************************/

%Задание 3(1) Дана строка. Необходимо найти общее количество русских символов.

task3:-read_str(A,_),countrusskie(A,C),write(C).

%1040-1103 = русские 

countrusskie(A,C):-countrusskie(A,C,0).
countrusskie([],G,G):-!.
countrusskie([H|T],C,I):- H > 1039,H < 1104,I1 is I + 1,countrusskie(T,C,I1),!;countrusskie(T,C,I),!.

%Задание 4(9) Дана строка. Необходимо проверить образуют ли строчные символы латиницы палиндром.

task4:-read_str(A,_,0),staylatina(A,New),write_str(New),reverse(New,Revnew),palindrome(New,Revnew,0).

%97-122 строчные латинцы

staylatina(Str,New):-staylatina(Str,New,[]).
staylatina([],S,S):-!.
staylatina([H|T],N,Acc):- H>96, H< 123, append(Acc,[H],Acc1),!,staylatina(T,N,Acc1);staylatina(T,N,Acc),!.

reverse(A, Z):-reverse(A,Z,[]).
reverse([],Z,Z).
reverse([H|T],Z,Acc):-reverse(T,Z,[H|Acc]).

palindrome([], [], _):-!.
palindrome(_, _, N):-N < 0, !, fail.
palindrome([H|T1], [H|T2], N):-!, palindrome(T1, T2, N).
palindrome([_|T1], [_|T2], N):-NN is N - 1, palindrome(T1, T2, NN).

%18Найти в тексте даты формата «день.месяц.год».

%1=49,2=50,3=51.=46
task5:-	see('D:/prologue/PrologLabFilp/LR14/5i.txt'),read_list_str(List),findalldatas(List,Dts),seen,
	tell('D:/prologue/PrologLabFilp/LR14/5o.txt'), write_str(Dts),told.

findalldatas(Strlist,Datas):-findalldatas(Strlist,Datas,[]).
findalldatas([],W,W):-!.
findalldatas([H|T],Datas,Tmp):-finddatas(H,D),append(Tmp,D,Tmp1),findalldatas(T,Datas,Tmp1),!.


finddatas(Str,Datas):-finddatas(Str,Datas,[]).
finddatas([],D,D):-!.
finddatas(Str,Datas,Temp):-listleng(Str,Len),Len>9,srez(Str,0,9,Dnew),isDate(Dnew,Bool),Len1 is Len -1, srez(Str,1,Len1,Strnew),!,
(Bool=:=1,append(Temp,Dnew,Temp1),append(Temp1,[32],Temp2),finddatas(Strnew,Datas,Temp2),!;finddatas(Strnew,Datas,Temp),!);finddatas([],Datas,Temp),!.


isDate(Str,B):-isDate(Str,B,1).
isDate([],A,A):-!.
isDate(Str,B,K):-elbyindex(Str,0,Day1),elbyindex(Str,1,Day2),elbyindex(Str,2,Dot1),elbyindex(Str,3,Mon1),elbyindex(Str,4,Mon2),
	elbyindex(Str,5,Dot2),elbyindex(Str,6,Y1),elbyindex(Str,7,Y2),elbyindex(Str,8,Y3),elbyindex(Str,8,Y4),
	Day1>47,Day1 < 52,Day2>47,Day2<58,Dot1=:=46,Mon1>47,Mon1 < 51,Mon2 >47,Mon2 < 58,
	Dot2=:=46,Y1>47,Y2>47,Y3>47,Y4>47,Y1<58,Y2<58,Y3<58,Y4<58,K1 is K * 1,isDate([],B,K1),!;K2 is K * 0,isDate([],B,K2),!.
	
/**************************************нормальные задания кончились**********************************************************/

task6:-see('D:/prologue/PrologLabFilp/LR14/6i.txt'),read_list_str(A),elbyindex(A,0,A1),elbyindex(A,1,K1),name(K,K1),seen,
	tell('D:/prologue/PrologLabFilp/LR14/6o.txt'),
	write('Razmesheniya s povotorenijami po k'),nl,
	not(b_a_rp(A1,K,[])),nl,!,
	write('Perestanovki'),nl,
	not(b_a_p(A1,[])),nl,!,
	write('Razmesheniya po k'),nl,
	not(b_a_r(A1,K,[])),nl,!,
	write('Vse podmnojestva'),
	not((sub_set(B,A1),write_str(B),nl,fail)),nl,
	write('Sochetanija po k'),nl,
	not((sochet(B,K,A1),write_str(B),nl,fail)),nl,
	write('Sochetanija s povotorenijami'),nl,
	not((sochet_p(B,K,A1),write_str(B),nl,fail)),nl,
	told.

build_all_razm_p:-
		read_str(A,_),read(K),b_a_rp(A,K,[]).
		
b_a_rp(_,0,Perm1):-write_str(Perm1),nl,!,fail.
b_a_rp(A,N,Perm):-inlist(A,El),N1 is N-1,b_a_rp(A,N1,[El|Perm]).

build_all_perm:-
		read_str(A,_),b_a_p(A,[]).

inlistexlude([El|T],El,T).
inlistexlude([H|T],El,[H|Tail]):-inlistexlude(T,El,Tail).

b_a_p([],Perm1):-write_str(Perm1),nl,!,fail.
b_a_p(A,Perm):-inlistexlude(A,El,A1),b_a_p(A1,[El|Perm]).

build_all_razm:-
		read_str(A,_),K is 3,b_a_r(A,K,[]).
		
b_a_r(_,0,Perm1):-write_str(Perm1),nl,!,fail.
b_a_r(A,N,Perm):-inlistexlude(A,El,_),N1 is N-1,b_a_r(A,N1,[El|Perm]).

sub_set([],[]).
sub_set([H|Sub_set],[H|Set]):-sub_set(Sub_set,Set).
sub_set(Sub_set,[_|Set]):-sub_set(Sub_set,Set).
pr_subset:-read_str(A,_),sub_set(B,A),write_str(B),nl,fail.
qa:-not(pr_subset),write(yes),!;write(no).


sochet([],0,_):-!.
sochet([H|Sub_set],K,[H|Set]):-K1 is K-1,sochet(Sub_set,K1,Set).
sochet(Sub_set,K,[_|Set]):-sochet(Sub_set,K,Set).
pr_sochet:-read_str(A,_),read(K),sochet(B,K,A),write_str(B),nl,fail.

sochet_p([],0,_):-!.
sochet_p([H|Sub_set],K,[H|Set]):-K1 is K-1,sochet_p(Sub_set,K1,[H|Set]).
sochet_p(Sub_set,K,[_|Set]):-sochet_p(Sub_set,K,Set).
pr_sochet_p:-read_str(A,_),read(K),sochet_p(B,K,A),write_str(B),nl,fail.

inlist([],_):-fail.
inlist([X|_],X).
inlist([_|T],X):-inlist(T,X).

%7Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в которых ровно две буквы a. Вывод в файл.

task7:-see('D:/prologue/PrologLabFilp/LR14/7_9i.txt'),read_list_str(A),elbyindex(A,0,A1),elbyindex(A,1,K1),name(K,K1),seen,
	tell('D:/prologue/PrologLabFilp/LR14/7_9o.txt'),
	not(b_a_rp(A1,K,[])),nl,!,
	told,
	see('D:/prologue/PrologLabFilp/LR14/7_9o.txt'),read_list_str(List),seen,
	tell('D:/prologue/PrologLabFilp/LR14/7_9o.txt'),onlytwoa(List,Res),write_list_str(Res),told.
	
onlytwoa(List,List1):-onlytwoa(List,List1,[]).
onlytwoa([],G,G):-!.
onlytwoa([H|T],List1,Temp):-smallainstr(H,Kol),Kol =:= 2,!,append(Temp,[H],Temp1),onlytwoa(T,List1,Temp1);onlytwoa(T,List1,Temp).

smallainstr(L,N):-smallainstr(L,0,N).
smallainstr([],N,N):-!.
smallainstr([H|T],I,N):-(H is 97->I1 is I+1,smallainstr(T,I1,N),!;smallainstr(T,I,N)).