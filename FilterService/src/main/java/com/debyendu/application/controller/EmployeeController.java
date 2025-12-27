package com.debyendu.application.controller;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@Component("EmployeeController")
public class EmployeeController {

	@RequestMapping("/index")
	public String index() {
		System.out.println("This is actual service ...");
		return "Greetings from Spring Boot!";
	}

	@RequestMapping("/login")
	public String login() {
		System.out.println("This is actual service ...");
		return "You are logged in !";
	}
	
}
