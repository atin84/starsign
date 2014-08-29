package com.atin84.starsign;

import static org.junit.Assert.*;

import java.math.BigInteger;

import org.junit.Test;

public class TestTest {
	
	@Test
	public void factorialTest() {
		com.atin84.starsign.Test test = new com.atin84.starsign.Test();
		assertEquals(BigInteger.valueOf(0),		test.factorial(0));
		assertEquals(BigInteger.valueOf(1),		test.factorial(1));
		assertEquals(BigInteger.valueOf(2),		test.factorial(2));
		assertEquals(BigInteger.valueOf(6),		test.factorial(3));
		assertEquals(BigInteger.valueOf(24),	test.factorial(4));
		assertEquals(BigInteger.valueOf(120),	test.factorial(5));
	}
}
