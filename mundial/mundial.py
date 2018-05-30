import sys

with open(sys.argv[1]) as f:
    lines = f.read().splitlines()

winners, losers = [], []

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
    winners = sorted(tmp, key=lambda x: x.evale)
    losers = sorted(losers, key=lambda x: x.efage)

    for w, l in zip(winners, losers):
        if (w.evale < l.efage):
            print('I am so sad!')
        print('{}-{} {}-{}'.format(w, l, l.efage, l.evale))
        w.agones -= 1
        w.evale -= l.efage
        w.efage -= l.evale

    if (winners == []):
        t1, t2 = losers
        print('{}-{} {}-{}'.format(t1, t2, t1.evale, t1.efage))
