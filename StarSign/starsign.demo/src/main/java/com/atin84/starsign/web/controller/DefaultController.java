package com.atin84.starsign.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.atin84.starsign.common.constant.ServiceConstant;
import com.atin84.starsign.common.dao.CommonDao;
import com.atin84.starsign.web.model.GridModel;
import com.atin84.starsign.web.model.ServiceContext;
import com.atin84.starsign.web.model.UserModel;
import com.atin84.starsign.web.service.ServiceDispatch;

@Controller
public class DefaultController extends AbstractController {
	private static Logger logger = LoggerFactory.getLogger(DefaultController.class);
	@Autowired
	private ServiceDispatch serviceDispatch;
	
	@Autowired
	private CommonDao dao;

	public DefaultController() {
		logger.debug("Create DefaultController");
	}

	@RequestMapping(value="/pageView/{page}.do", method=RequestMethod.GET)
	public ModelAndView pageView(WebRequest request, HttpServletRequest httprequest, ModelMap modelMap, @PathVariable("page") String page) throws IOException {
		
		logger.debug("CurrentLocale: " + request.getLocale());
		
		ModelAndView mav = new ModelAndView(page);
		
		// �곸쐞 �섏씠吏�硫붾돱
		String pageMenu = request.getParameter("pageMenu");
		if(pageMenu == null) {
			mav.addObject("pageMenu", "monitoring");
		}
		else {
			mav.addObject("pageMenu", pageMenu);
			mav.addObject("page", page);
		}
		
		String viewType = request.getParameter("VIEWTYPE");
		if(viewType != null) {
			mav.addObject("VIEWTYPE", viewType);
		}
		String lostStatus = request.getParameter("LOSTMODE");
		if(lostStatus != null) {
			mav.addObject("LOSTMODE", lostStatus);
		}
		
		String refresh = request.getParameter("refresh");
		if (refresh != null){
			HttpSession session = httprequest.getSession();
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("USERID", refresh);
			UserModel currentUser = (UserModel)dao.selectToObj("select.userObjectInfo", param);
            
	        session.setAttribute("currUser", currentUser);
		}
		
		return mav;
	}
	
	@RequestMapping(value="/properties/{lang}.do")
	public void getProperties(HttpServletRequest request, HttpServletResponse response, @PathVariable("lang") String lang) throws IOException {
		BufferedInputStream in = null;
		BufferedOutputStream out = null;
		try {
			in  = new BufferedInputStream(getClass().getClassLoader().getResourceAsStream("message/message_" + lang + ".properties"));
			out = new BufferedOutputStream(response.getOutputStream());
			
			FileCopyUtils.copy(in, out);
			out.flush();
		} finally {
			if (in != null) try { in.close(); } catch (Exception ignore) {}
			if (out != null) try { out.close(); } catch (Exception ignore) {}
		}
	}

	@RequestMapping(value="/pageView/{page}.do", method=RequestMethod.POST)
	public String pageViewPost(WebRequest request, ModelMap modelMap, @PathVariable("page") String page) {
		ServiceContext context = this.preExecute(request, modelMap);
		this.serviceDispatch.dispatch(context);
		return page;
	}

	@RequestMapping(value="/ajax/*.do")
	public @ResponseBody Map<String, Object> ajaxCall(WebRequest request, @RequestBody Map<String, Object> params) {
		ServiceContext context = this.preExecute(request, params);
		logger.debug("Ajax parameter : " + context.getParamList());
		this.serviceDispatch.dispatch(context);
		return (Map<String, Object>)context.getReturnObj();
	}

	@RequestMapping(value="/grid/*.do")
	public @ResponseBody GridModel gridList(WebRequest request) {
		ServiceContext context = this.preExecute(request);
		logger.debug("Grid parameter : " + context.getParamList());
		this.serviceDispatch.dispatch(context);
		return context.getGridModel();
	}
	
	@RequestMapping(value="/gridEdit/{query}.do")
	public String griEdit(WebRequest request, @PathVariable("query") String query, @RequestParam("oper") String operation) {
		ServiceContext context = this.preExecute(request);
		Map<String, Object> paramMap = context.getParamList().get(0);
		
		paramMap.put(ServiceConstant.SERVICE_RESPONSENAME, query);
		if(operation.equals("add")) {
			paramMap.put(ServiceConstant.SERVICE_ACTION, ServiceConstant.INSERT + "." + query);
		} else if(operation.equals("edit")) {
			paramMap.put(ServiceConstant.SERVICE_ACTION, ServiceConstant.UPDATE + "." + query);
		} else if(operation.equals("del")) {
			paramMap.put(ServiceConstant.SERVICE_ACTION, ServiceConstant.DELETE + "." + query);	
		} else {
			logger.warn("wrong grid edit message");
		}
		
		logger.debug("Grid Edit parameter : " + paramMap);
		this.serviceDispatch.dispatch(context);

		return "gridEdit";
	}
	
	@RequestMapping(value="/log.do")
	public String LogView(WebRequest request) {
		return "log";
	}
}
