package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * Odd
 * http://183.106.113.109/30stair/odd/odd.php?pname=odd
 * @author atin84
 *
 */
public class Odd {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		int min = -1;
		int sum = 0;
		for(int i = 0; i < 7; i++) {
			n = sc.nextInt();
			
			if(n % 2 == 1) {
				if(min == -1) {
					min = n;
				}
				min = min < n ? min : n;
				sum += n;
			}			
		}
		if(sum != 0) System.out.println(sum);
		System.out.println(min);

	}

}
