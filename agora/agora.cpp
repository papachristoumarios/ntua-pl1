#include <iostream>
#include <vector>
#include <cstdio>
typedef unsigned long long ull;
using namespace std;
vector<ull> a;
int N, x;

ull gcd(ull a, ull b)
{
    if (a == 0) return b;
    else return gcd(b%a, a);
}

ull lcm(ull a, ull b) { return (a * b) / gcd(a,b); }

void printvec(vector<ull> &v) {
  for (unsigned int i = 0; i < v.size(); i++) cout << v[i] << " ";
  cout << endl;
}

int main(int argc, char **argv) {
  FILE *fptr = fopen(argv[1], "r");
  a.push_back(1);
  if (!fptr) return -1;

  fscanf(fptr, "%d", &N);
  for (int i = 0; i < N; i++) {
    fscanf(fptr, "%d", &x);
    a.push_back( (ull) x );
  }

  a.push_back(1);
  fclose(fptr);

  vector<ull> left_lcm( N + 2,  1);
  vector<ull> right_lcm( N + 2, 1);

  for ( int i = 1; i <= N + 1; i++) {
    left_lcm[i] = lcm(left_lcm[i-1], a[i]);
  }

  for (int i = N; i >= 0; i--) {
    right_lcm[i] = lcm(right_lcm[i + 1], a[i]);
  }

  int min_index = -1;
  ull minimum = left_lcm[N];
  ull tmp = -1;

  for ( int i = 1; i <= N; i ++ ) {
    tmp = lcm ( left_lcm [ i-1 ] , right_lcm [ i+1 ]);
    if (tmp < minimum) {
      minimum = tmp;
      min_index = i;
    }
  }

  cout << minimum << " " << ( min_index == -1 ? 0 : min_index  ) << endl;
}
