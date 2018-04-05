#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <string>
#include <climits>
#include <map>
#include <algorithm>
#define MAXN 1000
#define pb push_back

using namespace std;

typedef pair<int, int> pii;

int depth[MAXN][MAXN];
vector<string> grid;
int N, M;
queue<pii> q;
map<pii, pii> parent;

void printGrid() {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      cout << grid[i][j];
    }
    cout << endl;
  }
}


vector<pii> getNeighbors(pii p) {
  vector<pii> result;
  int u = p.first; int v = p.second;
  if (u > 0 && grid[ u-1 ][v] != 'X') result.pb( make_pair ( u-1, v ));
  if (v > 0 && grid[ u ][v-1] != 'X') result.pb(make_pair ( u, v-1 ));
  if (u < N - 1 && grid[u+1] [v] != 'X') result.pb(make_pair ( u+1, v ));
  if (v < M - 1 && grid[u][v+1] != 'X') result.pb(make_pair ( u, v+1 ));
  return result;
}


bool kaboom(int u, int v, int i, int j) {

  return ((
    (grid[u][v] == '+' && grid[i][j] == '-') ||
    (grid[u][v] == '-' && grid[i][j] == '+'))
  );
}

void printDepth() {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      cout << depth[i][j] << " ";
    }
    cout << endl;
  }
}

int bfs () {
  int opt = INT_MAX;

  while (!q.empty()) {
    pii p = q.front(); q.pop();
    int i = p.first;
    int j = p.second;
    int u = parent[p].first;
    int v = parent[p].second;

    if (opt != INT_MAX && depth[u][v] + 1 > opt) break;

    if (kaboom(u,v,i,j)) {
      opt = depth[u][v] + 1;
      grid[i][j] = '*';
    }
    else if (grid[i][j] == '.'){
      depth[i][j] = 1 + depth[u][v];
      grid[i][j] = grid[u][v];
      vector<pii> neigh = getNeighbors(p);

      for (pii qq : neigh) {
        parent[qq] = p;
        q.push(qq);
      }
    }





  }

  return opt;

}


int main(int argc, char **argv) {

  ifstream myReadFile;

  myReadFile.open(argv[1]);
  string output;
  while (!myReadFile.eof()) {
      myReadFile >> output;
      grid.push_back ( output );
  }


 myReadFile.close();

 N = (int) grid.size() - 1;
 M = (int) grid[0].size();

 for (int i = 0; i < N; i++) {
   for (int j = 0; j < M; j++) {
     depth[i][j] = -1;
     if ( grid[i][j] == '+' || grid[i][j] == '-') {
       pii p =  make_pair (i, j);
       q.push( p );
       parent[p] = p;
       depth[i][j] = 0;
     }
   }

 }

 printGrid();
 printDepth();
 cout << endl;
 bfs();
 printDepth();
 cout << endl;
 printGrid();


}
