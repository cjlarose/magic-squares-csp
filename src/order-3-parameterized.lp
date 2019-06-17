% Based on http://www.gaspalou.fr/magic-squares/programs.htm
size(3).
rowIndex(1..N) :- size(N).
colIndex(1..N) :- size(N).
matrixCoord(I, J) :- rowIndex(I), colIndex(J).
matrixEntry(1..N**2) :- size(N).

%% Generate
% Let the entry 1,1 take on any value
{ content(A,1,1) : matrixEntry(A) } = 1.

% Let the entry 1,2 take on any value not A
{ content(B,1,2) : B != A, matrixEntry(B), content(A,1,1) } = 1.

% Derive all other entries
% +----------+------+----------+
% | A        | B    | 15-A-B   |
% | 20-2*A-B | 5    | 2*A+B-10 |
% | A+B-5    | 10-B | 10-A     |
% +----------+------+----------+
{ content(X,1,3) : X = 15 - A - B, matrixEntry(X), content(A,1,1), content(B,1,2) } = 1.
{ content(X,2,1) : X = 20 - (2*A) - B, matrixEntry(X), content(A,1,1), content(B,1,2) } = 1.
content(5,2,2).
{ content(X,2,3) : X = (2*A) + B - 10, matrixEntry(X), content(A,1,1), content(B,1,2) } = 1.
{ content(X,3,1) : X = A + B - 5, matrixEntry(X), content(A,1,1), content(B,1,2) } = 1.
{ content(X,3,2) : X = 10 - B, matrixEntry(X), content(B,1,2) } = 1.
{ content(X,3,3) : X = 10 - A, matrixEntry(X), content(A,1,1) } = 1.

%% Test
% each number appears exactly once in the matrix
:- { content(X,I,J) : matrixCoord(I, J) } != 1, matrixEntry(X).

%% Display
#show content/3.
