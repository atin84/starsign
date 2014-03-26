package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * triangular_sum
 * http://183.106.113.109/30stair/triangular_sum/triangular_sum.php?pname=triangular_sum
 * @author atin84
 *
 */
public class TriangularSum {
	
	public int getSum(int n) {
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i * T(i + 1);
		}
		
		return sum;
	}
	
	private int T(int n) {
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i;
		}
		return sum;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println(new TriangularSum().getSum(sc.nextInt()));
	}
}