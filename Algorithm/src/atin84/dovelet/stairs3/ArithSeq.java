package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * arith_seq
 * http://183.106.113.109/30stair/arith_seq/arith_seq.php?pname=arith_seq
 * @author atin84
 *
 */
public class ArithSeq {
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int k1 = sc.nextInt();
		int k2 = sc.nextInt();
		int k3 = sc.nextInt();
		
		if((k3 - k1)% k2 != 0) {
			System.out.println("X");
		} else {
			int result = 1;
			result += (k3 - k1) / k2;
			System.out.println(result);
		}
	}

}
