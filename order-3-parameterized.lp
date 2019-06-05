% Based on http://www.gaspalou.fr/magic-squares/programs.htm
size(3).
rowIndex(1..N) :- size(N).
colIndex(1..N) :- size(N).
matrixCoord(I, J) :- rowIndex(I), colIndex(J).
matrixEntry(1..N**2) :- size(N).

%% Generate
% each number appears exactly once in the matrix
{ content(X,I,J) : matrixCoord(I, J) } = 1 :- matrixEntry(X).

% an entry contains one number
{ content(X,I,J) : matrixEntry(X) } = 1 :- matrixCoord(I, J).

%% Test
% fix the center value
:- X != 5, content(X,2,2).

% derived values
:- X != 15 - A - B, content(X,1,3), matrixEntry(X), content(A, 1, 1), content(B, 1, 2).
:- X != 20 - (2 * A) - B, content(X,2,1), matrixEntry(X), content(A, 1, 1), content(B, 1, 2).
:- X != (2 * A) + B - 10, content(X,2,3), matrixEntry(X), content(A, 1, 1), content(B, 1, 2).
:- X != A + B - 5, content(X,3,1), matrixEntry(X), content(A, 1, 1), content(B, 1, 2).
:- X != 10 - B, content(X,3,2), matrixEntry(X), content(B, 1, 2).
:- X != 10 - A, content(X,3,3), matrixEntry(X), content(A, 1, 1).

%% Display
#show content/3.
