%HELPFUL &&&&&&&&&&&&&&&&&&&&&&&&

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).


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

%Задание 14 Беседует трое друзей: Белокуров, Рыжов, Чернов. Брюнет сказал Белокурову: “Любопытно, что один из нас блондин, другой брюнет, третий - рыжий, но ни у кого цвет волос не соответствует фамилии”. Какойцвет волос у каждого из друзей?

inlist([],_):-fail.
inlist([X|_],X).
inlist([_|T],X):-inlist(T,X).

task14:- Hairs=[_,_,_],
inlist(Hairs,[belokurov,_]),
inlist(Hairs,[chernov,_]),
inlist(Hairs,[rizhov,_]),
inlist(Hairs,[_,ginger]),
inlist(Hairs,[_,blond]),
inlist(Hairs,[_,brunette]),
not(inlist(Hairs,[belokurov,blond])),
not(inlist(Hairs,[chernov,brunette])),
not(inlist(Hairs,[rizhov,ginger])),
write(Hairs),!.

%Задание 15 Три подруги вышли в белом, зеленом и синем платьях и туфлях. Известно, что только у Ани цвета платья и туфлей совпадали. Ни туфли,ни платье Вали не были белыми. Наташа была в зеленых туфлях. Определить цвета платья и туфель на каждой из подруг.

task15:- Vertidos=[_,_,_],
inlist(Vertidos,[ann,_,_]),
inlist(Vertidos,[valya,_,_]),
inlist(Vertidos,[natasha,_,_]),
inlist(Vertidos,[_,white,_]),
inlist(Vertidos,[_,green,_]),
inlist(Vertidos,[_,blue,_]),
inlist(Vertidos,[_,_,white]),
inlist(Vertidos,[_,_,green]),
inlist(Vertidos,[_,_,blue]),
inlist(Vertidos,[natasha,_,green]),
not(inlist(Vertidos,[valya,white,white])),
not(inlist(Vertidos,[natasha,green,_])),
write(Vertidos),!.

%Задание 16 На заводе работали три друга: слесарь, токарь и сварщик. Их фамилии Борисов, Иванов и Семенов. У слесаря нет ни братьев, ни сестер. Он
%самый младший из друзей. Семенов, женатый на сестре Борисова, старше токаря. Назвать фамилии слесаря, токаря и сварщика.

task16:- Workers = [_,_,_],
%inlist(Workers,[slesar,borisov,kolvo_bratev,vozrast,rodstvennik]),
inlist(Workers,[slesar,_,0,0,_]),
inlist(Workers,[tokar,_,_,1,_]),
inlist(Workers,[svarshick,_,_,_,_]),
inlist(Workers,[_,semenov,_,2,borisov]),
inlist(Workers,[_,ivanov,_,_,_]),
inlist(Workers,[_,borisov,1,_,_]),
inlist(Workers,[slesar,Who1,_,_,_]),
inlist(Workers,[tokar,Who2,_,_,_]),
inlist(Workers,[svarshick,Who3,_,_,_]),
write('slesar = '),write(Who1),nl,write('tokar = '),write(Who2),nl,write('svarshick = '),write(Who3),!.

%Задание 17 В бутылке, стакане, кувшине и банке находятся молоко, лимонад, квас и вода. Известно, что вода и молоко не в бутылке, 
%сосуд с лимонадом находится между кувшином и сосудом с квасом, в банке - не лимонад и не вода. Стакан находится около банки и сосуда с молоком.
%Как распределены эти жидкости по сосудам.

%B справа от A в C
right(_,_,[_]):-fail.
right(A,B,[A|[B|_]]).
right(A,B,[_|List]):-right(A,B,List).

%B слева от A в C
left(_,_,[_]):-fail.
left(A,B,[B|[A|_]]).
left(A,B,[_|List]):-left(A,B,List).

%B справаслеваслевасправа(около) A в C
next(A,B,List):-right(A,B,List).
next(A,B,List):-left(A,B,List).

task17:- Drinks=[_,_,_,_],
inlist(Drinks,[bottle,_]),
inlist(Drinks,[glass,_]),
inlist(Drinks,[kuvshin,_]),
inlist(Drinks,[jar,_]),
inlist(Drinks,[_,leche]),
inlist(Drinks,[_,lemonade]),
inlist(Drinks,[_,kvas]),
inlist(Drinks,[_,agua]),
not(inlist(Drinks,[bottle,leche])),
not(inlist(Drinks,[bottle,agua])),
not(inlist(Drinks,[jar,lemonade])),
not(inlist(Drinks,[jar,agua])),
right([kuvshin,_],[_,lemonade],Drinks),
right([_,lemonade],[_,kvas],Drinks),
next([glass,_],[jar,_],Drinks),
next([glass,_],[_,leche],Drinks),

write(Drinks),!.

/*
Задание 18 Воронов, Павлов, Левицкий и Сахаров – четыре талантли-
вых молодых человека. Один из них танцор, другой художник, третий-певец,
а четвертый-писатель. О них известно следующее: Воронов и Левицкий си-
дели в зале консерватории в тот вечер, когда певец дебютировал в сольном
концерте. Павлов и писатель вместе позировали художнику. Писатель написал
биографическую повесть о Сахарове и собирается написать о Воронове. Воро-
нов никогда не слышал о Левицком. Кто чем занимается?*/

task18:- Cheloveki=[_,_,_,_],
inlist(Cheloveki,[pavlov,_]),
inlist(Cheloveki,[levicki,_]),
inlist(Cheloveki,[saharov,_]),
inlist(Cheloveki,[voronov,_]),
inlist(Cheloveki,[_,balarin]),
inlist(Cheloveki,[_,pinter]),
inlist(Cheloveki,[_,cantante]),
inlist(Cheloveki,[_,escritor]),
not(inlist(Cheloveki,[saharov,escritor])),
not(inlist(Cheloveki,[voronov,escritor])),
not(inlist(Cheloveki,[voronov,cantante])),
not(inlist(Cheloveki,[pavlov,escritor])),
not(inlist(Cheloveki,[pavlov,pinter])),
not(inlist(Cheloveki,[voronov,pinter])),

write(Cheloveki),!.
/*
%Задание 19 Три друга заняли первое, второе, третье места в соревнова-
ниях универсиады. Друзья разной национальности, зовут их по-разному, и лю-
бят они разные виды спорта. Майкл предпочитает баскетбол и играет лучше,
чем американец. Израильтянин Саймон играет лучше теннисиста. Игрок в кри-
кет занял первое место. Кто является австралийцем? Каким спортом увлека-
ется Ричард?*/

task19:- Atletas = [_,_,_],
inlist(Atletas,[maikl,_,baloncesto,_]),
inlist(Atletas,[saimon,israeli,_,_]),
inlist(Atletas,[_,_,cricket,primero]),
inlist(Atletas,[richard,_,_,_]),
inlist(Atletas,[_,_,tenis,_]),
inlist(Atletas,[_,americano,_,_]),
inlist(Atletas,[_,australiano,_,_]),
inlist(Atletas,[_,_,_,segundo]),
inlist(Atletas,[_,_,_,tercero]),
not(inlist(Atletas,[maikl,americano,_,_])),
not(inlist(Atletas,[saimon,_,tenis,_])),

inlist(Atletas,[Who1,australiano,_,_]),
inlist(Atletas,[richard,_,Who2,_]),
write('El australiano es '),write(Who1),nl,write('Richard es aficionado al '),write(Who2),!.
/*
%20. Вариант 3 Три друга – Петр, Роман и Сергей учатся на математическом,
физическом и химическом факультетах университета. Если Петр математик,
то Сергей не физик. Если Роман не физик, то Петр – математик. Если Сергей
не математик, то Роман – химик. Где учится Роман?*/
/* Перепишем условие
Вариант 3 Три друга – Петр, Роман и Сергей учатся на математическом,
физическом и химическом факультетах университета. Если Петр математик,
то Сергей химик. Если Роман химик, то Петр – математик. Если Сергей
физик, то Роман – химик. Где учится Роман?*/

task20:- Amigos = [_,_,_],
%inlist(Amigos,[pyotr,roman,sergey,matem,fisica,quimia]),
inlist(Amigos,[pyotr,_]),
inlist(Amigos,[roman,_]),
inlist(Amigos,[sergey,_]),
inlist(Amigos,[_,matem]),
inlist(Amigos,[_,fisica]),
inlist(Amigos,[_,quimia]),
(not(inlist(Amigos,[pyotr,matem]));inlist(Amigos,[sergey,fisica])),
((inlist(Amigos,[roman,fisica]));(inlist(Amigos,[pyotr,matem]))),
((inlist(Amigos,[sergey,matem]));inlist(Amigos,[roman,fisica])),
inlist(Amigos,[roman,Who1]),
write(Amigos),nl,write('roman lee '),write(Who1),!.

