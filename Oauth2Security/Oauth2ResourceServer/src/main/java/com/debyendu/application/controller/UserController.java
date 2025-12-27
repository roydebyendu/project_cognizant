package com.debyendu.application.controller;

import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@EnableResourceServer
@RequestMapping("/secured")
public class UserController {

	@RequestMapping("/user")
	public String employeeName() {

		return "Greetings from Spring Boot!";

	}            
}