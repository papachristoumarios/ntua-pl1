import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;
import java.util.Vector;
import java.util.Queue;
import java.io.File;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;
import java.io.FileNotFoundException;
import java.util.NoSuchElementException;
import java.io.BufferedReader;
import java.io.FileReader;

public class pr1 {
	static int MAXN=1000;
	static String[][] grid=new String[MAXN+2][MAXN+2];
	static int[][] depth=new int[MAXN+2][MAXN+2];
	static int M=0,N=0;
	

private static class Pair{
	int x=0;
	int y=0;
void setx(int a){x=a;}
void sety(int a){y=a;}
int getx(){return x;}
int gety(){return y;}	
}

static Queue<Pair> q = new LinkedList<Pair>();
static Queue<Pair> stars = new LinkedList<Pair>();

	public static int min(int a, int b) {
		return a < b ? a : b;
	}

	public static void printGrid(){
		for (int i = 0; i < N; i++) {
    			for (int j = 0; j < M; j++) {
      				System.out.print(grid[i][j]);
    			}
    		System.out.println();
  		}
	}

	public static Vector<Pair> getNeig(int u, int v){
		Vector<Pair> result=new Vector<Pair>();
		if (u > 0 && !grid[ u-1 ][v] .equals( String.valueOf('X'))) {
			Pair pair= new Pair();
			pair.setx(u-1);
			pair.sety(v);
			result.addElement(pair);
		}
  		if (v > 0 && !grid[ u ][v-1] .equals( String.valueOf('X'))){
			Pair pair= new Pair();
			pair.setx(u);
			pair.sety(v-1);
			result.addElement(pair);
		}
  		if (u < N-1 && !grid[u+1] [v] .equals( String.valueOf('X'))){
			Pair pair= new Pair();
			pair.setx(u+1);
			pair.sety(v);
			result.addElement(pair);
		}
  		if (v < M-1 && !grid[u] [v+1] .equals( String.valueOf('X'))){
			Pair pair= new Pair();
			pair.setx(u);
			pair.sety(v+1);
			result.addElement(pair);
		}
  		return result;
	
	}


	public static boolean kaboom(int u, int v, int i, int j){
		 return ((
    		(grid[u][v] .equals( String.valueOf('+')) && grid[i][j].equals( String.valueOf('-'))) ||
    		(grid[u][v].equals( String.valueOf('-')) && grid[i][j] .equals( String.valueOf('+'))))

  		);	
	}

	public static int bfs(){
		int u=0, v=0, i=0, j=0;
		int opt = 34252676;
		while (!q.isEmpty()) {
			Pair pair=q.poll();
			u=pair.getx();
			v=pair.gety();
			if(depth[u][v]==opt){continue;}	
			Vector<Pair> neig=new Vector<Pair>()  ;
			neig=getNeig(u, v);
			for (Pair qq : neig){
				i=qq.getx();
				j=qq.gety();
				if (grid[u][v] .equals( grid[i][j])) {continue;}
			        else if (grid[i][j] .equals( String.valueOf('.'))) {
					depth[i][j] = depth[u][v] + 1;
					grid[i][j] = grid[u][v];
					q.offer(qq);
				}
				else if(kaboom(u,v,i,j)){
					opt=min(opt,depth[u][v]+1);
					stars.offer(qq);				
				}
			}
		}

		while(!stars.isEmpty()){
			Pair pair=stars.poll();
			i=pair.getx();
			j=pair.gety();
			grid[i][j]=String.valueOf('*');	
		}
		return opt;
		
	}
 
public static int textCount(Scanner Scan1) 
        {
            Scanner input = Scan1;
    int lines =0;
    int characters =0;
    int maxCharacters =0;
    String longestLine= "";
     
    while(input.hasNextLine()){
        String line = input.nextLine();
        lines++;
        characters+=line.length();
        if(maxCharacters<line.length()){
            maxCharacters = line.length();
        longestLine = line;
        }
         
    }
	return((characters / lines));
}

	public static void main(String[] args) throws Exception {
		File infile = new File(args[0]);
		Scanner sc = new Scanner(infile);
		sc.useDelimiter("|\\n");
            	M=0;
		N=0;
		BufferedReader reader = new BufferedReader(new FileReader(args[0]));
		int lines = 0;
		while (reader.readLine() != null) lines++;
		reader.close();
		N=lines;
		M=textCount(sc);
		int jj=0;

		sc = new Scanner(infile);
		sc.useDelimiter("|\\n");
		while(jj<N){
			for(int i=0; i<=M; i++){
				String c=sc.next();
				while(c==String.valueOf('\n')){c=sc.next();}

				grid[jj][i]=c;	
		
			}
			jj=jj+1;
		}
printGrid();
	
			for (int i=0; i<N; i++){
				for(int j=0; j<M; j++){				
		
					if(grid[i][j].equals(String.valueOf('+')) || grid[i][j].equals(String.valueOf('-'))){
						Pair pair= new Pair();
						pair.setx(i);
						pair.sety(j);
						q.add(pair);
						depth[i][j]=0;
					}
					else {depth[i][j]=-1;}
				}
			}
			
		



int opt=bfs();
if (opt==34252676){
	System.out.println("the world is saved");
}
else{
	System.out.println (opt);}
printGrid();




  
   }
}
