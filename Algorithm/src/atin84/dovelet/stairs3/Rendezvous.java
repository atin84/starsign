package atin84.dovelet.stairs3;

import java.util.Scanner;

/**
 * rendezvous
 * http://183.106.113.109/30stair/rendezvous/rendezvous.php?pname=rendezvous
 * @author atin84
 * fail
 */
public class Rendezvous {
	
	public int getCount(int sp1, int sp2) {
		long mv1 = 0;
		long mv2 = 0;
		
		long distance = (sp1 * sp2) * 2;
		int count = 0;
		
		for(int i = 1; i > 0; i++) {
			mv1 = i * sp1;
			mv2 = i * sp2;
			
			if((mv1 + mv2) >= distance + (distance * count)) {
				count++;
				if(mv1 % distance == 0 && mv2 % distance == 0) {
					break;
				}
			}
		}
		return count;
	}
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int speed1 = sc.nextInt();
		int speed2 = sc.nextInt();
		
		System.out.println(new Rendezvous().getCount(speed1, speed2));
	}

}
