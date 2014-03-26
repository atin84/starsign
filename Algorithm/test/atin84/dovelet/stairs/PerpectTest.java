package atin84.dovelet.stairs;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class PerpectTest {
	
	private String DEFICIENT = "DEFICIENT";
	private String PERFECT = "PERFECT";
	private String ABUNDANT = "ABUNDANT";
	
	@Test
	public void test1() {
		Perfect perfect = new Perfect();
		assertEquals(PERFECT, perfect.getResult(28));	
		assertEquals(ABUNDANT, perfect.getResult(56));
		assertEquals(DEFICIENT, perfect.getResult(127));
	}
	
}
