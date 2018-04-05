
#include <iostream>
#include <string>
#include <queue>
#include <vector>
#include <algorithm>
#include <climits>
#include <map>
#include <utility>
#include <fstream>
using namespace std;
#define MAXN 1000
#define pb push_back
typedef pair< int, int > pii;
char grid[MAXN + 2][MAXN + 2];
int matter[MAXN + 2][MAXN + 2];
int anti_matter[MAXN + 2][MAXN + 2];
using namespace std;
queue<pii> q;
map<pii, pii> parent;
int N, M;
vector<pii> mut;

void printGrid() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << grid[i][j];
    }
    cout << endl;
  }
}

void printDepth() {
  cout << "matter " << endl;
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << matter[i][j] << " ";
    }
    cout << endl;
  }

  cout << endl << "antimatter" << endl;
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << anti_matter[i][j] << " ";
    }
    cout << endl;
  }


}

vector<pii> getNeighbors(pii p) {
  vector<pii> result;
  int u = p.first; int v = p.second;
  if (u > 0 && grid[ u-1 ][v] != 'X') result.pb( make_pair ( u-1, v ));
  if (v > 0 && grid[ u ][v-1] != 'X') result.pb(make_pair ( u, v-1 ));
  if (u <= N && grid[u+1] [v] != 'X') result.pb(make_pair ( u+1, v ));
  if (v <= M && grid[u][v+1] != 'X') result.pb(make_pair ( u, v+1 ));
  return result;
}

bool kaboom(int u, int v, int i, int j) {
  return ((
    (grid[u][v] == '+' && grid[i][j] == '-') ||
    (grid[u][v] == '-' && grid[i][j] == '+'))

  );
}

int bfs() {
  int u, v, i, j;
  int opt = INT_MAX;

  while (!q.empty()) {


    pii p = q.front();
    q.pop();
    u = p.first;
    v = p.second;
    if (depth[u][v] == opt ) continue;

    vector<pii> neigh = getNeighbors(p);


    for (pii qq : neigh) {
      i = qq.first;
      j = qq.second;

      if (grid[u][v] == grid[i][j]) continue;
      else if (grid[i][j] == '.') {
        depth[i][j] = depth[u][v] + 1;
        grid[i][j] = grid[u][v];

        q.push (qq );
      }
      else if (kaboom(u,v,i,j)) {
        opt = min (opt, depth[u][v] + 1);
        //depth[i][j] = opt;
        stars.push (qq );


      }
    }
  }

  while (!stars.empty()) {
    pii p = stars.front();
    stars.pop();
    grid[p.first][p.second] = '*';
  }
  return opt;
}



int main(int argc, char **argv) {

  queue<pii> qm, qa;

  ifstream myReadFile;

  myReadFile.open(argv[1]);
  string output;
  N = 0;
  M = 0;
  if (myReadFile.is_open()) {
    while (!myReadFile.eof()) {

      myReadFile >> output;
      if (N == 0) M = (int) output.size();
      N++;
      for (int j = 1; j <= M; j++) {
        grid[N][j] = output[j - 1];
        if (grid[N][j] == '+' || grid[N][j] == '-') {
          q.push ( make_pair (N, j));
          depth[N][j] = 0;
        }
        else depth[N][j] = -1;
      }
    }
  }
  N--;
  myReadFile.close();

  for (int i = 0; i < M+1; i++) { grid[i][0] = 'X'; grid[i][M + 1] = 'X'; }
  for (int i = 0; i < N+1; i++) { grid[0][i] = 'X'; grid[N + 1][i] = 'X'; }

  }

  printGrid();

  if (opt == INT_MAX) {
    cout << "the world is saved" << endl;
  } else cout << opt << endl;

  printGrid();


}
