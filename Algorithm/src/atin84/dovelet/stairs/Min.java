package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * min
 * http://183.106.113.109/30stair/min/min.php?pname=min
 * @author atin84
 *
 */
public class Min {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		int min = sc.nextInt();
		
		for(int i = 1; i < 6; i++) {
			n = sc.nextInt();
			
			if(n > 100) {
				System.out.println("max value is 100");
				System.exit(1);
			}
			min = min < n ? min : n;
		}
		System.out.print(min);
	}

}
