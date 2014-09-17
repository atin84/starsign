package com.atin84.starsign.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atin84.starsign.common.dao.CommonDao;
import com.atin84.starsign.web.WebConstant;
import com.atin84.starsign.web.model.GridModel;

/**
 * 기본 서비스 기능 모음
 * @author semoria
 *
 */
@Service
public class DefaultService {
	private static Logger logger = LoggerFactory.getLogger(DefaultService.class);
	
	@Autowired
	private CommonDao commonDao;
	
	public static final String PAGE = "page";
	
	public static final String ROWS = "rows";
	
	public static final String STARTIDX = "STARTIDX";
	
	public static final String ENDIDX = "ENDIDX";
	
	public static final String TOTALCNT = "TOTALCNT";
	
	public DefaultService() {
		logger.debug("Create DefaultService");
	}
	/**
	 * Select
	 * @param context
	 */
	public Object select(Map<String, Object> param) {
		return this.commonDao.selectToMap(param.get(WebConstant.SERVICE_ACTION).toString(), param);
	}
	
	/**
	 * List
	 * @param context
	 */
	public Object list(Map<String, Object> param) {
		return this.commonDao.selectToListMap(param.get(WebConstant.SERVICE_ACTION).toString(), param);
	}
	
	/**
	 * Update
	 * @param context
	 */
	public Object update(Map<String, Object> param) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status", this.commonDao.update(param.get(WebConstant.SERVICE_ACTION).toString(), param));
		return returnMap;
	}
	/**
	 * Insert
	 * @param context
	 */
	public Object insert(Map<String, Object> param) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status", this.commonDao.insert(param.get(WebConstant.SERVICE_ACTION).toString(), param));
		return returnMap;
	}
	/**
	 * Delete
	 * @param context
	 */
	public Object delete(Map<String, Object> param) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status", this.commonDao.delete(param.get(WebConstant.SERVICE_ACTION).toString(), param));
		return returnMap;
	}
	
	public Object update(String action, Map<String, Object> param) {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status", this.commonDao.update(action, param));
		return returnMap;
	}
	
	/**
	 * select Grid
	 * @param param
	 * @return
	 */
	public Object listGrid(Map<String, Object> param) {
		GridModel model = new GridModel();
		
		List<Map<String, Object>> returnList = null;
		
		if(param.get(PAGE) != null) {
			int pageNumber = Integer.parseInt((String)param.get(PAGE));
			int rows = Integer.parseInt((String)param.get(ROWS));
			
			int startIdx = (pageNumber-1)*rows + 1;
			int endIdx = pageNumber*rows;
			
			param.put(STARTIDX, startIdx);
			param.put(ENDIDX, endIdx);
			
			returnList = this.commonDao.selectToListMap(param.get(WebConstant.SERVICE_ACTION).toString(), param);
			
			int totalCnt = 0;
			int totalPage = 0;
			
			if(returnList.size() != 0) {
				totalCnt = (Integer)returnList.get(0).get(TOTALCNT);
				totalPage = (totalCnt -1) / rows + 1;
			}
			
			model.setPage(String.valueOf(pageNumber));
			model.setRecords(String.valueOf(totalCnt));
			model.setTotal(String.valueOf(totalPage));
		} else {
			returnList = this.commonDao.selectToListMap(param.get(WebConstant.SERVICE_ACTION).toString(), param);
		}		
		model.setRows(returnList);
		
		return model;
	}
}
