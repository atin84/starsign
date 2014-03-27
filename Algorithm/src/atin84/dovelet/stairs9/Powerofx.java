package atin84.dovelet.stairs9;

import java.util.Scanner;

/**
 * powerofx
 * http://183.106.113.109/30stair/powerofx/powerofx.php?pname=powerofx
 * @author atin84
 *
 */
public class Powerofx {
	
	public int pow(int x, int y) {
		if(y == 1) return x;
		return x *  pow(x, y-1);
	}
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int x = sc.nextInt();
		int y = sc.nextInt();

		System.out.println(new Powerofx().pow(x, y));
	}

}
