package atin84.dovelet.stairs3;

import java.math.BigInteger;
import java.util.Scanner;

/**
 * ft
 * http://183.106.113.109/30stair/ft/ft.php?pname=ft
 * @author atin84
 *
 */
public class Ft {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		
		if(n > 1000) {
			System.out.println("n <= 1000");
			System.exit(1);
		}
		
		int cnt = 0;
		int sum = 0;
		BigInteger multiply = BigInteger.ONE;
		for(int i = 1; i <= n; i++) {
			if(n % i == 0) {
				cnt++;
				sum += i;
				System.out.print(i + " ");
				
				multiply = multiply.multiply(BigInteger.valueOf(i));
				
			}
		}
		System.out.println();
		System.out.println(cnt);
		System.out.println(sum);
		System.out.println(multiply.remainder(BigInteger.valueOf(10)).toString());
	}

}
