package com.atin84.starsign.web.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;

/**
 * 
 * @author semoria
 *
 */
public class ServiceContext {
	private WebRequest request;
	private ModelMap modelMap;
	
	private String serviceType;
	
	private List<Map<String, Object>> paramList;
	
	private Map<String, Object> returnObj;
	
	private GridModel gridModel;
	
	public ServiceContext() {
		this.paramList = new ArrayList<Map<String, Object>>();
		this.returnObj = new HashMap<String, Object>();
	}
		
	public void setRequest(WebRequest request) {
		this.request = request;
	}
	public WebRequest getRequest() {
		return request;
	}
	
	public void setModelMap(ModelMap modelMap) {
		this.modelMap = modelMap;
	}
	public ModelMap getModelMap() {
		return modelMap;
	}
	
	public void addParam(Map<String, Object> param) {
		this.paramList.add(param);
	}
	public void setParamList(List<Map<String, Object>> paramList) {
		this.paramList = paramList;
	}
	public List<Map<String, Object>> getParamList() {
		return paramList;
	}
	
	public Map<String, Object> getReturnObj() {
		return this.returnObj;
	}
	public void putRequestObj(String key, Object obj) {
		this.returnObj.put(key, obj);
	}

	public void setGridModel(GridModel gridModel) {
		this.gridModel = gridModel;
	}

	public GridModel getGridModel() {
		return gridModel;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getServiceType() {
		return serviceType;
	}
}
