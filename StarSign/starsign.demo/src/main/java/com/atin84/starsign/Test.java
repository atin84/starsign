package com.atin84.starsign;

import java.math.BigInteger;

public class Test {
	public BigInteger factorial(int argument) {
		if(argument == 0) return BigInteger.ZERO;
		BigInteger result = BigInteger.ONE;
		for(int i = 1; i <= argument; i++) {
			result = result.multiply(BigInteger.valueOf(i));
		}
		return result;
	}
}
