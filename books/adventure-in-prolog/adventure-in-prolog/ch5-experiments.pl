where_food(X,Y) :- 
    location(X,Y),
    edible(X).

connect(X,Y) :- door(X,Y).
connect(X,Y) :- door(Y,X).
