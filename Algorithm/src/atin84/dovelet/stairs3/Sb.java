package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * sb
 * http://183.106.113.109/30stair/sb/sb.php?pname=sb
 * @author atin84
 *
 */
public class Sb {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = 0;
		int max = 0;
		int no = 0;
		
		for(int i = 1; i <= 7; i++) {
			n = sc.nextInt();
			
			if(n > 100) {
				System.out.println("max value is 100");
				System.exit(1);
			}
			if(max < n) {
				max = n;
				no = i;
			}
		}
		System.out.print(no);
	}

}
