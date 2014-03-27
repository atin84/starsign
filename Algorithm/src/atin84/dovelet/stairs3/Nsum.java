package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * Nsum
 * http://183.106.113.109/30stair/Nsum/Nsum.php?pname=Nsum
 * @author atin84
 *
 */
public class Nsum {

	public int getCount(int n) {
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i;
			if(sum == n) {
				return i;
			} else if(sum > n) {
				return 0;
			}
		}
		return 0;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		
		Nsum nSum = new Nsum();
		System.out.println(nSum.getCount(n));

	}

}
