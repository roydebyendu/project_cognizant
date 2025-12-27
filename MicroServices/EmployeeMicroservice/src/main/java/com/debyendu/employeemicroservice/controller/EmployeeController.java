package com.debyendu.employeemicroservice.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@EnableAutoConfiguration
@PropertySource("classpath:application-server.properties")
public class EmployeeController {

	@RequestMapping("/employeename")
	public String employeeName() {

		return "Greetings from Spring Boot!";

	}

}