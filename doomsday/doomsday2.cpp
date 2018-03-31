#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <string>
#include <climits>
#include <algorithm>
#define MAXN 1000

using namespace std;

typedef pair<int, int> pii;

int depth[MAXN][MAXN];
vector<string> grid;
int N, M;
queue<pii> q;

int bfs () {
  int opt = INT_MAX;

  while (!q.empty()) {



  }

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
       q.push( make_pair (i, j));
       depth[i][j] = 0;
     }
   }

 }


}
