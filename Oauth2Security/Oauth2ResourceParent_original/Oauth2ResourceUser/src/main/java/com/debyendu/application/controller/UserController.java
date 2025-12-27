package com.debyendu.application.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/secured")
public class UserController {

	@RequestMapping("/user")
	public String userName() {

		return "Greetings from USER Spring Boot!";

	}            
}