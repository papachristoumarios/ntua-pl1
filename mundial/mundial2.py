import sys
import itertools

with open(sys.argv[1]) as f:
    lines = f.read().splitlines()


class team:
	def __init__(self,onoma,agones,yper,kata):
		self.onoma=onoma
		self.agones=agones
		self.yper=yper
		self.kata=kata


def play(nikites):
	xameni=[]
	nikites1=[]	
	for i in nikites:
		if(i.agones==1):
			xameni.append(i)
			
		else:
			nikites1.append(i)
	
	if(len(xameni)==2 and len(nikites1)==0):
		t1,t2=xameni
		print('{}-{} {}-{}'.format(t1.onoma, t2.onoma, t1.yper, t1.kata))
		return;
	
	permu=[zip(x,xameni) for x in itertools.permutations(nikites1,len(xameni))]
	
	for i in permu:
		#mats=len(list(i))
		aa=list(i)
		niki=[]
		for j in range (len(aa)):
			matsaki=aa[j]
			n=matsaki[0]
			i=matsaki[1]
			if(n.yper-i.kata>0 and n.kata-i.yper>0):
				print('{}-{} {}-{}'.format(n.onoma, i.onoma, i.kata, i.yper))
				n.agones=n.agones-1
				n.yper=n.yper-i.kata
				n.kata=n.kata-i.yper
				niki.append(n)
			else: break;
		if(len(niki)==len(nikites1)):
			play(niki)
		

N=int(lines[0])
lista=[]
for i in range(N):
	kati1=lines[i+1].split(' ')

	kati2=team(kati1[0],int(kati1[1]),int(kati1[2]),int(kati1[3]))
	lista.append(kati2)

play(lista)
