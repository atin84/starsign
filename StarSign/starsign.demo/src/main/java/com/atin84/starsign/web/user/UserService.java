package com.atin84.starsign.web.user;

import java.util.Map;

import com.atin84.starsign.web.user.model.UserModel;

public interface UserService {
	public UserModel viewUser(Map<String, Object> param);
	
	public Integer countUser(Map<String, Object> param);
	
	public void insertUser(Map<String, Object> param);
	
	public void updateUser(Map<String, Object> param);
}
