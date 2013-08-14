% Generate rules
% Below is easy way to write, but does not scale since you have to manually add each slot
%setlist(0, S) v setlist(1, S) v setlist(2, S) v setlist(3, S) v setlist(4, S) :- song(S).
setlist(T, S) :- not -setlist(T, S), time(T), song(S).
-setlist(T, S) :- setlist(T, SS), S != SS, time(T), song(S), song(SS).

% Defining predicates
switch_guitars(T, TT) :- setlist(T, S), setlist(TT, SS), eightstring(S), jackson(SS), TT = T+1.
switch_guitars(T, TT) :- setlist(T, S), setlist(TT, SS), jackson(S), eightstring(SS), TT = T+1.

% Weak constraint: switch guitars as little as possible
:~ switch_guitars(T, TT), TT = T+1.

% Hard constraint: do not switch guitars between first and second number
:- switch_guitars(0, 1).
% Hard constraint: play each song only once
:- setlist(T, S), setlist(TT, S), T != TT.
