# Magic Squares CSP

This project is a collection of attempts to enumerate [magic squares][magic-squares] using various [solvers][solvers].

[magic-squares]: https://en.wikipedia.org/wiki/Magic_square
[solvers]: https://en.wikipedia.org/wiki/Solver

## Results

These results were collected on a 2017 Macbook Pro with a 2.9 GHz Intel Core i7 processor. Timing was performed using Docker for Mac with the provided Docker images. Wall clock times are reported. An em dash (&mdash;) is used to indicate that I didn't wait long enough to get a result.

### Conjure

```sh
order=3
./bin/conjure $order
```

n  | Time (s) | Solutions / s
--- | --- | ---
3 | 2.724 | 2.937
4 | 27.523 | 255.786
5 | &mdash; | &mdash;

### Clingo

[`magic.lp`][magic.lp] encodes the Magic Squares problem using the most straightforward encoding: it specifies that each matrix entry contains exactly one integer from 1..n<sup>2</sup>, that each of those integers appears exactly once in the matrix, and that the entries in each row, column, and diagonal sum to the magic constant.

[magic.lp]: https://github.com/cjlarose/magic-squares-csp/blob/master/src/magic.lp

```sh
order=3
cat <(echo 'size('"$order"').') src/magic.lp | ./bin/clingo 0
```

n | Time (s) | Solutions / s
--- | --- | ---
3 | 0.004 | 2,000
4 | 256.61 | 27.435
5 | &mdash; | &mdash;

### Clingo (parameterized)

The problem encodings used in the files `src/order-*-parameterized` differ from the classical encoding. The encoding allows a subset of matrix entries (called parameters) to vary freely and derives the remaining entries' values based on the values of the selected subset. For example, the order 4 magic square is encoded as follows:

```
+----------+--------------+------------------+-----------+
| A        | F            | 34-A-C-F         | C         |
| G        | D            | E                | 34-D-E-G  |
| B+C-G    | A+B-E        | 34-A-B-D         | D+E+G-B-C |
| 34-A-B-C | 34-A-B-D+E-F | 2*A+B+C+D-E+F-34 | B         |
+----------+--------------+------------------+-----------+
```

This particular definition is based on ["Enumeration Programs" by Francis Gaspalou][gaspalou].

[gaspalou]: http://www.gaspalou.fr/magic-squares/enumeration.htm#13

Unfortunately, this encoding causes an explosion of rules during grounding. For example,

```sh
./bin/gringo --text < src/order-4-parameterized.lp | wc -l
```

yields 5,069,955 rules. By comparison, the classical encoding,

```sh
cat <(echo 'size(4).') src/magic.lp | ./bin/gringo --text | wc -l
```

yields only 125 rules.

```sh
order=3
./bin/clingo 0 < src/order-"$order"-parameterized.lp
```

n | Time (s) | Solutions / s
--- | --- | ---
3 | 0.006 | 1,333
4 | &mdash; | &mdash;
