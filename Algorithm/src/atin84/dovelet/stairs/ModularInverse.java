package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * modular_inverse
 * http://183.106.113.109/30stair/modular_inverse/modular_inverse.php?pname=modular_inverse
 * @author atin84
 *
 */
public class ModularInverse {
	
	/**
	 * 0 < x < m
	 * @param x
	 * @param m
	 * @return
	 */
	public int getModularInverse(int x, int m) {
		int n = 0;
		
		/**
		 * 0 < n < m
		 */
		for(int i = 1; i < m; i++) {
			if ((x * i) % m == 1) {
				n = i;
			}
		}
		
		return n;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int result = new ModularInverse().getModularInverse(sc.nextInt(), sc.nextInt());
		if(result == 0)
			System.out.println("No such integer exists.");
		else
			System.out.println(result);
	}
}