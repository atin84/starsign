package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * seq(open)
 * http://183.106.113.109/30stair/seq/seq.php?pname=seq
 * @author atin84
 *
 */
public class Seq {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int first = sc.nextInt();
		int last = sc.nextInt();
		
		if(first > last) {
			int temp = last;
			last = first;
			first = temp;
		}
		
		for(int i = first; i <= last; i++) {
			System.out.print(i + " ");
		}
	}

}
