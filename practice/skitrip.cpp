#include <cstdio>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;
typedef pair<int, int> pii;

bool cmp(pii a, pii b) {
    if (a.second == b.second) {
      return a.first < b.first;
    } else return a.second < b.second;

}

// O(nlogn) solution
int main() {
  int N;
  scanf("%d", &N);

  vector<pii> Y;
  int x;

  for (int i = 0; i < N; i++) {
    scanf("%d", &x);
    Y.push_back( make_pair(i, x) );
  }

  sort(Y.begin(), Y.end(), cmp);

  int k = Y[0].first;
  int opt = INT_MIN;
  int dist = INT_MIN;

  for (int j = 0; j < N; j++) {
    dist = Y[j].first - k;
    opt = max(dist, opt);
    k = min(k, Y[j].first);
  }

  printf("%d\n", opt);

}

int linear_solution(vector<int>& Y, int N) {
  vector<int> L, R;

  // L vector
  int curmin = INT_MAX;

  for (int i = 0; i  < N; i++ ) {
    if (Y[i] < curmin) {
      L.push_back(i);
      curmin = Y[i];
    }
  }

  // R vector
  int curmax = INT_MIN;
  for (int i = N - 1; i >= 0; i--) {
    if (Y[i] > curmax) {
      R.push_back(i);
      curmax = Y[i];
    }
  }

  unsigned int i = 0;
  unsigned int j = R.size();

  // TODO complete

}
