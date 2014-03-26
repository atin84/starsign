package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * 1ton1
 * http://183.106.113.109/30stair/1ton1/1ton1.php?pname=1ton1
 * @author atin84
 *
 */
public class OneTonOne {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = sc.nextInt();
		
		if(n > 1000) {
			System.out.println("max value is 1000");
			System.exit(1);
		}
		
		int sum = n;
		for(int i = 1; i < n; i++) {
			sum += i;
			System.out.print(i + "+");
		}
		System.out.print(n + "=" + sum);
	}

}
