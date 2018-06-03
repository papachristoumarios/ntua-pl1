#include <iostream>
#include <vector>
#include <cstdio>
typedef long long ull;
using namespace std;
vector<ull> a;
ull N, x;

ull gcd(ull a, ull b)
{
    if (a == 0) return b;
    else return gcd(b%a, a);
}

ull lcm(ull a, ull b) {
  ull d = gcd(a,b);
  ull y = a / d;
  return y * b;
}

void printvec(vector<ull> &v) {
  for (unsigned int i = 0; i < v.size(); i++) cout << v[i] << " ";
  cout << endl;
}

int main(int argc, char **argv) {
  FILE *fptr = fopen(argv[1], "r");
  a.push_back((ull) 1);
  if (!fptr) return -1;

  fscanf(fptr, "%llu", &N);
  for (ull i = 0; i < N; i++) {
    fscanf(fptr, "%llu", &x);
    a.push_back(  x );
  }

  a.push_back((ull) 1);
  fclose(fptr);

  printvec(a);

  vector<ull> left_lcm( (int) (N + 2),  1);
  vector<ull> right_lcm( (int) (N + 2), 1);

  for (ull i = 1; i <= N + 1; i++) {
    left_lcm[i] = lcm(left_lcm[i-1], a[i]);
  }

  for (ull i = N; i >= 0; i--) {
    right_lcm[i] = lcm(right_lcm[i + 1], a[i]);
  }

  printvec(left_lcm);
  printvec(right_lcm);

  int min_index = -1;
  ull minimum = left_lcm[N];
  ull tmp = -1;

  for ( ull i = 1; i <= N; i ++ ) {
    tmp = lcm ( left_lcm [ i-1 ] , right_lcm [ i+1 ]);
    if (tmp < minimum) {
      minimum = tmp;
      min_index = (int) i;
    }
  }

  cout << minimum << " " << ( min_index == -1 ? 0 : min_index  ) << endl;
}
