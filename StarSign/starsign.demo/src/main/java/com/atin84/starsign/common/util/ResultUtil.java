package com.atin84.starsign.common.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class ResultUtil {
	
	public static String toJSON(String result, String code) {
		StringBuilder sb = new StringBuilder();
		sb.append("{\"result\":\"").append(result).append("\",");
		sb.append("\"code\":\"").append(code).append("\"}");
		
		return sb.toString();
	}
	
	/*
	 * mapToJson
	 * map 데이터를 json 스트링으로 변환
	 * input: HashMap
	 * output: String
	 */
	public static String mapToJson(Map<String, Object> inputMap) throws JsonGenerationException, JsonMappingException, IOException{
		String returnString = "";
		
		StringWriter writer = new StringWriter();
		ObjectMapper mapper = new ObjectMapper();
		
		mapper.writeValue(writer, inputMap);
		
		returnString = writer.toString();
		
		return returnString;
	}
}
