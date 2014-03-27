package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * gugudan
 * http://183.106.113.109/30stair/gugudan/gugudan.php?pname=gugudan
 * @author atin84
 *
 */
public class Gugudan {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		for(int i = 1; i <= 9; i++) {
			System.out.println(n + "*" + i + "=" + (n*i));
		}
	}

}
