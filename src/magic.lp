magicConstant(M) :- size(N), M = (N * (N ** 2 + 1)) / 2.
rowIndex(1..N) :- size(N).
colIndex(1..N) :- size(N).
matrixCoord(I, J) :- rowIndex(I), colIndex(J).
matrixEntry(1..N**2) :- size(N).
mainDiagonalCoord(I, J) :- I = J, rowIndex(I), colIndex(J).
skewDiagonalCoord(I, J) :- J = N - I + 1, rowIndex(I), size(N).

%% Generate
% each number appears exactly once in the matrix
{ content(X,I,J) : matrixCoord(I, J) } = 1 :- matrixEntry(X).

% an entry contains one number
{ content(X,I,J) : matrixEntry(X) } = 1 :- matrixCoord(I, J).

%% Test
% rows sum to the magic constant
:- M != #sum { X : content(X, I, J), colIndex(J) }, rowIndex(I), magicConstant(M).
% columns sum to the magic constant
:- M != #sum { X : content(X, I, J), rowIndex(I) }, colIndex(J), magicConstant(M).
% diagonals sum to the magic constant
:- M != #sum { X : content(X, I, J), mainDiagonalCoord(I, J) }, magicConstant(M).
:- M != #sum { X : content(X, I, J), skewDiagonalCoord(I, J) }, magicConstant(M).

%% Display
#show content/3.
