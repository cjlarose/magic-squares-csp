% Based on http://www.gaspalou.fr/magic-squares/programs.htm
size(3).
rowIndex(1..N) :- size(N).
colIndex(1..N) :- size(N).
matrixCoord(I, J) :- rowIndex(I), colIndex(J).
matrixEntry(1..N**2) :- size(N).

%% Generate
% Let the entries 1,1 and 1,2 take on exactly one value
{ content(X,I,J) : matrixEntry(X) } = 1 :- I = 1, J = 1..2.

% Derive all other entries
% +----------+------+----------+
% | A        | B    | 15-A-B   |
% | 20-2*A-B | 5    | 2*A+B-10 |
% | A+B-5    | 10-B | 10-A     |
% +----------+------+----------+
content(X,1,3) :- X = 15 - A - B, matrixEntry(X), content(A,1,1), content(B,1,2).
content(X,2,1) :- X = 20 - (2*A) - B, matrixEntry(X), content(A,1,1), content(B,1,2).
content(5,2,2).
content(X,2,3) :- X = (2*A) + B - 10, matrixEntry(X), content(A,1,1), content(B,1,2).
content(X,3,1) :- X = A + B - 5, matrixEntry(X), content(A,1,1), content(B,1,2).
content(X,3,2) :- X = 10 - B, matrixEntry(X), content(B,1,2).
content(X,3,3) :- X = 10 - A, matrixEntry(X), content(A,1,1).

%% Test
% each number appears exactly once in the matrix
:- { content(X,I,J) : matrixCoord(I, J) } != 1, matrixEntry(X).

% a stable model must assign exactly one value to each entry
:- { content(X,I,J) : matrixEntry(X) } != 1, matrixCoord(I, J).

%% Display
#show content/3.
