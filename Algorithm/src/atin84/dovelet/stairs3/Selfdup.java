package atin84.dovelet.stairs3;

import java.text.DecimalFormat;
import java.text.NumberFormat;

/**
 * selfdup
 * http://183.106.113.109/30stair/selfdup/selfdup.php?pname=selfdup
 * @author atin84
 *
 */
public class Selfdup {
	
	public boolean isSelfdup(int n) {
		NumberFormat format = new DecimalFormat("#####");
		format.setMaximumIntegerDigits(String.valueOf(n).length());
		
		return n == Integer.valueOf(format.format(n * n)) ? true : false;
	}
	
	public static void main(String[] args) {
		Selfdup selfdup = new Selfdup();
		for(int i = 1; i <= 10000; i++) {
			if(selfdup.isSelfdup(i)) {
				System.out.println(i);
			}
		}
	}

}
