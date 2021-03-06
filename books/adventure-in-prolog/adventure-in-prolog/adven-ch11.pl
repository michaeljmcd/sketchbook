dynamic here/1.
dynamic have/1.
dynamic(loc_list/2).

room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

loc_list([desk], office).

append([], X, X).
append([H|T1],X,[H|T2) :- append(T1,X,T2).

location(X,Y) :-
    loc_list(List, Y),
    member(X, List).

add_thing(NewThing, Container, NewList) :-
    loc_list(OldList, Container),
    NewList = [NewThing|OldList].

door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

edible(apple).
edible(crackers).
tastes_yucky(broccoli).
turned_off(flashlight).

here(kitchen).

connect(X,Y) :- door(X,Y).
connect(X,Y) :- door(Y,X).

list_things(Place) :-
    location(X, Place),
    tab(2),
    write(X),
    nl,
    fail.
list_things(_).

list_connections(Place) :-
    connect(Place, X),
    tab(2),
    write(X),
    nl,
    fail.
list_connections(_).

look :-
    here(Place),
    write('You are in the '), write(Place), nl,
    write('You can see:'), nl,
    list_things(Place),
    write('You can go to:'),nl,
    list_connections(Place).

goto(Place) :-
    can_go(Place),
    move(Place),
    look.

can_go(Place) :-
    here(X),
    connect(X, Place).
can_go(_) :-
    write('You can''t get there from here.'), nl, fail.

move(Place) :-
    retract(here(_)),
    asserta(here(Place)).

take(X) :-
    can_take(X),
    take_object(X).

can_take(Thing) :-
    here(Place),
    location(Thing, Place).
can_take(Thing) :-
    write('There is no '), write(Thing),
    write(' here.'),
    nl, fail.

take_object(X) :-
    retract(location(X, _)),
    asserta(have(X)),
    write('taken'), nl.

is_contained_in(T1,T2) :-
    location(T1,T2).
is_contained_in(T1,T2) :-
    location(X,T2),
    is_contained_in(T1,X).
