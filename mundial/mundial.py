import sys

import itertools
with open(sys.argv[1]) as f:
    lines = f.read().splitlines()

winners, losers = [], []

def check_perm(win, lose):
    for w, l in zip(win, lose):
        if w.evale < l.efage:
            return False
    return True


class Team:
    def __init__(self, text):
        self.name, agones, evale, efage = line.split(' ')
        self.agones = int(agones)
        self.efage = int(efage)
        self.evale = int(evale)

    __str__ = lambda self: self.name

for i, line in enumerate(lines):
    if i == 0: N = int(line)
    else:
        t = Team(line)
        winners.append(t)

while winners != []:
    # get the losers
    tmp = []
    losers = []
    for w in winners:
        if w.agones == 1: losers.append(w)
        else: tmp.append(w)
    winners = tmp

    if len(winners) < 2:
        break

    for winners_perm in itertools.permutations(winners):

        if check_perm(winners_perm, losers):
            print('Valid permutation!')
            for w, l in zip(winners_perm, losers):
                print('{}-{} {}-{}'.format(w, l, l.efage, l.evale))
                w.agones -= 1
                w.evale -= l.efage
                w.efage -= l.evale


            winners = winners_perm
            break

    if len(winners) == 2:
        t1, t2 = winners
        print('{}-{} {}-{}'.format(t1, t2, t1.evale, t1.efage))
        break
