package com.atin84.starsign.web.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.LocaleResolver;

import com.atin84.starsign.common.dao.CommonDao;
import com.atin84.starsign.common.properties.PropertyManager;
import com.atin84.starsign.web.user.model.UserModel;

/**
 * <PRE>
 * Filename : SessionSuccessHandler.java
 * Class    : SessionSuccessHandler.java
 * Function : 
 * Comment  : Session Processing
 * Author   : pucktan
 * History  : 2010. 9. 27.
 * @version : 1.0
 * @author  : Copyright 2010 by GalimIT, Inc All Rights Reserved
 * </PRE>
 */

public class SessionSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private CommonDao dao;
	private LocaleResolver localeResolver;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Autowired
	private PropertyManager propertyManager;
	
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws ServletException, IOException {
				
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		HttpSession session = request.getSession();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        
        HashMap<String, Object> param = new HashMap<String, Object>();
        
        param.put("USERID", userDetails.getUsername().toString());
        
        UserModel currentUser = (UserModel)dao.selectToObj("select.userObjectInfo", param);
        
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap = dao.selectToMap("select.licenseKey", paramMap);
        String licenseKey;
        if(resultMap != null) {
        	licenseKey = (String)resultMap.get("LICENSEKEY");
        }
        else
        	licenseKey = "NA";
        
        session.setAttribute("licenseKey", licenseKey);
        
        session.setAttribute("currUser", currentUser);
        session.setAttribute("productVersion", propertyManager.getProductVersion());
        session.setAttribute("serverVersion", propertyManager.getServerVersion());
        session.setAttribute("v3meAgent", propertyManager.getV3meAgent());
        session.setAttribute("v3meClient", propertyManager.getV3meClient());
        session.setAttribute("refreshTime", propertyManager.getRefreshTime());
        
        String currentLocale = "ko";
        if(localeResolver != null) {
        	logger.debug("current locale from locale resolver : " + localeResolver.resolveLocale(request));
        	String locale = localeResolver.resolveLocale(request).toString();
        	locale = locale.trim();
        	locale = locale.toUpperCase();
        	if(locale.equals("KO") || locale.equals("KR") || locale.equals("KO_KR"))
        		currentLocale = "ko";
        	else if(locale.equals("EN") || locale.equals("US") || locale.equals("EN_US"))
        		currentLocale = "en";
        	else if(locale.equals("JP") || locale.equals("JA") || locale.equals("JP_JP"))
            		currentLocale = "jp";
            else {
        		//currentLocale = localeResolver.resolveLocale(request).toString();
        		currentLocale = "en";
        	}
        }
        session.setAttribute("currentLocale", currentLocale);
        
        
		if (savedRequest == null) {
            super.onAuthenticationSuccess(request, response, authentication);

            return;
        }

		if (isAlwaysUseDefaultTargetUrl()
                || StringUtils.hasText(request
                        .getParameter(getTargetUrlParameter()))) {
			requestCache.removeRequest(request, response);
            super.onAuthenticationSuccess(request, response, authentication);

            return;
        }
		
        // Use the SavedRequest URL
        String targetUrl = savedRequest.getRedirectUrl();
        logger.debug("Redirecting to SavedRequest Url: " + targetUrl);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
	}
	
	public void setCommonDao(CommonDao commonDao) {
		this.dao = commonDao;
	}
	public void setLocaleResolver(LocaleResolver localeResolver){
		this.localeResolver = localeResolver;
	}
}
