package com.atin84.starsign.web.controller.conveter;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class ParametersConverter {
	/**
	 * 
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static final List<Map<String, Object>> convertObject(Map paramMap) {
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		for (Iterator<Entry<String, Map>> iterator = paramMap.entrySet().iterator(); iterator.hasNext(); ) {
			
			Map<String, Object> tempMap = new HashMap<String, Object>();
			
			Entry<String, Map> entry = iterator.next();

			String key = entry.getKey().toString();
			
			Map value = entry.getValue();
			
			tempMap.put("responseName", key);
			
			returnList.add(convertObject(value, tempMap));
		}
		return returnList;
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	public static Map<String, Object> convertObject(WebRequest request) {
		Map<String, Object> tempMap = new HashMap<String, Object>();
		convertObject(request.getParameterMap(), tempMap);
		return tempMap;
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	public static Map<String, Object> convertObject(MultipartHttpServletRequest request) {
		Map<String, Object> tempMap = new HashMap<String, Object>();
		convertObject(request.getParameterMap(), tempMap);
		return tempMap;
	}
	
	/**
	 * 
	 * @param map
	 * @param tempMap
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map convertObject(Map map, Map tempMap) {
		for(Iterator<Entry> iterator = map.entrySet().iterator() ; iterator.hasNext();) {
			
			Entry entry = iterator.next();
			
			String key = entry.getKey().toString();
			Object value = entry.getValue();
			
			if (value == null) {
				tempMap.put(key, null);
        	}
        	else if (value.getClass().isArray()) {
        		if(Array.getLength(value) == 1) {
//        			System.out.println("1 : " + WebUtil.getEnCodingString(((String)Array.get(value, 0))) +  " / " + (String)Array.get(value, 0));
//        			tempMap.put(key, WebUtil.getEnCodingString(((String)Array.get(value, 0))));
        			tempMap.put(key, ((String)Array.get(value, 0)));
        		}
        		else {
        			List list = new ArrayList();
        			for(Object obj : Arrays.asList(value)) {
        				list.add(obj.toString());
//        				list.add(WebUtil.getEnCodingString(obj.toString()));
        			}
//        			System.out.println("2 : " + list);
        			tempMap.put(key, list);
        		}
        	}
        	else {
    			tempMap.put(key, value);
        	}
		}
		return tempMap;
	}
}