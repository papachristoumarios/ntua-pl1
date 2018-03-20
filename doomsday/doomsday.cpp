#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
#include <climits>
#include <map>
#include <utility>
using namespace std;
#define MAXN 1000
#define pb push_back
typedef pair< int, int > pii;
char grid[MAXN + 2][MAXN + 2];
int depth[MAXN + 2][MAXN + 2];
using namespace std;
vector<pii> special;
int N, M;

void printGrid() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << grid[i][j];
    }
    cout << endl;
  }
}

void printDepth() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << depth[i][j] << " ";
    }
    cout << endl;
  }
}

vector<pii> getNeighbors(pii p) {
  vector<pii> result;
  int u = p.first; int v = p.second;
  if (grid[ u-1 ][v] != 'x') result.pb( make_pair ( u-1, v ));
  if (grid[ u ][v-1] != 'x') result.pb(make_pair ( u, v-1 ));
  if (grid[u+1] [v] != 'x') result.pb(make_pair ( u+1, v ));
  if (grid[u][v+1] != 'x') result.pb(make_pair ( u, v+1 ));
  return result;
}

int bfs() {
  // initialize bfs
  int u, v, i, j;
  queue<pii> q;

  // add starting points to queue
  for (pii p : special) {
    u = p.first;
    v = p.second;
    depth[u][v] = 0;
    q.push(p);
  }

  int opt = INT_MAX;
  printDepth();
  // traverse graph
  while (!q.empty()) {

    if (opt != INT_MAX) return opt;
    cout << "Step" << endl;
    printGrid();
    printDepth();
    cout << endl;


    pii p = q.front();
    q.pop();
    u = p.first;
    v = p.second;
    vector<pii> neigh = getNeighbors(p);
    for (pii qq : neigh) {
      i = qq.first;
      j = qq.second;

      cout << "Neighbors of " << u << " " << v << " is " << i << " " << j << endl;

      // if cell is not visited and not an X

      if (depth[i][j] == -1 && grid[i][j] != 'x') {
        grid[i][j] = grid[u][v];
        depth[i][j] = depth[u][v] + 1;
        q.push( qq );
      }

      // if someone has visited before that is a + or a -
      else if (depth[i][j] > 0 && grid[i][j] == grid[u][v]) continue;
      else if (depth[i][j] > 0 && grid[i][j] != grid[u][v]) {
          cout << "kaboom" << endl;
          depth[i][j] = depth[u][v] + 1;
          opt = min ( opt, depth[i][j] ); // the child has been visited earlier
          grid[i][j] = '*';
      }

    }


  }
  return opt;
}


int main(void) {

  // read input
  cin >> N >> M;
  for (int i = 1; i <= N; i++)
    for (int j = 1; j <= M; j++) {
      cin >> grid[i][j];
      depth[i][j] = -1; // mark not visited
      // sources for bfs
      if (grid[i][j] == '+' || grid[i][j] == '-') special.pb ( make_pair ( i, j ));
    }

    for (int i = 0; i < N; i++) { grid[i][0] = 'x'; grid[i][N + 1] = 'x'; }
    for (int i = 0; i < M; i++) { grid[0][i] = 'x'; grid[M + 1][i] = 'x'; }

    int opt = bfs();
    cout << opt << endl;
    printGrid();

}
