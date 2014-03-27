package atin84.dovelet.stairs3;

import java.util.Scanner;
import java.util.Vector;

/**
 * validate
 * http://183.106.113.109/30stair/validate/validate.php?pname=validate
 * @author atin84
 *
 */
public class Validate {
	
	private Vector<Integer> vector = new Vector<Integer>(5, 0);
	
	public void addNum(int n) {
		if(vector.size() < 5) {
			vector.add(n);
		}
	}
	
	public int getValidate() {
		int sum = 0;
		for(int i = 0; i < vector.size(); i++) {
			sum += vector.get(i) * vector.get(i);
		}
		return sum % 10;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		Validate val = new Validate();
		for(int i = 0; i < 5; i++) {
			val.addNum(sc.nextInt());
		}
		
		System.out.println(val.getValidate());
	}
}