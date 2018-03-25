// LCM of given range queries using Segment Tree
// taken from https://www.geeksforgeeks.org/range-lcm-queries/
#include <vector>
#include <cstdio>
#include <iostream>
using namespace std;

#define MAX 1000000
int tree[4*MAX];
vector<int> arr;

int gcd(int a, int b)
{
    if (a == 0) return b;
    else return gcd(b%a, a);
}

int lcm(int a, int b) { return (a * b) / gcd(a,b); }

void build(int node, int start, int end)
{
    if (start==end)
    {
        tree[node] = arr[start];
        return;
    }

    int mid = (start+end)/2;

    build(2*node, start, mid);
    build(2*node+1, mid+1, end);

    int left_lcm = tree[2*node];
    int right_lcm = tree[2*node+1];

    tree[node] = lcm(left_lcm, right_lcm);
}

int query(int node, int start, int end, int l, int r)
{
    if (end<l || start>r)
        return 1;

    if (l<=start && r>=end)
        return tree[node];

    int mid = (start+end)/2;
    int left_lcm = query(2*node, start, mid, l, r);
    int right_lcm = query(2*node+1, mid+1, end, l, r);
    return lcm(left_lcm, right_lcm);
}

int main(int argc, char **argv)
{
    int N, x, l, r;
    FILE *fptr = fopen(argv[1], "r");
    if (fptr) {
      fscanf(fptr, "%d", &N);
      for (int i = 0; i < N; i++) {
        fscanf(fptr, "%d", &x);
        arr.push_back( x );
      }
    }


    build(1, 0, N - 1);

    int minimum = query (1, 0, N - 1, 0, N - 1);
    int min_index = -1;
    int tmp;

    for (int i = 0; i < N; i++) {
      if (i == 0) {
        tmp = query (1, 0, N-1, 1, N - 1);
      }
      else if (i == N - 1)  {
        tmp = query (1, 0, N-1, 0, N - 2);
      }
      else {
        l = query(1, 0, N-1, 0, i - 1);
        r = query(1, 0, N -1, i + 1, N - 1);
        tmp = lcm (l, r);
      }

      if ( tmp < minimum ) {
        minimum = tmp;
        min_index = i;
      }
    }

    cout << minimum << " " << (min_index + 1) << endl;


    return 0;
}
