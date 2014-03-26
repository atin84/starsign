package atin84.dovelet.stairs;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * lunacy
 * http://183.106.113.109/30stair/lunacy/lunacy.php?pname=lunacy
 * @author atin84
 *
 */
public class Lunacy {
	
	private double MOON_WEIGHT = 0.167;
	
	public double convertMoonWeight(double weight) {
		return weight * MOON_WEIGHT;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		List<Double> weightList = new ArrayList<Double>();
		double input = 0;
		while(true) {
			input = sc.nextDouble();
			if(input < 0) break;
			
			weightList.add(input);
		}
		
		Lunacy lunacy = new Lunacy();
		for(double weight : weightList) {
			System.out.format("Objects weighing %.2f on Earth will weigh %.2f on the moon.", weight, lunacy.convertMoonWeight(weight));
			System.out.println();
		}
	}
}