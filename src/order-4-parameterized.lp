% Based on http://www.gaspalou.fr/magic-squares/enumeration.htm#13
% +----------+--------------+------------------+-----------+
% | A        | F            | 34-A-C-F         | C         |
% | G        | D            | E                | 34-D-E-G  |
% | B+C-G    | A+B-E        | 34-A-B-D         | D+E+G-B-C |
% | 34-A-B-C | 34-A-B-D+E-F | 2*A+B+C+D-E+F-34 | B         |
% +----------+--------------+------------------+-----------+
size(4).
rowIndex(1..N) :- size(N).
colIndex(1..N) :- size(N).
matrixCoord(I, J) :- rowIndex(I), colIndex(J).
matrixEntry(1..N**2) :- size(N).

%% Generate
% Let A..G take on exactly one value
freeCoord(1,1).
freeCoord(1,2).
freeCoord(1,4).
freeCoord(2,1).
freeCoord(2,2).
freeCoord(2,3).
freeCoord(4,4).
{ content(X,I,J) : matrixEntry(X) } = 1 :- freeCoord(I,J).

% derived values
content(X,1,3) :- X = 34-A-C-F, matrixEntry(X), content(A,1,1), content(C,1,4), content(F,1,2).
content(X,2,4) :- X = 34-D-E-G, matrixEntry(X), content(D,2,2), content(E,2,3), content(G,2,1).
content(X,3,1) :- X = B+C-G, matrixEntry(X), content(B,4,4), content(C,1,4), content(G,2,1).
content(X,3,2) :- X = A+B-E, matrixEntry(X), content(A,1,1), content(B,4,4), content(E,2,3).
content(X,3,3) :- X = 34-A-B-D, matrixEntry(X), content(A,1,1), content(B,4,4), content(D,2,2).
content(X,3,4) :- X = D+E+G-B-C, matrixEntry(X), content(D,2,2), content(E,2,3), content(G,2,1), content(B,4,4), content(C,1,4).
content(X,4,1) :- X = 34-A-B-C, matrixEntry(X), content(A,1,1), content(B,4,4), content(C,1,4).
content(X,4,2) :- X = 34-A-B-D+E-F, matrixEntry(X), content(A,1,1), content(B,4,4), content(D,2,2), content(E,2,3), content(F,1,2).
content(X,4,3) :- X = (2*A)+B+C+D+E+F-34, matrixEntry(X), content(A,1,1), content(B,4,4), content(C,1,4), content(D,2,2), content(E,2,3), content(F,1,2).

%% Test
% each number appears exactly once in the matrix
:- { content(X,I,J) : matrixCoord(I, J) } != 1, matrixEntry(X).

% a stable model must assign exactly one value to each entry
:- { content(X,I,J) : matrixEntry(X) } != 1, matrixCoord(I,J).

%% Display
#show content/3.
