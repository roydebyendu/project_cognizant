package com.debyendu.clientmicroservice.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

public class RemoteEmployeeRepository {


	@Autowired
	protected RestTemplate restTemplate;

	protected String serviceUrl;

	public RemoteEmployeeRepository(String serviceUrl) {
		this.serviceUrl = serviceUrl.startsWith("http") ? serviceUrl : "http://" + serviceUrl;
	}

	public String employeeName() {
		String employeeName = "";
		employeeName = restTemplate.getForObject(serviceUrl+"/employeename", String.class);
		return employeeName;
	}

}