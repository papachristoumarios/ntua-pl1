import sys
from collections import deque

grid = []
depth = {}



with open(sys.argv[1], 'r') as infile:
    grid = infile.readlines()

grid = [list(line.strip('\n')) for line in grid]
N, M = len(grid), len(grid[0])

q = deque()

for i in range(N):
    for j in range(M):
        if grid[i][j] == '+' or grid[i][j] == '-':
            q.append((i,j))
            depth[i,j] = 0
        else:
            depth[i,j] = -1

opt = 213213213
stars = deque()


while q:
    p = q.popleft()
    u, v = p


    if depth[u, v] == opt: continue

    result = []
    if u > 0 and grid[u-1][v] != 'X':
        result.append((u-1, v))
    if v > 0 and grid[u][v-1] != 'X':
        result.append((u, v-1))
    if u < N - 1 and grid[u+1][v] != 'X':
        result.append((u+1, v))
    if v < M - 1 and grid[u][v+1] != 'X':
        result.append((u, v+1))

    for qq in result:
        i, j = qq
        if grid[u][v] == grid[i][j]:
            continue
        elif grid[i][j] == '.':
            depth[i, j] = depth[u, v] + 1
            grid[i][j] = grid[u][v]
            q.append(qq)
        elif (grid[u][v] == '+' and grid[i][j] == '-') or (grid[u][v] == '-' and grid[i][j] == '+'):
            opt = min([opt, depth[u, v] + 1])
            stars.append(qq)

while stars:
    i, j = stars.pop();
    grid[i][j] = '*'

if opt == 213213213:
    print('the world is saved')
else:
    print(str(opt))

for i in range(N):
    print(''.join(grid[i]))
