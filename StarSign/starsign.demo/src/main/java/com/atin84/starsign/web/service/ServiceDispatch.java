package com.atin84.starsign.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.atin84.starsign.web.WebConstant;
import com.atin84.starsign.web.model.GridModel;
import com.atin84.starsign.web.model.ServiceContext;
import com.atin84.starsign.web.util.PropertyUtil;

/**
 * 서비스 분배
 * @author semoria
 *
 */
@Service
public class ServiceDispatch {
	private static Logger logger = LoggerFactory.getLogger(ServiceDispatch.class);
	private Map<String, ServiceHandler> handlerMap;
	
	@Autowired
	private DefaultService defaultService;
		
	/**
	 * Constructor
	 */
	public ServiceDispatch() {
		logger.debug("Create ServiceDispatch");
	}
	
	@Transactional(readOnly = false, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
	public void dispatch(ServiceContext context) {
		for(Map<String, Object> serviceParam : context.getParamList()) {
			String action = serviceParam.get(WebConstant.SERVICE_ACTION).toString();
			String[] serviceName = action.split("\\.");
			
			logger.debug("Action name : " + action);
			
			ServiceHandler handler = this.handlerMap.get(serviceName[0]);
			if(handler == null) {
				logger.error(serviceName[0] + " 핸들러를 찾을수 없음");
				return;
			}
			
			Object obj = handler.handle(serviceParam);
			
			// 그리드 타입일 경우
			if(serviceName[0].equals(WebConstant.LIST_GRID)) {
				context.setGridModel((GridModel)obj);
			}
			// 일반적인 액션 수행결과
			else {
				String responseName = serviceParam.get(WebConstant.SERVICE_RESPONSENAME).toString();
				context.putRequestObj(responseName, obj);
			}
		}
	}

	@PostConstruct
	public void afterPropertiesSet() throws Exception {
		handlerMap = new HashMap<String, ServiceHandler>();
		handlerMap.put(WebConstant.SELECT, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.select(param);
			}
		});
		handlerMap.put(WebConstant.LIST, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.list(param);
			}
		});
		handlerMap.put(WebConstant.INSERT, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.insert(param);
			}
		});
		handlerMap.put(WebConstant.UPDATE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.update(param);
			}
		});
		handlerMap.put(WebConstant.DELETE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.delete(param);
			}
		});
		handlerMap.put(WebConstant.LIST_GRID, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.listGrid(param);
			}
		});

		handlerMap.put(WebConstant.PROPERTY_SELECT, new ServiceHandler() {
			@SuppressWarnings("unchecked")
			public Object handle(Map<String, Object> param) {
				return PropertyUtil.listToMap((List<Map<String, Object>>) defaultService.list(param));
			}
		});

		handlerMap.put(WebConstant.PROPERTY_UPDATE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				String action = param.get(WebConstant.SERVICE_ACTION).toString();
				List<Map<String, Object>> list = PropertyUtil.mapToList(param);
				
				logger.debug("Property List : " + list);

				Object object = null;
				
				for (Map<String, Object> property : list) {
					object = defaultService.update(action, property);
				}
				
				return object;
			}
		});
	}

	@PreDestroy
	public void destroy() throws Exception {
		
	}
}
