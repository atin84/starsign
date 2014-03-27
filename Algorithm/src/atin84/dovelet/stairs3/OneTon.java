package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * 1ton
 * http://183.106.113.109/30stair/1ton/1ton.php?pname=1ton
 * @author atin84
 *
 */
public class OneTon {

	public int getCount(int n) {
		int sum = 0;
		for(int i = 1; i <= n; i++) {
			sum += i;
		}
		return sum;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		
		OneTon oneTon = new OneTon();
		System.out.println(oneTon.getCount(n));

	}

}
