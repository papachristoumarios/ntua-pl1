

import sys
import itertools
from copy import copy
with open(sys.argv[1]) as f:
    lines = f.read().splitlines()


class team:
    def __init__(self,onoma,agones,yper,kata):
        self.onoma=onoma
        self.agones=agones
        self.yper=yper
        self.kata=kata    


def play(nikites,flag,typoma=[]):
    xameni=[]

    nikites1=[]
    for i in nikites:
        if(i.agones==1):
            jj=copy(i)
            xameni.append(jj)

        else:
            jj=copy(i)
            nikites1.append(jj)

    if(len(xameni)==2 and len(nikites1)==0 and flag==0):
        t1,t2=xameni
        if(t1.yper==t2.kata and t1.kata==t2.yper):
            flag=1
            for i in typoma:
                    print('{}-{} {}-{}'.format(i[0],i[1],i[2],i[3]))

            print('{}-{} {}-{}'.format(t1.onoma, t2.onoma, t1.yper, t1.kata))
            return (1);

    #permu=[zip(x,xameni) for x in itertools.permutations(nikites1,len(xameni))]
    #print(len(permu))
    #for i in permu:

    for x in itertools.permutations(nikites1,len(xameni)):
        aaaa=zip(x,xameni)
        aaa=list(aaaa)
        #print(len(aaa))
        simea=0
        for i in range(len(aaa)):
            if(aaa[i][0].yper<aaa[i][1].kata or aaa[i][0].kata<aaa[i][1].yper):
                simea=1
                break
            #print(aaa[i][0].onoma,aaa[i][1].onoma)
        if(simea==1):
            continue

        aa=aaa[:]
        niki=[]
        typoma1=typoma[:]
        typoma2=[]
        for j in range (len(aa)):
            #print(aa[j][0].onoma)
            matsaki=aa[j]
            #print(matsaki[0].onoma,matsaki[1].onoma)
            n=matsaki[0]
            i=matsaki[1]
            if(n.yper-i.kata>0 and n.kata-i.yper>0 and i.kata>i.yper):
                typoma2.append([n.onoma, i.onoma, i.kata, i.yper])
                #print(typoma2)
                nn=copy(n)
                ii=copy(i)
                nn.agones=nn.agones-1
                nn.yper=nn.yper-ii.kata
                nn.kata=nn.kata-ii.yper
                niki.append(nn)
            else:
                # print("fd")
                break;
        #print(flag)
        if(len(niki)==len(nikites1)):
            typoma1=typoma1+typoma2

            #print("fsd")
            flag=play(niki,flag,typoma1)
        #print("ok")
        if(flag==1):
            break;
    #print(flag)
    if(flag==1):
        return(1);
    else: return(0);

N=int(lines[0])
lista=[]
for i in range(N):
    kati1=lines[i+1].split(' ')

    kati2=team(kati1[0],int(kati1[1]),int(kati1[2]),int(kati1[3]))
    lista.append(kati2)

play(lista,0)
