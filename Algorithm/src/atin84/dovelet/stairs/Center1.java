package atin84.dovelet.stairs;

import java.util.Scanner;

/**
 * center1
 * http://183.106.113.109/30stair/center1/center1.php?pname=center1
 * @author atin84
 *
 */
public class Center1 {
	
	private String O = "O";
	private String X = "X";
	
	public String getResult(int n) {
		int sum1 = 0;
		int sum2 = 0;
		
		for(int i = 1; i <= n - 1; i++) {
			sum1 += i;
		}
		for(int i = n+1; i < n * 2; i++) {
			sum2 += i;
			if(sum1 == sum2) break;
		}
		
		return sum1 == sum2 ? O : X;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println(new Center1().getResult(sc.nextInt()));
	}
}