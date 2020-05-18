% Presupposes elements to be node(Priority, Data)
% and the heap itself to be bheap(Size, [Node])
% make-bheap([H|T]) :-

% n(Priority, Data)
n(_, _).

% Sentinel
nil.

pq(nil).
pq(_).
pq(_, pq(_)).
% Element, Left, Right
pq(_, pq(_), pq(_)).

% pq_insert(P, pq(nil), R) :-
%     R = pq(P), !.
% 
% pq_insert(P, pq(P2), R) :-
%     (P > P2, R = pq(P, pq(P2)), !);
%     (R = pq(P2, pq(P)), !).
% 
% pq_insert(P, pq(P2, P3), R) :-
%     (P >= P2, R = pq(P, P2, P3) , !) ; 
%     (pq_insert(P, P3, X), R = pq(P2, X), !) ;
%     R = pq(P2, P3, pq(P)), !.

pq_insert(P, pq(nil), R) :- R = pq(P).

