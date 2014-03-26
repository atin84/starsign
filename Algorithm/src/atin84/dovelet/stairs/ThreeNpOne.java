package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * 3np1
 * http://183.106.113.109/30stair/3np1/3np1.php?pname=3np1
 * @author atin84
 *
 */
public class ThreeNpOne {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = sc.nextInt();
		
		while(true) {
			if(n == 1) break;
			
			System.out.print(n + " ");
			
			if(n % 2 == 0) {
				n = n / 2;
			} else {
				n = n * 3 + 1;
			}
		}
		
		System.out.print(n);

	}

}
