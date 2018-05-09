import java.io.File;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Queue;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.Set;
import java.util.Collection;

public class Pistes {
	static int N;
	static int opt = 0;
	static int[] r = new int[43];
	static int[] s = new int[43];
	static int[] k = new int[43];
	static int[][] keys = new int[43][10];
	static int[][] rewards = new int[43][10];

	class State {
		public int score;
		public int index;
		public LinkedList<Integer> notVisited;
		public LinkedList<Integer> holding;
		public int total;

		public State() {
			notVisited = new LinkedList<Integer>();
			holding = new LinkedList<Integer>();
		}

	}

	public static int max(int a, int b) {
		return a > b ? a : b;
	}

	public static void printList(LinkedList<Integer> l) {
		for (int i : l) {
			System.out.print(" " + i);
		}
		System.out.println();
	}

	public static void printPista(int j) {
		System.out.println("This is pista " + j);
		System.out.println(k[j] + " " + " " + r[j] + " " + s[j]);
		System.out.println("Required: ");
		for (int i = 0; i < k[j]; i++) {
			System.out.print(" " + keys[j][i]);
		}
		System.out.println();
		System.out.println("Rewarded");
		for (int i = 0; i < r[j]; i++) {
			System.out.print(" " + rewards[j][i]);
		}
		System.out.println();

	}

	public static void main(String[] args) throws Exception {

		File infile = new File(args[0]);
		Scanner sc = new Scanner(infile);
		N = sc.nextInt() + 1;
		int[] idx = new int[N];

		for (int i = 0; i < N; i++) {
			k[i] = sc.nextInt();
			r[i] = sc.nextInt();
			s[i] = sc.nextInt();
			for (int j = 0; j < k[i]; j++) {
				keys[i][j] = sc.nextInt();
			}
			for (int j = 0; j < r[i]; j++) {
				rewards[i][j] = sc.nextInt();
			}


		}




		Pistes obj = new Pistes();
		obj.run();

		System.out.println(opt);


	}

	public void run () throws Exception
	{

		State q0 = new State();
		q0.index = 0;
		q0.score = s[0];
		q0.total = 1;
		for (int i = 1; i <= N; i++) {
			q0.notVisited.add(i);
		}
		for (int j = 0; j < r[0]; j++) {
			q0.holding.add(rewards[0][j]);
		}

		Queue<State> q = new LinkedList<State>();
		q.add(q0);
		boolean found = false;

		while(!q.isEmpty()) {
			State tmp = q.remove();

			if (tmp.total == N + 1) {
				opt = max(opt, tmp.score);
				return;
			}

			for (int current : tmp.notVisited) {
				LinkedList<Integer> checker = new LinkedList<Integer>();
				checker.addAll(tmp.holding);

				for (int j = 0; j < k[current]; ++j) {
					found =	checker.removeFirstOccurrence(keys[current][j]);
					if (!found) {
						opt = max(tmp.score, opt);
						break;
					}

				}

				if (!found) continue;

				// create new state
				State next = new State();
				next.score = tmp.score + s[current];
				next.total = tmp.total + 1;
				next.index = current;
				next.holding.addAll(checker);
				for (int j = 0; j < r[current]; j++) next.holding.add(rewards[current][j]);
				next.notVisited.addAll(tmp.notVisited);
				next.notVisited.removeFirstOccurrence(current);
				q.add(next);

			}


		}



	}


}
