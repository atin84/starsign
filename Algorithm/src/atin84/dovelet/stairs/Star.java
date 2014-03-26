package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * star
 * http://183.106.113.109/30stair/star/star.php?pname=star
 * @author atin84
 *
 */
public class Star {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		for(int i = 0; i < n; i++) {
			System.out.print("*");
		}
	}

}
