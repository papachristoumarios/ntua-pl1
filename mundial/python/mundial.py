

import sys
import itertools
from copy import copy
from collections import deque


def valid(win, los, temp):
    f = (win[2] >= los[3] and win[3] >= los[2])
    h = (los[3] != los[2])
    g = (win[2] - los[3]) < (win[3] - los[2])
    w = win[1] - 1
    if w == 1:
        apotelesma = g
    else:
        apotelesma = True
    if temp == 0:
        return (f and h and apotelesma)
    elif temp == 1:
        return (f and h)


def my_perm(p, l):
    w = [tuple(z) for z in p]
    tmp = set(w)
    n = len(w)
    r = [[]]
    tmp = set(w)
    flag = False
    for s in r:
        for x in tmp - set(s):
            t = s + [x]
            if valid_permu(t, l, n):
                r.append(t)
            if len(t) == n:
                flag = True
                yield [list(z) for z in t]

    if not flag:
        for t in itertools.permutations(p, len(l)):
            yield t


def valid_permu(w, l, m):
    n = min(len(w), len(l))
    for i in range(n):
        if not valid(w[i], l[i], m == 4):
            return False
    return True


def find_valid_matcharisma(new_winners, typoma, N):

    Loser = []
    Winner = []
    for i in new_winners:
        if(i[1] == 1):
            jj = copy(i)
            Loser.append(jj)
        else:
            jj = copy(i)
            Winner.append(jj)

    if (N == 2):
        # print(len(Loser))
        t1, t2 = Loser
        if (t1[2] == t2[3] and t1[3] == t2[2] and t1[2] != t2[2]):
            typoma.append([t1[0], t2[0], t1[2], t1[3]])
            for i in typoma:
                print('{}-{} {}-{}'.format(i[0], i[1], i[2], i[3]))
            return (True)
    # print(N)
    for x in itertools.permutations(Winner, len(Loser)):
        temp = list(zip(x, Loser))
        typoma1 = typoma[:]
        typoma2 = []
        new_winners1 = []

        for i in range(len(temp)):
            los = temp[i][1]
            nik = temp[i][0]
            #print(nik.onoma, los.onoma)
            if N == 4:
                isvalid = valid(nik, los, 1)
            else:
                isvalid = valid(nik, los, 0)
            if (not isvalid):
                # print("breokes")
                break
            typoma2.append([nik[0], los[0], los[3], los[2]])
            nik1 = copy(nik)
            los1 = copy(los)
            nik1[1] = nik1[1] - 1
            nik1[2] = nik1[2] - los1[3]
            nik1[3] = nik1[3] - los1[2]
            new_winners1.append(nik1)

        if not isvalid:
            continue

        # print(typoma1)
        if (len(new_winners1) == N / 2):
            typoma1 = typoma1 + typoma2
            result = find_valid_matcharisma(new_winners1, typoma1, N / 2)
            if (result):
                return (True)


if __name__ == '__main__':
    with open(sys.argv[1]) as f:
        lines = f.read().splitlines()
    N = int(lines[0])
    lista = []
    for i in range(N):
        kati1 = lines[i + 1].split(' ')
        kati2 = [kati1[0], int(kati1[1]), int(kati1[2]), int(kati1[3])]
        lista.append(kati2)
    find_valid_matcharisma(lista, [], N)
