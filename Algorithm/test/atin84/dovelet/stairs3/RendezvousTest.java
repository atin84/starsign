package atin84.dovelet.stairs3;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class RendezvousTest {

	@Test
	public void test1() {
		Rendezvous rendezvous = new Rendezvous();
		assertEquals(2, rendezvous.getCount(1, 1));
		assertEquals(5, rendezvous.getCount(2, 3));	
		assertEquals(3, rendezvous.getCount(2, 4));
		assertEquals(2, rendezvous.getCount(3, 3));
		assertEquals(5, rendezvous.getCount(8, 12));
		assertEquals(21, rendezvous.getCount(1, 20));
		assertEquals(11, rendezvous.getCount(10, 12));
		assertEquals(2147483647, rendezvous.getCount(68614184, 49012062));
	}
}