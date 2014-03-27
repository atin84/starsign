package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * adigit
 * http://183.106.113.109/30stair/adigit/adigit.php?pname=adigit
 * @author atin84
 *
 */
public class Adigit {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		
		int sum1 = 0;
		int sum2 = 0;
		int sum3 = 0;
		
		for(int i = 1; i <= 7; i++) {
			n = sc.nextInt();
			if(n < 10) {
				sum1 += n;
			} else if(n > 9 && n < 100) {
				sum2 += n;
			} else if(n > 99 && n < 1000) {
				sum3 += n;
			}			
		}
		System.out.println(sum1 + " " + sum2 + " " + sum3);
	}

}
