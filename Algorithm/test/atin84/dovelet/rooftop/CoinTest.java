package atin84.dovelet.rooftop;

import static org.junit.Assert.assertEquals;

import java.util.Scanner;
import java.util.Vector;

import org.junit.Ignore;
import org.junit.Test;

import atin84.dovelet.rooftop.Coin;

public class CoinTest {
	
	@Test
	public void test1() {
		Scanner sc = new Scanner("20 3 5 3 10 2 1 5");
		int T = sc.nextInt();
		int k = sc.nextInt();
		
		Vector<Integer> p = new Vector<Integer>(k, 0);
		Vector<Integer> n = new Vector<Integer>(k, 0);
		
		for(int i = 0; i < k; i++) {
			p.add(sc.nextInt());
			n.add(sc.nextInt());
		}
		int result = new Coin(p, n).getChangeCount(T, k);
		assertEquals(result, 4);
	}
	
	@Ignore
	public void test2() {
		Scanner sc = new Scanner("10000 5 10 3000 5 4000 3 2000 2 5000 1 10000");
		int T = sc.nextInt();
		int k = sc.nextInt();
		
		Vector<Integer> p = new Vector<Integer>(k, 0);
		Vector<Integer> n = new Vector<Integer>(k, 0);
		
		for(int i = 0; i < k; i++) {
			p.add(sc.nextInt());
			n.add(sc.nextInt());
		}
		int result = new Coin(p, n).getChangeCount(T, k);
		assertEquals(result, 1697965465);
	}
}
