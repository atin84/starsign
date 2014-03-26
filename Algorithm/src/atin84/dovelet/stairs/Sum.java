package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * sum
 * http://183.106.113.109/30stair/sum/sum.php?pname=sum
 * @author atin84
 *
 */
public class Sum {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int sum = 0; 
		int n = 0;
		for(int i = 1; i <= 7; i++) {
			n = sc.nextInt();
			if(n > 100) {
				System.out.println("max value is 100");
				System.exit(1);
			}
			sum += n;
		}
		System.out.println(sum);
	}

}
