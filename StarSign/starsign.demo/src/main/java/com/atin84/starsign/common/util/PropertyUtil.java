package com.atin84.starsign.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.atin84.starsign.common.constant.ServiceConstant;

public class PropertyUtil {

	public static Map<String, Object> listToMap(List<Map<String, Object>> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		for (Map<String, Object> property : list) {
			map.put((String) property.get("NAME"), property.get("VALUE")); 
		}
		return map;
	}
	
	public static List<Map<String, Object>> mapToList(Map<String, Object> map) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		for (String key : map.keySet()) {
			
			if (key.equals(ServiceConstant.SERVICE_ACTION) || key.equals(ServiceConstant.SERVICE_RESPONSENAME))
				continue;
			
			Map<String, Object> property = new HashMap<String, Object>();
			
			property.put("NAME", key);
			property.put("VALUE", map.get(key));
			
			list.add(property);
		}
		return list;
	}
}
