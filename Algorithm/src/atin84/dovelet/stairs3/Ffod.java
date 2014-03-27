package atin84.dovelet.stairs3;

import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Scanner;

/**
 * ffod
 * http://183.106.113.109/30stair/ftod/ftod.php?pname=ftod
 * @author atin84
 *
 */
public class Ffod {
	
	/**
	 * 6 7 2 - 0.85
	 * 2 7 2 - 0.28
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		double k1 = sc.nextDouble();
		double k2 = sc.nextDouble();
		int k3 = sc.nextInt();
		
		NumberFormat format = NumberFormat.getInstance();
		format.setMaximumFractionDigits(k3);
		format.setRoundingMode(RoundingMode.FLOOR);
		
		System.out.println(format.format(k1 / k2));
	}

}
