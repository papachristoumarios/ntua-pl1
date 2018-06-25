import sys
import copy
import itertools
import math as m

def check_perm(win, lose):
    for w, l in zip(win, lose):
        if not w.evale > l.efage:
            # print('Ivalid on ', w, l, w.evale, l.efage)
            return False
    return True


class Team:
    def __init__(self, text):
        self.name, agones, evale, efage = line.split(' ')
        self.agones = int(agones)
        self.efage = int(efage)
        self.evale = int(evale)

    __str__ = lambda self: self.name
    __repr__ = lambda self: self.name

class State:

    def __init__(self, w, l):
        self.winners = list(copy.deepcopy(w))
        self.losers = list(copy.deepcopy(l))

    def split_teams(self):
        new_winners, new_losers = [], []

        for w in self.winners:
            if w.agones == 1:
                new_losers.append(w)
            else:
                new_winners.append(w)
        return new_winners, new_losers

    def play_together(self):
        matches = []
        for i in range(len(self.winners)):
            w, l = self.winners[i], self.losers[i]
            w.agones -= 1
            match = (w, l, l.efage, l.evale)
            matches.append(match)
            w.evale -= l.efage
            w.efage -= l.evale
            self.winners[i] = w
        self.matches = matches



    def __repr__(self):
        return str(self.matches)

    def print_matches(self):
        for r in self.matches:
            w, l, x, y = r
            print('{}-{} {}-{}'.format(w,l,x,y))

    def is_final(self):
        if self.winners != []:
            return False
        else:
            x, y = self.losers
            if x.evale > x.efage:
                self.winners, self.losers = [x], [y]
            else:
                self.winners, self.losert = [y] , [x]
            self.play_together()
            # print(self.matches)
            assert(len(self.matches) == 1)
            return True


def solve(state):
    parent = {}
    stack = [state]
    parent[state] = None
    valid = False

    while stack != []:

        current = stack.pop()

        if current.is_final():
            # print('Final')
            # print(current)
            # print('true')
            valid = True
            return current, parent

        current.play_together()
        # print('Current is ', current.winners, current.losers)
        # print('Winners:')
        # for w in current.winners:
        #     print(w, w.evale, w.efage)
        # print('Losers')
        # for l in current.losers:
            # print(l, l.evale, l.efage)
        # print('Matches ', current.matches)

        new_winners, new_losers = current.split_teams()

        for winners_ in itertools.permutations(new_winners):
            if check_perm(winners_, new_losers):
                nxt = State(winners_, copy.copy(new_losers))
                stack.append(nxt)
                parent[nxt] = current

    return None, None






if __name__ == '__main__':
    with open(sys.argv[1]) as f:
        lines = f.read().splitlines()

    winners, losers = [], []

    # initial winners and losers
    for i, line in enumerate(lines):
        if i == 0:
            global N, K
            N = int(line)
            K = int(m.log2(N))
        else:
            t = Team(line)
            if t.agones == 1:
                losers.append(t)
            else:
                winners.append(t)

    # for w, l in zip(winners, losers):
    #     print(w, w.agones, w.efage, w.evale)
    #     print(l, l.agones, l.efage, l.evale)


    for winners_ in itertools.permutations(winners):
        if check_perm(winners_, losers):
            state = State(winners_, losers)
            final, parent = solve(state)
            if final and parent:
                current = final
                # print(final)
                # print('finished')
                # print('\nResults')
                while 42:
                    current.print_matches()
                    if parent[current] == None:
                        break
                    current = parent[current]
                exit()
