import sys
import itertools

def check_perm(win, lose):
    for w, l in zip(win, lose):
        if not w.evale > l.efage:
            return False
    return True


class Team:
    def __init__(self, text):
        self.name, agones, evale, efage = line.split(' ')
        self.agones = int(agones)
        self.efage = int(efage)
        self.evale = int(evale)

    __str__ = lambda self: self.name


if __name__ == '__main__':
    with open(sys.argv[1]) as f:
        lines = f.read().splitlines()

    winners, losers = [], []

    # initial winners and losers
    for i, line in enumerate(lines):
        if i == 0: N = int(line)
        else:
            t = Team(line)
            if t.agones == 1:
                losers.append(t)
            else:
                winners.append(t)

    # find start state for DFS

    stack = []

    for winners_perm in itertools.permutations(winners):
        if check_perm(winners_perm, losers):
            state = (winners_perm, losers)
            stack.append(state)
            break

    # DFS

    while stack != []:

        state = stack.pop()
        winners, losers = state

        if len(winners) == 0:
            x, y = losers
            print('{}-{} {}-{}'.format(x, y, x.evale, y.evale))
            break

        for w, l in zip(winners, losers):
            print('{}-{} {}-{}'.format(w, l, l.efage, l.evale))
            w.agones -= 1
            w.evale -= l.efage
            w.efage -= l.evale

        # split again

        tmp = []
        losers = []
        for w in winners:
            if w.agones == 1: losers.append(w)
            else: tmp.append(w)
        winners = tmp

        # children

        for winners_perm in itertools.permutations(winners):
            if check_perm(winners_perm, losers):
                new_state = (winners_perm, losers)
                stack.append(new_state)
                break
