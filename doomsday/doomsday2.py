import sys

grid = []
depth = {}

def printGrid(N):
	for i in range(N):
		print(''.join(grid[i]))
    
		



def getNeigh(i,j):
	result=[]
	if(i>0 and grid[i-1][j]!='x'):
		result.append([i-1,j])
	if(j>0 and grid[i][j-1]!='x'):
		result.append([i,j-1])
	if(i<N-1 and grid[i+1][j]!='x'):
			result.append([i+1,j])
	if(j<M-1 and grid[i][j+1]!='x'):
		result.append([i,j+1])
	return result


def kaboom(u,v,i,j):
	return(( (grid[u][v] == '+' and grid[i][j]=='-') or (grid[u][v]=='-' and grid[i][j]=='+')) )



class Queue:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def enqueue(self, item):
        self.items.insert(0,item)

    def dequeue(self):
        return self.items.pop()

    def size(self):
        return len(self.items)

q=Queue()
stars=Queue()
def bfs():
	opt=432532532
	while(not q.isEmpty()):
		[u,v]=q.dequeue()
		if (depth[u,v]==opt):
			continue
		neig=getNeigh(u,v)
		for qq in neig:
			i=qq[0]
			j=qq[1]
			if(grid[u][v]==grid[i][j]):
				continue
			elif (grid[i][j]=='.'):
				depth[i,j] = depth[u,v] + 1
				grid[i][j] = grid[u][v]
				q.enqueue(qq)
			elif (kaboom(u,v,i,j)):
				opt = min([opt, depth[u,v]+1])
				stars.enqueue(qq)
	
	while(not stars.isEmpty()):
		[k,l]=stars.dequeue()
		grid[k][l]='*'
	return opt


with open(sys.argv[1], 'r') as infile:
    grid = infile.readlines()
grid = [list(line.strip('\n')) for line in grid]
N, M = len(grid), len(grid[0])

for i in range(N):
    for j in range(M):
        if grid[i][j] == '+' or grid[i][j] == '-':
            q.enqueue([i,j])
            depth[i,j] = 0
        else:
            depth[i,j] = -1


printGrid(N)
opt=bfs()
if (opt==432532532):
	print("the world is saved")
else:
	print (opt)
printGrid(N)
