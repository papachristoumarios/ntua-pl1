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
int depth[MAXN + 2][MAXN + 2];
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
  // initialize bfs
  int u, v, i, j;

  int opt = INT_MAX;
  // printDepth();
  // traverse graph
  while (!q.empty()) {

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

      if (opt < INT_MAX && depth[i][j] > opt) return opt;
      else if (kaboom(u,v,i,j)) {
        opt = min(opt, depth[u][v] + 1);
        grid[i][j] = '*';
      }
      else if ((grid[u][v] != 'X' && depth[i][j] == -1) || (grid[i][j] = '+' || grid[i][j] == '-') ) {
        depth[i][j] = depth[u][v] + 1;
        if (grid[u][v] != 'X') grid[i][j] = grid[u][v];
        q.push ( qq );
      }




    }


  }



  return opt;
}




int main(int argc, char **argv) {

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

  for (int i = 0; i < N; i++) { grid[i][0] = 'X'; grid[i][M + 1] = 'X'; }
  for (int i = 0; i < M; i++) { grid[0][i] = 'X'; grid[N + 1][i] = 'X'; }


  int opt = bfs();
  if (opt == INT_MAX) {
    cout << "the world is saved" << endl;
  } else cout << opt << endl;

  printGrid();

}
