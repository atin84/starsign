package com.atin84.starsign.web.service.handler;

import java.util.Map;

/**
 * 서비스 핸들러
 * @author semoria
 *
 */
public interface ServiceHandler {
	/**
	 * 
	 * @param paramMap
	 * @return
	 */
	public Object handle(Map<String, Object> param);
}
