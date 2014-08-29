package com.atin84.starsign.web.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atin84.starsign.common.dao.CommonDao;
import com.atin84.starsign.common.properties.PropertyManager;

@Controller
public class AdminController extends AbstractController {
	private static Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private CommonDao commonDao;

	@Autowired
	private PropertyManager propertyManager;
	
	/**
	 *
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/AdminPWReset.do")
	public void adminPWReset(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String localIPv4 = "127.0.0.1";
		String localIPv6 = "0:0:0:0:0:0:0:1";
		
		String serverIP = "";
		String clientIP = request.getRemoteAddr();
		
		try {
			InetAddress inet= InetAddress.getLocalHost();
			
			inet= InetAddress.getLocalHost();
			
			serverIP = inet.getHostAddress();
			
			logger.debug("localhost IP 二쇱냼 : " + inet.getHostAddress() + "\n");
        }
        catch (UnknownHostException uhe) {
        	logger.debug("�몄뒪�몃� 李얠쓣 ���놁뒿�덈떎.");
            uhe.printStackTrace() ;
        }        
		

		logger.debug("==== AdminPWReset - Server IP:" + serverIP + "  -  Client IP:"+ clientIP);
	
		if(clientIP.equals(serverIP) || clientIP.equals(localIPv4) || clientIP.equals(localIPv6)) {
			
			//String defaultWebAdminID = "admin";
			//String defaultWebAdminPW = "admin";
			String defaultWebAdminID = this.propertyManager.getDefaultAdminID();
			String defaultWebAdminPW = this.propertyManager.getDefaultAdminPW();
			
			Map<String, Object> sqlParam = new HashMap<String, Object>();
			
			sqlParam.put("ADMINID", defaultWebAdminID);
			sqlParam.put("PW", getMD5String(defaultWebAdminPW));
			
			// 1. �대� 議댁옱�섎뒗吏�泥댄겕
			List<Map<String, Object>> selectList = null;
			selectList = this.commonDao.selectToListMap("select.adminCount", sqlParam);
			
			if(selectList.size() > 0) {
				Map<String, Object> result = selectList.get(0);
				
				int count = Integer.parseInt(result.get("COUNT").toString());
				
				if(count == 0) {
					//2. ID媛��놁쑝硫�Insert
					sqlParam.put("NAME", "AMC");
					sqlParam.put("PHONE", "01000000000");
					sqlParam.put("EMAIL", "webadmin@amc.com");
					sqlParam.put("STARTIP", "0.0.0.0");
					sqlParam.put("ENDIP", "255.255.255.255");
					sqlParam.put("DESCRIPTION", "AhnLabMobileCenter(AMC)");
					
					adminInsert(sqlParam);
				}
				else {
					//3. ID媛��덉쑝硫�Update
					sqlParam.put("PWRETRYCOUNT", "0");
					adminUpdate(sqlParam);
				}
			}
		}
	}
	
	public void adminInsert(Map<String, Object> param) {
		this.commonDao.insert("insert.admin", param);
	}
	
	public void adminUpdate(Map<String, Object> param) {
		this.commonDao.update("update.admin", param);
	}

	/*
	 * MD5 蹂�솚
	 */
	public String getMD5String(String msg) {
		byte[] defaultBytes = msg.getBytes();
		
		try {
			MessageDigest algorithm = MessageDigest.getInstance("MD5");
			algorithm.reset();
			algorithm.update(defaultBytes);
			byte messageDigest[] = algorithm.digest();

			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < messageDigest.length; i++) {
				String hex = Integer.toHexString(0xff & messageDigest[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			logger.debug("==== String Convert MD5(ORG):" + msg);
			logger.debug("==== String Convert MD5(MD5):" + hexString.toString());

			msg = hexString + "";
		} catch (NoSuchAlgorithmException nsae) {
		}
		
		return msg;
	}
}
