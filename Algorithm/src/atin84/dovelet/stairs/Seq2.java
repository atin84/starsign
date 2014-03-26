package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * Seq2
 * http://183.106.113.109/30stair/seq2/seq2.php?pname=seq2
 * @author atin84
 *
 */
public class Seq2 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		if(n > 1000) {
			System.out.println("max value is 1000");
			System.exit(1);
		}
		
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i;
			System.out.println("1.." + i + " " + sum);
		}
		
	}

}
