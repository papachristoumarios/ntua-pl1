#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
#include <climits>
#include <map>
#include <utility>
using namespace std;
#define MAXN 1000
#include <tuple>
char grid[MAXN+2][MAXN+2];
int depth[MAXN + 2][MAXN + 2];

typedef tuple<int,int> tl;
vector< tl > v;

vector < tl > Neighbors(tl k){
	vector < tl > neig;
	int a=get<0>(k); 
	int b=get<1>(k);
	if (grid[a-1][b] != 'x') neig.push_back(tl(a-1,b));
	if (grid[a][b-1] != 'x') neig.push_back(tl(a,b-1));
	if (grid[a+1][b] != 'x') neig.push_back(tl(a+1,b));
	if (grid[a][b+1] != 'x') neig.push_back(tl(a,b+1));
	return neig;
}

int M; 
int N;
void printGrid() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      cout << grid[i][j];
    }
    cout << endl;
  }
}


bool safe() {
  for (int i = 1; i <= N; i++) {
    for (int j = 1; j <= M; j++) {
      if(grid[i][j]=='*'){return false;}
    }
    
  }
return true;
}

int solution(){

	int time=0;
	int flag=1; int flag1=1;
	vector < tl > ne;
	while(flag==1 && flag1==1){	
		printGrid();
		
		for (int i=1; i<=N; i++){
			for (int j=1; j<=M; j++){
				tl k=tl(i,j);
				flag1=0;
				if((grid[i][j]=='+' || grid[i][j]=='-') && depth[i][j]==time){
					flag1=1;				
					vector<tl> neig=Neighbors(k);
					for (tl kl:neig){
						int a=get<0>(kl);
						int b=get<1>(kl);
						if(grid[a][b]!='x' && grid[a][b]=='.'){
								grid[a][b]=grid[i][j];
								depth[a][b]=time+1;
		
						}
						else if (grid[a][b]==grid[i][j]) continue;
						else if ((grid[i][j]=='+' || grid[i][j]=='-') && (grid[a][b]=='+' || grid[a][b]=='-') && grid[a][b]!=grid[i][j]){
						  ne.push_back(tl(a,b));						
							flag=0;
						}
					}
		
				}
			
			}
		}
		time=time+1;
	}
	if (flag==0){
		for (int i=0; i<ne.size(); i++){
			int a=get<0>(ne[i]);
			int b=get<1>(ne[i]);
			grid[a][b]='*';
		}
		cout<<"kaboom"<<'\n';
	}
	return time;
}



int main(){
cin >> N >> M;
for (int i = 1; i <= N; i++){
	for (int j = 1; j <= M; j++) {
      		cin >> grid[i][j];
		depth[i][j]=0;
	}
}



for (int i = 0; i < N; i++) { grid[i][0] = 'x'; grid[i][N + 1] = 'x'; }
for (int i = 0; i < M; i++) { grid[0][i] = 'x'; grid[M + 1][i] = 'x'; }

int time=solution();
cout<<time<<'\n';
if(safe()){
	cout<<"the world is safe"<<'\n';
}
printGrid();
}
