package atin84.dovelet.stairs;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ModularInverseTest {

	@Test
	public void test1() {
		ModularInverse m = new ModularInverse();
		assertEquals(13, m.getModularInverse(4, 17));
	}
}
