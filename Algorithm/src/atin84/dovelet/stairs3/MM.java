package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * mM
 * http://183.106.113.109/30stair/mM/mM.php?pname=mM
 * @author atin84
 *
 */
public class MM {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		int min = 1000;
		int max = 0;
		
		for(int i = 0; i < 7; i++) {
			n = sc.nextInt();
			
			if(n > 100) {
				System.out.println("max value is 100");
				System.exit(1);
			}
			min = min < n ? min : n;
			max = max > n ? max : n;
		}
		System.out.print(max + " " + min);
	}

}
