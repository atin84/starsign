package atin84.dovelet.stairs;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class FactTest {

	@Test
	public void test1() {
		Fact fact = new Fact();
		assertEquals(1, fact.getCount(0).longValue());	
		assertEquals(1, fact.getCount(1).longValue());
		assertEquals(2, fact.getCount(2).longValue());
		assertEquals(6, fact.getCount(3).longValue());
		assertEquals(24, fact.getCount(4).longValue());
		assertEquals(120, fact.getCount(5).longValue());
		assertEquals(720, fact.getCount(6).longValue());
		assertEquals(5040, fact.getCount(7).longValue());
		assertEquals(40320, fact.getCount(8).longValue());
		assertEquals(362880, fact.getCount(9).longValue());
		assertEquals(3628800, fact.getCount(10).longValue());
		assertEquals(39916800, fact.getCount(11).longValue());
		assertEquals(479001600, fact.getCount(12).longValue());
		assertEquals("6227020800", fact.getCount(13).toString());
		assertEquals("87178291200", fact.getCount(14).toString());
		assertEquals("1307674368000", fact.getCount(15).toString());
		assertEquals("20922789888000", fact.getCount(16).toString());
		assertEquals("355687428096000", fact.getCount(17).toString());
		assertEquals("6402373705728000", fact.getCount(18).toString());
		assertEquals("121645100408832000", fact.getCount(19).toString());
		assertEquals("2432902008176640000", fact.getCount(20).toString());
	}
}
