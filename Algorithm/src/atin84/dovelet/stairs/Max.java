package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * max
 * http://183.106.113.109/30stair/post.php?pname=max
 * @author atin84
 *
 */
public class Max {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		int max = 0;
		
		for(int i = 1; i < 7; i++) {
			n = sc.nextInt();
			
			if(n > 100) {
				System.out.println("max value is 100");
				System.exit(1);
			}
			max = max > n ? max : n;
		}
		System.out.print(max);
	}

}
