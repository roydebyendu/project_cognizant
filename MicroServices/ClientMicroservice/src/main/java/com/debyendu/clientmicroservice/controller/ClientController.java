package com.debyendu.clientmicroservice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.debyendu.clientmicroservice.repository.RemoteEmployeeRepository;
import com.debyendu.clientmicroservice.url.ResolveURL;

@RestController
@EnableAutoConfiguration
public class ClientController {


	@Autowired
	RemoteEmployeeRepository remoteEmployeeRepository;

	@Autowired
	ResolveURL resolveURL;

	@RequestMapping("/client")
	public String index() {

		String url = resolveURL.getEmployeeServiceURL();

		String empName = remoteEmployeeRepository.employeeName();

		return empName + "  from  "+ url;

	}

}