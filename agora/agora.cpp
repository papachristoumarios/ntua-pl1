#include <iostream>
#include <vector>
#include <cstdio>
using namespace std;
vector<int> a;
int N, x;

int gcd(int a, int b)
{
    if (a == 0) return b;
    else return gcd(b%a, a);
}

int lcm(int a, int b) { return (a * b) / gcd(a,b); }

void printvec(vector<int> &v) {
  for (unsigned int i = 0; i < v.size(); i++) cout << v[i] << " ";
  cout << endl;
}

int main(int argc, char **argv) {
  FILE *fptr = fopen(argv[1], "r");
  a.push_back(1);
  if (fptr) {
    fscanf(fptr, "%d", &N);
    for (int i = 0; i < N; i++) {
      fscanf(fptr, "%d", &x);
      a.push_back( x );
    }
  }
  a.push_back(1);

  vector<int> left_lcm( N + 2,  1);
  vector<int> right_lcm( N + 2, 1);

  for ( int i = 1; i <= N + 1; i++) {
    left_lcm[i] = lcm(left_lcm[i-1], a[i]);
  }

  for (int i = N; i >= 0; i--) {
    right_lcm[i] = lcm(right_lcm[i + 1], a[i]);
  }

  int min_index = -1;
  int minimum = left_lcm[N];
  int tmp;

  printvec(a);
  printvec(left_lcm);
  printvec(right_lcm);

  for ( int i = 1; i <= N; i ++ ) {
    tmp = lcm ( left_lcm [ i-1 ] , right_lcm [ i+1 ]);
    if (tmp < minimum) {
      minimum = tmp;
      min_index = i;
    }
  }

  cout << minimum << " " << ( min_index == -1 ? 0 : min_index) << endl;
}
