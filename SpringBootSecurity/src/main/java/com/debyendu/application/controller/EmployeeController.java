package com.debyendu.application.controller;

import org.springframework.web.bind.annotation.RestController;

import com.debyendu.application.model.EmployeeRequest;
import com.debyendu.application.model.EmployeeResponse;
import com.debyendu.application.security.JwtService;
import com.google.gson.JsonObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@RestController
@EnableAutoConfiguration
@Component("EmployeeController")
public class EmployeeController {


	@RequestMapping("/index")
	public String index() {

		return "!Greetings from Debyendu...";
	}



	@RequestMapping(value="/employee",
			method = RequestMethod.POST,
			consumes = "application/json",
			produces = "application/json")
	public EmployeeResponse getEmployee(@RequestBody EmployeeRequest employeeRequest) {

		System.out.println("This is here...."+employeeRequest.getEmployee());
		EmployeeResponse employeeResponse = new EmployeeResponse();
		employeeResponse.setEmployee(employeeRequest.getEmployee());

		return employeeResponse;

	}

	@RequestMapping(value="/employeegson",
			method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.APPLICATION_JSON_VALUE)
	public JsonObject getEmployeeGson(@RequestBody JsonObject employeeRequest) {

		JsonObject employeeResponse =  employeeRequest;

		return employeeResponse;

	}

}