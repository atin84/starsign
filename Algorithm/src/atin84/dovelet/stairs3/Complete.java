package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * complete
 * http://183.106.113.109/30stair/complete/complete.php?pname=complete
 * @author atin84
 *
 */
public class Complete {
	
	private String YES = "yes";
	private String NO = "no";
	
	public String getResult(int n) {
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i;
			
			if(sum == n) {
				return YES;
			}
			if(sum > n) {
				return NO;
			}
		}
		return NO;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		
		System.out.println(new Complete().getResult(n));
	}

}
