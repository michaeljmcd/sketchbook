% Presupposes elements to be node(Priority, Data)
% and the heap itself to be bheap(Size, [Node])
% make-bheap([H|T]) :-

module('data-structs', [pq/1,
pq/2,pq/3, pq_insert/3
]).

% n(Priority, Data)
n(_, _).

% Sentinel
nil.

pq(nil).
pq(_).
pq(_, pq(_)).
% Element, Left, Right
pq(_, pq(_), pq(_)).

% Inserting into an empty tree, the new value is always the root.
pq_insert(NewValue, pq(nil), Result) :- 
    Result = pq(NewValue), !.

% If the new value is less than the root, swap them.
pq_insert(NewValue, pq(Root), Result) :-
    NewValue < Root,
    Result = pq(NewValue, pq(Root)).

% Otherwise, add the new value as the left tree of the root.
pq_insert(NewValue, pq(Root), Result) :-
    NewValue >= Root,
    Result = pq(Root, pq(NewValue)).

% If the tree has a left tree, but no right add the element on the right.
pq_insert(NewValue, pq(Root, Left), Result) :-
    NewValue < Root,
    Result = pq(NewValue, Left, pq(Root)).

pq_insert(NewValue, pq(Root, Left), Result) :-
    NewValue >= Root,
    Result = pq(Root, Left, pq(NewValue)).

% What do we do if the node has a left and right subtree?
% In order to maintain the min-heap property, we need to look for 
% an available slot on the tree, starting from the left and then
% bubble it up until the new element is in the right spot.

pq_insert(NewValue, pq(Root, Left, Right), Result) :-
    (pq_binsert(NewValue, Left, NewLeft),
     Result = pq(Root, NewLeft, Right)) ;
    (pq_insert(NewValue, Right, NewRight),
     Result = pq(Root, Left, NewRight)) ;
    (pq_linsert(NewValue, Left, NewLeft),
     Result = pq(Root, NewLeft, Right)).

pq_binsert(NewValue, pq(Root, Left), Result) :-
    NewValue >= Root,
    Result = pq(Root, Left, pq(NewValue)).

pq_binsert(NewValue, pq(Root, Left), Result) :-
    NewValue < Root,
    Result = pq(NewValue, pq(NewValue), Left).

pq_binsert(NewValue, pq(Root, Left = pq(_, _, _), Right = pq(_, _, _)), Result) :-
    (pq_binsert(NewValue, Left, NewLeft = pq(NL, LL, LR)),
     NL < Root -> Result = pq(NL, pq(Root, LL, LR), Right) ;
        Result = pq(Root, NewLeft, Right)).

pq_binsert(_, pq(nil), _) :- fail.

pq_binsert(_, pq(_, _, _), _) :- fail.

pq_linsert(NewValue, pq(Root), Result) :-
    Result = pq(Root, pq(NewValue)).

pq_linsert(NewValue, pq(Root, Right), Result) :-
    Result = pq(Root, pq(NewValue), Right).

pq_linsert(NewValue, pq(Root, Left, Right), Result) :-
    pq_linsert(NewValue, Left, NewLeft),
    Result = pq(Root, NewLeft, Right).

:- begin_tests('pq').

test(insert_empty) :- 
    pq_insert(100, pq(nil), X),
    X = pq(100).

test(insert_single_node) :-
    pq_insert(50, pq(100), Y),
    Y = pq(50, pq(100)).

test(pq_insert_unbalanced) :-
    pq_insert(100, pq(50, pq(20)), X),
    X = pq(50, pq(20), pq(100)).

:- end_tests('pq').
