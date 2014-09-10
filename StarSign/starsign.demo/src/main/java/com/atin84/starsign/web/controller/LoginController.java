package com.atin84.starsign.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * login Controller
 * @author atin
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

	@RequestMapping(value="/login.do")
	public ModelAndView loginForm(ModelMap modelMap) {
		return new ModelAndView("login", modelMap);
	}

	@RequestMapping(value="/denied.do")
	public ModelAndView deniedForm(ModelMap modelMap) {
		return new ModelAndView("denied");		
	}
	
	@RequestMapping(value="/main.do")
	public ModelAndView sucessForm(ModelMap modelMap) {
		return new ModelAndView("main");
	}
}
