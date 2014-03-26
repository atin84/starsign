package atin84.dovelet.stairs;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class LunacyTest {

	@Test
	public void test1() {
		Lunacy l = new Lunacy();
		assertEquals(16.70D, l.convertMoonWeight(100.0), 2);
		assertEquals(2.00, l.convertMoonWeight(12.0), 2);
		assertEquals(0.02, l.convertMoonWeight(0.12), 2);
		assertEquals(20040.00, l.convertMoonWeight(120000.0), 2);
	}
}
