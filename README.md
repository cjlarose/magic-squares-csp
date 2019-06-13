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

```sh
order=3
cat <(echo 'size('"$order"').') src/magic.lp | ./bin/clingo 0
```

n | Time (s) | Solutions / s
--- | --- | ---
3 | 0.004 | 2,000
4 | 256.61 | 27.435
5 | &mdash; | &mdash;
