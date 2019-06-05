% Based on http://www.gaspalou.fr/magic-squares/enumeration.htm#13
size(4).
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
% derived values
% +----------+--------------+------------------+-----------+
% | A        | F            | 34-A-C-F         | C         |
% | G        | D            | E                | 34-D-E-G  |
% | B+C-G    | A+B-E        | 34-A-B-D         | D+E+G-B-C |
% | 34-A-B-C | 34-A-B-D+E-F | 2*A+B+C+D-E+F-34 | B         |
% +----------+--------------+------------------+-----------+

:- X != 34-A-C-F, content(X,1,3), matrixEntry(X), content(A,1,1), content(C,1,4), content(F,1,2).
:- X != 34-D-E-G, content(X,2,4), matrixEntry(X), content(D,2,2), content(E,2,3), content(G,2,1).
:- X != B+C-G, content(X,3,1), matrixEntry(X), content(B,4,4), content(C,1,4), content(G,2,1).
:- X != A+B-E, content(X,3,2), matrixEntry(X), content(A,1,1), content(B,4,4), content(E,2,3).
:- X != 34-A-B-D, content(X,3,3), matrixEntry(X), content(A,1,1), content(B,4,4), content(D,2,2).
:- X != D+E+G-B-C, content(X,3,4), matrixEntry(X), content(D,2,2), content(E,2,3), content(G,2,1), content(B,4,4), content(C,1,4).
:- X != 34-A-B-C, content(X,4,1), matrixEntry(X), content(A,1,1), content(B,4,4), content(C,1,4).
:- X != 34-A-B-D+E-F, content(X,4,2), matrixEntry(X), content(A,1,1), content(B,4,4), content(D,2,2), content(E,2,3), content(F,1,2).
:- X != (2*A)+B+C+D+E+F-34, content(X,4,3), matrixEntry(X), content(A,1,1), content(B,4,4), content(C,1,4), content(D,2,2), content(E,2,3), content(F,1,2).

%% Display
#show content/3.
