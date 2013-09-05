package com.atin84.starsign.web.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.atin84.starsign.common.constant.ServiceConstant;
import com.atin84.starsign.common.util.PropertyUtil;
import com.atin84.starsign.web.model.GridModel;
import com.atin84.starsign.web.model.ServiceContext;
import com.atin84.starsign.web.service.DefaultService;
import com.atin84.starsign.web.service.ServiceDispatch;
import com.atin84.starsign.web.service.handler.ServiceHandler;

/**
 * 서비스 분배
 * @author semoria
 *
 */
@Service
public class ServiceDispatchImpl implements InitializingBean, DisposableBean, ServiceDispatch {
	private static Logger logger = LoggerFactory.getLogger(ServiceDispatchImpl.class);
	private Map<String, ServiceHandler> handlerMap;
	
	@Autowired
	private DefaultService defaultService;
		
	/**
	 * Constructor
	 */
	public ServiceDispatchImpl() {
		logger.debug("Create ServiceDispatch");
	}
	
	/* (non-Javadoc)
	 * @see com.anlab.v3me.admin.web.service.ServiceDispatch#dispatch(com.anlab.v3me.admin.web.model.ServiceContext)
	 */
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
	public void dispatch(ServiceContext context) {
		for(Map<String, Object> serviceParam : context.getParamList()) {
			String action = serviceParam.get(ServiceConstant.SERVICE_ACTION).toString();
			String[] serviceName = action.split("\\.");
			
			logger.debug("Action name : " + action);
			
			ServiceHandler handler = this.handlerMap.get(serviceName[0]);
			if(handler == null) {
				logger.error(serviceName[0] + " 핸들러를 찾을수 없음");
				return;
			}
			
			Object obj = handler.handle(serviceParam);
			
			// 그리드 타입일 경우
			if(serviceName[0].equals(ServiceConstant.LIST_GRID)) {
				context.setGridModel((GridModel)obj);
			}
			// 일반적인 액션 수행결과
			else {
				String responseName = serviceParam.get(ServiceConstant.SERVICE_RESPONSENAME).toString();
				context.putRequestObj(responseName, obj);
			}
		}
	}

	@Override
	@PostConstruct
	public void afterPropertiesSet() throws Exception {
		handlerMap = new HashMap<String, ServiceHandler>();
		handlerMap.put(ServiceConstant.SELECT, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.select(param);
			}
		});
		handlerMap.put(ServiceConstant.LIST, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.list(param);
			}
		});
		handlerMap.put(ServiceConstant.INSERT, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.insert(param);
			}
		});
		handlerMap.put(ServiceConstant.UPDATE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.update(param);
			}
		});
		handlerMap.put(ServiceConstant.DELETE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.delete(param);
			}
		});
		handlerMap.put(ServiceConstant.LIST_GRID, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				return defaultService.listGrid(param);
			}
		});

		handlerMap.put(ServiceConstant.PROPERTY_SELECT, new ServiceHandler() {
			@SuppressWarnings("unchecked")
			public Object handle(Map<String, Object> param) {
				return PropertyUtil.listToMap((List<Map<String, Object>>) defaultService.list(param));
			}
		});

		handlerMap.put(ServiceConstant.PROPERTY_UPDATE, new ServiceHandler() {
			public Object handle(Map<String, Object> param) {
				String action = param.get(ServiceConstant.SERVICE_ACTION).toString();
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

	@Override
	public void destroy() throws Exception {
		
	}
}
