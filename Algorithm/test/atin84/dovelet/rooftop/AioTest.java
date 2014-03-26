package atin84.dovelet.rooftop;

import java.util.Scanner;
import java.util.Vector;

import org.junit.Test;

public class AioTest {
	
	@Test
	public void test1() {
		int n = 9;
		Scanner sc = new Scanner("1 1 230 1 2 210 1 3 205 2 1 100 2 2 150 3 1 175 3 2 190 3 3 180 3 4 195");
		Vector<People> p = new Vector<People>(n, 0);
		int lastNation = 0;
		for(int i = 0; i < n; i++) {
			People people = new People();
			lastNation = sc.nextInt();
			people.setNation(lastNation);
			people.setIdx(sc.nextInt());
			people.setScore(sc.nextInt());
			p.add(people);
		}
		new Aio().caculate(n, p, lastNation);
	}
	
}
