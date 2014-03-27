package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * financial
 * http://183.106.113.109/30stair/financial/financial.php?pname=financial
 * @author atin84
 *
 */
public class Financial {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		double sum = 0;
		double n = 0;
		for(int i = 0; i < 12; i++) {
			n = sc.nextDouble();
			sum += n;
		}
		System.out.format("$%.2f", sum/12D);
	}

}
