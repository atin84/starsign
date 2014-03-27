package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * yaksu
 * http://183.106.113.109/30stair/yaksu/yaksu.php?pname=yaksu
 * @author atin84
 *
 */
public class Yaksu {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int k = sc.nextInt();
		
		if(n < 1 || n > 10000) {
			System.out.println("n >= 1 && n <= 10000");
			System.exit(1);
		}
		if(k < 1 || k > n) {
			System.out.println("k >= 1 && k <= n");
			System.exit(1);
		}
		
		int cnt = 0;
		for(int i = 1; i <= n; i++) {
			if(n % i == 0) {
				cnt++;
				if(cnt == k) {
					System.out.println(i);
					break;
				}
			}
		}
		if(cnt < k) System.out.println(0);
	}

}
