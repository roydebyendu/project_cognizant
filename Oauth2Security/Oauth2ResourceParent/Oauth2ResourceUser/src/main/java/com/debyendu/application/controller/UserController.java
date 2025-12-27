package com.debyendu.application.controller;

import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@EnableResourceServer
@RestController
@RequestMapping("/secured")
public class UserController {

	@RequestMapping("/user")
	public String userName() {

		return "Greetings from USER Spring Boot!";

	}            
}