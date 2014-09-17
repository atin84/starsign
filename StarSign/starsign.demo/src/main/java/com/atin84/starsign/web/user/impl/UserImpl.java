package com.atin84.starsign.web.user.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atin84.starsign.common.dao.CommonDao;
import com.atin84.starsign.web.user.UserService;
import com.atin84.starsign.web.user.model.UserModel;

@Service
public class UserImpl implements UserService {

	@Autowired
	private CommonDao commonDao;
	
	@Override
	public UserModel viewUser(Map<String, Object> param) {
		return (UserModel)commonDao.selectToObj("select.userObjectInfo", param);
	}

	@Override
	public Integer countUser(Map<String, Object> param) {
		return (Integer) commonDao.selectToObj("select.adminCount", param);
	}

	@Override
	public void insertUser(Map<String, Object> param) {
		commonDao.insert("insert.admin", param);
	}

	@Override
	public void updateUser(Map<String, Object> param) {
		commonDao.update("update.admin", param);
	}

}
