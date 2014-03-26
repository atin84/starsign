package atin84.dovelet.rooftop;
import java.util.Scanner;
import java.util.Vector;

public class Etrain {
	private Vector<Integer> p = new Vector<Integer>(4, 0);
	
	public Etrain() {}
	
	public void add(int k) {
		if(p.size() < 8)
			p.add(k);
	}
	
	public long counting() {
		long result = 0;
		long best = 0;
		for(int i = 0; i < p.size(); i++) {
			if(i % 2 == 0) 
				result -= p.get(i);
			else if(i % 2 == 1) 
				result += p.get(i);
			best = best > result ? best : result;
		}
		return best;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Etrain main = new Etrain();
		for(int i = 0; i < 8; i++) {
			main.add(sc.nextInt());
		}
		System.out.println(main.counting());
	}
}
