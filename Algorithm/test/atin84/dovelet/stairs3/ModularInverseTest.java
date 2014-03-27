package atin84.dovelet.stairs3;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import atin84.dovelet.stairs3.ModularInverse;

public class ModularInverseTest {

	@Test
	public void test1() {
		ModularInverse m = new ModularInverse();
		assertEquals(13, m.getModularInverse(4, 17));
	}
}
