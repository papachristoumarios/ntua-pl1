#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <vector>
#include <climits>
using namespace std;
#define MAXN 1000
#define pb push_back
typedef pair< int, int > pii;
char grid[MAXN + 2][MAXN + 2];
int depth[MAXN + 2][MAXN + 2];
using namespace std;

int N, M;
vector<pii> mut;

struct node_t {
	pii data;
	struct node_t *next;
};

typedef struct node_t node;

struct queue_t {
	node *front,*rear;
};

typedef struct queue_t queue;

queue create() {
	queue q;
	q.front = NULL;
	q.rear = NULL;
	return q;
}

void enqueue(queue &q, pii x) {
	node *p = new node;
	p->data = x;
	p->next = NULL;
	if (q.front == NULL) q.front = p;
	else q.rear->next = p;
	q.rear = p;
}

bool dequeue(queue &q, pii &x) {
	node *p;
	if (q.front == NULL) {
		return false;
	} else {
		p = q.front;
		x = q.front->data;
		if (q.front == q.rear) {
			q.rear = NULL;
		}
		q.front = q.front->next;
		delete p;
		return true;
	}
}

bool isEmpty(queue &q) {
	if (q.front == NULL && q.rear == NULL) {
		return true;
	}
	return false;
}


pii peek(queue &q) {
	return q.front->data;
}

queue q;

inline int min (int a, int b) {
  if (a <= b) return a;
  return b;
}

void printGrid() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      printf("%c", grid[i][j]);
    }
    printf("\n");
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
  queue stars = create();
  pii p;

  while (!isEmpty(q)) {

    dequeue(q, p);

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

        enqueue(q, qq);

      }
      else if (kaboom(u,v,i,j)) {
        opt = min (opt, depth[u][v] + 1);
        enqueue(stars, qq);
      }
    }
  }


  while (!isEmpty(stars)) {
    dequeue(stars, p);
    grid[p.first][p.second] = '*';
  }
  return opt;
}




int main(int argc, char **argv) {


  FILE *myReadFile;
  char *output = NULL;
  q = create();
  myReadFile = fopen(argv[1], "r");

  size_t len = 0;
  ssize_t read;

  if (!myReadFile) return -1;

  N = 0;
  M = 0;

  while ((read = getline(&output, &len, myReadFile)) != -1) {
    if (N == 0) M = strlen(output) - 1;
    N++;
    for (int j = 1; j <= M; j++) {
      if (grid[N][j] == '\n') break;
      grid[N][j] = output[j - 1];
      if (grid[N][j] == '+' || grid[N][j] == '-') {
        enqueue(q, make_pair (N, j));
        depth[N][j] = 0;
      }
      else depth[N][j] = -1;
    }
  }

  for (int i = 0; i < M+1; i++) { grid[i][0] = 'X'; grid[i][M + 1] = 'X'; }
  for (int i = 0; i < N+1; i++) { grid[0][i] = 'X'; grid[N + 1][i] = 'X'; }


	fclose(myReadFile);

  int opt = bfs();
  if (opt == INT_MAX) {
    printf("the world is saved\n");
  } else printf("%d\n", opt);

  printGrid();


}
