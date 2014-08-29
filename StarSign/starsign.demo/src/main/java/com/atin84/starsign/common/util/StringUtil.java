package com.atin84.starsign.common.util;

import java.util.ArrayList;
import java.util.List;
//import java.util.StringTokenizer;

public class StringUtil {

	public static List<String> split(String string, char delim) {

		int beginIndex = 0;
		int endIndex = 0;
		
		List<String> list = new ArrayList<String>();
		
		while (true) {
			endIndex = string.indexOf(delim, beginIndex);
			if (endIndex == -1) {
				list.add(string.substring(beginIndex));
				break;
			}
			
			list.add(string.substring(beginIndex, endIndex));
			beginIndex = endIndex + 1;
		}
		
		return list;

		/*
		StringTokenizer st = new StringTokenizer(string,""+delim);
		System.out.println(string);
		List<String> list = new ArrayList<String>();
		while(st.hasMoreTokens()) {
			String token = st.nextToken();
			list.add(token);
		}
		
		System.out.println(list);
		return list;
		*/
	}

	public static boolean isValidPhone(String value) {
		String regex = "^01[016789][0-9]{7,8}";
		return value.matches(regex);
	}
	
	public static boolean isValidMac(String value) {
		// 터널 어댑터의 경우 64bit MAC이 나오는 데, 실제로도 가능한 지 확인해보고 가능하다면 아래 정규식을 써야만 함
		// String regex = "^[0-9|A-F]{2}(((-[0-9|A-F]{2}){5}|(-[0-9|A-F]{2}){7})|((:[0-9|A-F]{2}){5}|(:[0-9|A-F]{2}){7}))";
		
		String regex = "^[0-9|A-F]{2}(((-[0-9|A-F]{2}){5})|((:[0-9|A-F]{2}){5}))";
		return value.matches(regex);
	}

	public static boolean isEmpty(String value) {
		if (value == null || value.trim().length() == 0)
			return true;
		
		return false;
	}
	
	
	public static void main(String[] args) {
//		String string = ",,,,,";
//		String string = "a,a,a,,a,a";
//		String string = ",a,a,,a,";
//		String[] datas = ", ,, ,,".split(",");
//		System.out.println(datas.length);
//		List<String> list = split(string, ',');
//		System.out.println(list);
		
//		System.out.println("01111111111 : " + isValidPhone("01111111111"));
//		System.out.println("0101112345 : " + isValidPhone("0101112345"));
//		System.out.println("0100002345 : " + isValidPhone("0100002345"));
//		
//		System.out.println("1101111111 : " + isValidPhone("1101111111"));
//		System.out.println("0141111111 : " + isValidPhone("1101111111"));
//	
//		
//		System.out.println("A0-88-B4-3F-0B-30 : " + isValidMac("A0-88-B4-3F-0B-30"));
//		System.out.println("F0-DE-F1-5D-FB-A3 : " + isValidMac("F0-DE-F1-5D-FB-A3"));
//		System.out.println("00-50-56-C0-00-01 : " + isValidMac("00-50-56-C0-00-01"));
//		System.out.println("00-50-56-C0-00-08 : " + isValidMac("00-50-56-C0-00-08"));
//		System.out.println("00-00-00-00-00-00-00-E0 : " + isValidMac("00-00-00-00-00-00-00-E0"));
//		System.out.println("A0:88:B4:3F:0B:30 : " + isValidMac("A0:88:B4:3F:0B:30"));
//		System.out.println("F0:DE:F1:5D:FB:A3 : " + isValidMac("F0:DE:F1:5D:FB:A3"));
//		System.out.println("00:50:56:C0:00:01 : " + isValidMac("00:50:56:C0:00:01"));
//		System.out.println("00:50:56:C0:00:08 : " + isValidMac("00:50:56:C0:00:08"));
//		System.out.println("00:00:00:00:00:00:00:E0 : " + isValidMac("00:00:00:00:00:00:00:E0"));
//		
//		System.out.println("A0:88-B4:3F:0B:30 : " + isValidMac("A0:88-B4:3F:0B:30"));
//		System.out.println("F0-DE:F1:5D:FB:A3 : " + isValidMac("F0-DE:F1:5D:FB:A3"));
//		System.out.println("00:50:56-C0:00:08 : " + isValidMac("00:50:56-C0:00:08"));
//		System.out.println("00:00-00:00:00:00:00:E0 : " + isValidMac("00:00-00:00:00:00:00:E0"));
//		
//		System.out.println("111 : " + isValidMac("111"));
//		System.out.println("a0 : " + isValidMac("a0"));
//		
//		System.out.println("A0-88-B4-3F-0B-30- : " + isValidMac("A0-88-B4-3F-0B-30-"));
//		System.out.println("00-00-00 : " + isValidMac("00-00-00"));
//		System.out.println("00-00-00-00-00-00-00 : " + isValidMac("00-00-00-00-00-00-00"));
		
		System.out.println("null : " + isEmpty(null));
		System.out.println(" : " + isEmpty(""));
		System.out.println("  : " + isEmpty(" "));
		
		System.out.println("a  : " + isEmpty("a"));
	}	
}
