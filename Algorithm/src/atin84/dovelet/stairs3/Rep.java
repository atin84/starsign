package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * rep
 * http://183.106.113.109/30stair/rep/rep.php?pname=rep
 * @author atin84
 *
 */
public class Rep {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		for(int i = 1; i <= n; i++) {
			System.out.print(i + " ");
		}
	}

}
