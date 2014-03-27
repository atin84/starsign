package atin84.dovelet.stairs3;

import java.math.BigInteger;
import java.util.Scanner;

/**
 * fact
 * http://183.106.113.109/30stair/fact/fact.php?pname=fact
 * @author atin84
 *
 */
public class Fact {
	
	public BigInteger getCount(int n) {
		BigInteger fact = BigInteger.ONE;
		for(int i = 2; i <= n; i++) {
			fact = fact.multiply(BigInteger.valueOf(i));
		}
		return fact;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int n = sc.nextInt();
		
		System.out.print(new Fact().getCount(n));

	}

}
