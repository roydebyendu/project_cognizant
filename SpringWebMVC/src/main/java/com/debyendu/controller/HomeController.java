package com.debyendu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.debyendu.model.Employee;

@Controller
public class HomeController {


	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView showForm() {
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("employee", new Employee());
		mv.addObject("message", "Login");
		return mv;

	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String submit(@Validated @ModelAttribute("employee") Employee employee, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "error";
		}
		model.addAttribute("message", "User Information");
		model.addAttribute("UserName", employee.userName);
		model.addAttribute("Password", employee.password);
		return "employeeView";
	}

}
