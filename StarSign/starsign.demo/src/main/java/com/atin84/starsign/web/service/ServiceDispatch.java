package com.atin84.starsign.web.service;

import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.atin84.starsign.web.model.ServiceContext;

public interface ServiceDispatch {

	/**
	 * 서비스 분배
	 * @param context
	 * @throws WBSException 
	 */
	@Transactional(readOnly = false, rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
	public void dispatch(ServiceContext context);

}
