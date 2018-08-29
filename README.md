# Programming Languages I

Programming Languages assignments for ECE NTUA course [_Programming Languages I_](https://courses.softlab.ntua.gr/pl1/2018a/)

Team comprises of:

- Marios Papachristou (ECE NTUA)
- Dimitris Kelesis (ECE NTUA)

## Editorial

### Problem Sets

The problems are located under `problem-sets` directory

### Implementation

The problems were solved in the following languages:

 1. C++11
 2. Python 3.x
 3. Standard ML of New Jersey (smlnj) v110.78
 4. SWI Prolog 6.6
 5. Java w/ OpenJDK 1.8.0_181

The problems were graded through a grading system.

### Solutions

#### Agora

Since `lcm(a, b, c) = lcm(lcm(a, b), c)` we can use a prefix array which contains the LCMs from left to right and from right to left. Then with a simple O(n) traversal of the list we can determine the lcm without the given village as `lcm_without[i] = lcm(left_lcm[i - 1], right_lcm[i + 1])`. The LCMS are computed using Euclid's Algorithm as `lcm(x, y) = (x / gcd(x, y))*y`. The complexity of computing the gcd is `T(a, b) = O(log(max(a, b)))` the total complexity is `O(n  log(max(a[i])))`.

#### Doomsday

This is a classical case for using a graph search algorithm, in our case BFS. We initialize a queue `q` to contain all the `+` in the map and then call the BFS graph search algorithm. If a "kaboom" happens then the "kaboom depth" is `opt = min (opt, depth[u][v] + 1)`. We also have a `stars` queue to keep the positions of the collisitons. We push the conflicting pairs to `stars` and after BFS finishes, we fill in the map with the collisions `*`. The time complexity of BFS is `O(N * M)` hence the total complexity of our algorithm.

#### Pistes

This problem is, from a computational complexity scope, a bit hard. There's no polynominal time algorithm to solve it. The naive approach which checks all solutions has complexity `O(N! * M^2)` which is pretty bad. So we should reduce the state-space to something smaller (e.g. `2^N` instead of `N!`). One very useful observation is that for any permutation of `x1, ..., xN` the optimum (max number of stars) does not change. That means that we can define a hash function `h` for hashing a state as `h(S) = Σ_{x is visited} 2 << x` and use a HashSet to remember the visited states (regardless of permutation). This drops the overall complexity to `O(2^N * M^2)` since we are exploring the powerset of states and not all permutations. Note that checking the validity of each state requires `O(M^2)`.



## License

The code in this repository is licensed under the MIT License:

Copyright (C) 2018 Papachristou Marios and Dimitris Kelesis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
