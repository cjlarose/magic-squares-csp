// +----------+--------------+------------------+-----------+
// | A        | F            | 34-A-C-F         | C         |
// | G        | D            | E                | 34-D-E-G  |
// | B+C-G    | A+B-E        | 34-A-B-D         | D+E+G-B-C |
// | 34-A-B-C | 34-A-B-D+E-F | 2*A+B+C+D-E+F-34 | B         |
// +----------+--------------+------------------+-----------+
//
// For each parameter:
//   compute any derived positions
//   boundary checks on derived positions
//   uniqueness checks on free and derived positions
//
// TODO: use a stack of bitvectors for taken
// TODO: remove explicit matrix (use just locals)
use std::convert::TryInto;

fn main() {
    let mut square = [[0; 16]; 16];
    let mut taken = [false; 16];

    for a in 1..17 {
        square[0][0] = a;
        taken[a - 1] = true;

        for b in 1..17 {
            square[3][3] = b;

            if taken[b - 1] { continue; }
            taken[b - 1] = true;

            for c in 1..17 {
                square[0][3] = c;

                let a30: isize = 34 - (a as isize) - (b as isize) - (c as isize);
                if a30 < 1 || a30 > 16 { continue; }
                square[3][0] = a30.try_into().unwrap();

                if taken[c - 1] || taken[square[3][0] - 1] ||
                   square[3][0] == c {
                    continue;
                }
                taken[c - 1] = true;
                taken[square[3][0] - 1] = true;

                for d in 1..17 {
                    square[1][1] = d;

                    let a22: isize = 34 - (a as isize) - (b as isize) - (d as isize);
                    if a22 < 1 || a22 > 16 { continue; }
                    square[2][2] = a22.try_into().unwrap();

                    if taken[d - 1] || taken[square[2][2] - 1] || square[2][2] == d {
                        continue;
                    }
                    taken[d - 1] = true;
                    taken[square[2][2] - 1] = true;

                    for e in 1..17 {
                        square[1][2] = e;

                        let a21: isize = (a as isize) + (b as isize) - (e as isize);
                        if a21 < 1 || a21 > 16 { continue; }
                        square[2][1] = a21.try_into().unwrap();

                        if taken[e - 1] || taken[square[2][1] - 1] || square[2][1] == e {
                            continue;
                        }

                        taken[e - 1] = true;
                        taken[square[2][1] - 1] = true;

                        for f in 1..17 {
                            square[0][1] = f;

                            let a02: isize = 34 - (a as isize) - (c as isize) - (f as isize);
                            if a02 < 1 || a02 > 16 { continue; }
                            square[0][2] = a02.try_into().unwrap();

                            let a31: isize = 34 - (a as isize) - (b as isize) - (d as isize) + (e as isize) - (f as isize);
                            if a31 < 1 || a31 > 16 { continue; }
                            square[3][1] = a31.try_into().unwrap();

                            let a32: isize = 2 * (a as isize) + (b as isize) + (c as isize) + (d as isize) - (e as isize) + (f as isize) - 34;
                            if a32 < 1 || a32 > 16 { continue; }
                            square[3][2] = a32.try_into().unwrap();

                            if taken[f - 1] || taken[square[0][2] - 1] || taken[square[3][1] - 1] || taken[square[3][2] - 1] ||
                               square[0][2] == f ||
                               square[3][1] == f || square[3][1] == square[0][2] ||
                               square[3][2] == f || square[3][2] == square[3][1] || square[3][2] == square[0][2] {
                                continue;
                            }

                            taken[f - 1] = true;
                            taken[square[0][2] - 1] = true;
                            taken[square[3][1] - 1] = true;
                            taken[square[3][2] - 1] = true;

                            for g in 1..17 {
                                square[1][0] = g;

                                let a13: isize = 34 - (d as isize) - (e as isize) - (g as isize);
                                if a13 < 1 || a13 > 16 { continue; }
                                square[1][3] = a13.try_into().unwrap();

                                let a20: isize = (b as isize) + (c as isize) - (g as isize);
                                if a20 < 1 || a20 > 16 { continue; }
                                square[2][0] = a20.try_into().unwrap();

                                let a23: isize = (d as isize) + (e as isize) + (g as isize) - (b as isize) - (c as isize);
                                if a23 < 1 || a23 > 16 { continue; }
                                square[2][3] = a23.try_into().unwrap();

                                if taken[g - 1] || taken[square[1][3] - 1] || taken[square[2][0] - 1] || taken[square[2][3] - 1] { continue; }

                                if g == square[1][3] || g == square[2][0] || g == square[2][3] ||
                                   square[1][3] == square[2][0] || square[1][3] == square[2][3] ||
                                   square[2][0] == square[2][3] {
                                    continue;
                                }

                                println!("{}",
                                       format!("{} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {}",
                                               square[0][0],
                                               square[0][1],
                                               square[0][2],
                                               square[0][3],
                                               square[1][0],
                                               square[1][1],
                                               square[1][2],
                                               square[1][3],
                                               square[2][0],
                                               square[2][1],
                                               square[2][2],
                                               square[2][3],
                                               square[3][0],
                                               square[3][1],
                                               square[3][2],
                                               square[3][3]));
                            }

                            taken[f - 1] = false;
                            taken[square[0][2] - 1] = false;
                            taken[square[3][1] - 1] = false;
                            taken[square[3][2] - 1] = false;
                        }

                        taken[e - 1] = false;
                        taken[square[2][1] - 1] = false;
                    }

                    taken[d - 1] = false;
                    taken[square[2][2] - 1] = false;
                }

                taken[c - 1] = false;
                taken[square[3][0] - 1] = false;
            }

            taken[b - 1] = false;
        }

        taken[a - 1] = false;
    }
}
