package com.atin84.starsign.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * login Controller
 * @author semoria
 *
 */
@Controller
public class LoginController extends AbstractController {
	private static Logger logger = LoggerFactory.getLogger(LoginController.class);	
	/**
	 * Constructor
	 */
	public LoginController() {
		logger.debug("Create LoginController");
	}
	/**
	 * 로그인 요청시
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/login.do")
	public ModelAndView loginForm(ModelMap modelMap) {
		return new ModelAndView("login", modelMap);
	}
	/**
	 * Login 접근 금지 시...
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/denied.do")
	public ModelAndView deniedForm(ModelMap modelMap) {
		return new ModelAndView("denied");		
	}
	
	/**
	 * 성공 시 처리 페이지(테스트 용)
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/main.do")
	public ModelAndView sucessForm(ModelMap modelMap) {
		return new ModelAndView("main");
	}
}
