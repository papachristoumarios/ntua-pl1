import sys

with open(sys.argv[1]) as f:
    lines = f.read().splitlines()

winners, losers = [], []

class Team:
    def __init__(self, text):
        self.name, agones, efage, evale = line.split(' ')
        self.agones = int(agones)
        self.efage = int(efage)
        self.evale = int(evale)

    __str__ = lambda self: self.name

for i, line in enumerate(lines):
    if i == 0: N = int(line)
    else:
        t = Team(line)
        winners.append(t)

while winners != [] or losers != []:
    # get the losers
    tmp = []
    losers = []
    for w in winners:
        if w.agones == 1: losers.append(w)
        else: tmp.append(w)
    winners = tmp

    for w, l in zip(winners, losers):
        x = l.efage
        print('{}-{} {}-{}'.format(w, l, x + 1, x))
        w.agones -= 1
        w.evale = w.evale - x - 1
