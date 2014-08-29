package com.atin84.starsign.web.controller;

import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;

import com.atin84.starsign.common.converter.ParametersConverter;
import com.atin84.starsign.web.model.ServiceContext;

public abstract class AbstractController {	

	protected ServiceContext preExecute(WebRequest request) {
		 ServiceContext serviceContext = new ServiceContext();
		 serviceContext.setRequest(request);
	        
		 serviceContext.addParam(ParametersConverter.convertObject(request));
	        
		 return serviceContext;
	}
	
	protected ServiceContext preExecute(WebRequest request, ModelMap model) {
        ServiceContext serviceContext = new ServiceContext();
        serviceContext.setRequest(request);
        serviceContext.setModelMap(model);
        
        serviceContext.addParam(ParametersConverter.convertObject(request));
        
        return serviceContext;
    }
	
	protected ServiceContext preExecute(WebRequest request, Map<String, Object> params) {
        ServiceContext serviceContext = new ServiceContext();
        serviceContext.setRequest(request);
        
        serviceContext.setParamList(ParametersConverter.convertObject(params));
        
        return serviceContext;
    }
}
