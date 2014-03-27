package atin84.dovelet.stairs9;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class PowerofxTest {

	@Test
	public void test1() {
		Powerofx ofx = new Powerofx();
		assertEquals(4, ofx.pow(2, 2));
		assertEquals(16, ofx.pow(2, 4));
		assertEquals(1024, ofx.pow(2, 10));
	}

}
