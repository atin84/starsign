package atin84.dovelet.stairs3;

import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * chemistry
 * http://183.106.113.109/30stair/chemistry/chemistry.php?pname=chemistry
 * @author atin84
 *
 */
public class Chemistry {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		List<Double> list = new ArrayList<Double>();
		while(true) {
			double input = sc.nextDouble();
			
			if(input == 999) {
				break;
			}
			
			if(input < -10 || input > 200) {
				break;
			}
			
			list.add(input);
		}
		
		NumberFormat format = NumberFormat.getInstance();
		format.setMaximumFractionDigits(3);
		format.setRoundingMode(RoundingMode.FLOOR);
		
		
		for(int i = 0; i < list.size() - 1; i++) {
			System.out.println(format.format(list.get(i + 1) - list.get(i)));
		}
	}

}
