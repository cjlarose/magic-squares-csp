size(3).
magicConstant(M) :- size(N), M = (N * (N ** 2 + 1)) / 2.

%% Generate
% no number is repeated in the matrix
{ content(X,1..N,1..N) } = 1 :- X = 1..N**2, size(N). 

% an entry contains one number
{ content(1..N**2,I,J) } = 1 :- I = 1..N, J = 1..N, size(N).

%% Test
% rows sum to the magic constant
:- M != #sum { X : content(X, I, 1..N) }, I = 1..N, size(N), magicConstant(M).
% columns sum to the magic constant
:- M != #sum { X : content(X, 1..N, J) }, J = 1..N, size(N), magicConstant(M).
% diagonals sum to the magic constant
:- M != #sum { X : content(X, I, I), I = 1..N }, size(N), magicConstant(M).
:- M != #sum { X : content(X, I, N-I+1), I = 1..N }, size(N), magicConstant(M).

%% Display
#show content/3.
