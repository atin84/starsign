package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * factor
 * http://183.106.113.109/30stair/factor/factor.php?pname=factor
 * @author atin84
 *
 */
public class Factor {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		
		for(int i = 1; i <= n; i++) {
			if(n % i == 0) {
				System.out.println(i);
			}
		}
	}

}
