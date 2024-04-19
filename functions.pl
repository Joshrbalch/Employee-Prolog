% Predicates for querying the database
list(Op, Ref, List) :-
    findall([X, Y, Z], (pay(X, Y, Z), comparison(Op, Z, Ref)), List).

count(Op, Ref, Count) :-
    list(Op, Ref, List),
    length(List, Count).

min(Op, Ref, Min) :- (
    (Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  min_list(List, Min));
    (Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  min_list(List, Min));
    (Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  min_list(List, Min));
    (Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  min_list(List, Min));
    (Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  min_list(List, Min));
    (Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  min_list(List, Min))
    ).

max(Op, Ref, Max) :- (
    (Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  max_list(List, Max));
    (Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  max_list(List, Max));
    (Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  max_list(List, Max));
    (Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  max_list(List, Max));
    (Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  max_list(List, Max));
    (Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  max_list(List, Max))
    ).

total(Op, Ref, Total) :-
    list(Op, Ref, List),
    sum_pay(List, Total).

avg(Op, Ref, Avg) :-
    total(Op, Ref, Total),
    count(Op, Ref, Count),
    Avg is Total / Count.

comparison('eq', Value, Ref) :- Value =:= Ref.
comparison('ne', Value, Ref) :- Value =\= Ref.
comparison('gt', Value, Ref) :- Value > Ref.
comparison('ge', Value, Ref) :- Value >= Ref.
comparison('lt', Value, Ref) :- Value < Ref.
comparison('le', Value, Ref) :- Value =< Ref.

% Min and Max functions are broken. They should be fixed.
min_pay([Pay], Pay).
min_pay([[_, _, Pay]|Tail], Min) :-
    min_pay(Tail, Temp),
    Min is min(Temp, Pay).

max_pay([Pay], Pay).
max_pay([[_, _, Pay]|Tail], Max) :-
    max_pay(Tail, Temp),
    Max is max(Temp, Pay).

sum_pay([], 0).
sum_pay([[_, _, Pay]|Tail], Sum) :-
    sum_pay(Tail, Temp),
    Sum is Temp + Pay.
