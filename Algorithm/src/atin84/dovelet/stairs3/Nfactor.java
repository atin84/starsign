package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * nfactor
 * http://183.106.113.109/30stair/nfactor/nfactor.php?pname=nfactor
 * @author atin84
 *
 */
public class Nfactor {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		int cnt = 0;
		for(int i = 1; i <= n; i++) {
			if(n % i == 0) {
				cnt++;
			}
		}
		System.out.println(cnt);
	}

}
