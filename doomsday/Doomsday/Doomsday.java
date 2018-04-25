import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;
import java.util.LinkedList;
import java.awt.Point;
import java.awt.geom.Point2D;


public class Doomsday {

  public static void main (String[] args) throws Exception {
	  FileReader fileReader = new FileReader(args[0]);
      BufferedReader bufferedReader = new BufferedReader(fileReader);
      List<char []> lines = new ArrayList<char []>();
      String line = null;
      int N = 0;
      int M = 0;
      while ((line = bufferedReader.readLine()) != null) {
          if (N == 0) {
        	  M = (int)line.length();
          }
    	  lines.add(line.toCharArray());
          N++;
      }
      bufferedReader.close();
      char[][] grid = lines.toArray(new char[lines.size()][]);
      Queue<Point> q = new LinkedList<>();
      Queue<Point> stars = new LinkedList<>();

      int[][] depth = new int[1000][1000];


      for (int i = 0; i < N; i++) {
    	  for (int j = 0; j < M; j++) {
    		  if (grid[i][j] == '+' || grid[i][j] == '-' ) {
    			  q.add(new Point(i, j));

    			  depth[i][j] = 0;
    		  } else depth[i][j] = -1;
    	  }
      }

      int opt = Integer.MAX_VALUE;

      while(!q.isEmpty()) {
    	Point p = q.remove();
    	int u = p.x;
    	int v = p.y;

      // System.out.println(" " + u + " "  + v );


    	if (depth[u][v] == opt) {
    		continue;
    	}

    	ArrayList<Point> neigh = new ArrayList<Point>();

    	if (u > 0 && grid[ u-1 ][v] != 'X') neigh.add( new Point ( u-1, v ));
    	if (v > 0 && grid[ u ][v-1] != 'X') neigh.add( new Point ( u, v-1 ));
    	if (u < N - 1 && grid[u+1] [v] != 'X') neigh.add(new Point ( u+1, v ));
    	if (v < M - 1 && grid[u][v+1] != 'X') neigh.add(new Point ( u, v+1 ));


    	for(Point qq : neigh) {
    		int i = qq.x;
    		int j = qq.y;

    		if (grid[u][v] == grid[i][j]) {
    			continue;
    		} else if (grid[i][j] == '.') {
              depth[i][j] = depth[u][v] + 1;
    	        grid[i][j] = grid[u][v];
    	        q.add(new Point(i, j));

    		} else if ((grid[u][v] == '+' && grid[i][j] == '-' ) || (grid[u][v] == '-' && grid[i][j] == '+')) {
    			opt = opt < depth[u][v] + 1 ? opt : depth[u][v] + 1;
    			stars.add(new Point(i,j));
    		}


    	}



      }

      while (!stars.isEmpty()) {
    	  Point p = stars.remove();
    	  int i = p.x;
    	  int j = p.y;
    	  grid[i][j] = '*';
      }


      if (opt == Integer.MAX_VALUE) {
    	  System.out.println("the world is saved");
      } else {
    	  System.out.println(opt);
      }


      // print grid
      for (int i = 0; i < N; i++) {
    	  for (int j = 0; j < M; j++) {
    	  System.out.print(grid[i][j]);
    	  }
    	  System.out.println();
      }




  }



}
