package com.debyendu.clientmicroservice.url;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;

@Component
public class ResolveURL {


	@Value("${EMPLOYEE_SERVICE}")
	private String EMPLOYEE_SERVICE_ID;

	@Autowired
	private EurekaClient eurekaClient;

	public String getEmployeeServiceURL() {
		String url = "";
		Application application = eurekaClient.getApplication(EMPLOYEE_SERVICE_ID);
		InstanceInfo instanceInfo = application.getInstances().get(0);
		url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort();
		System.out.println("URL" + url);
		return url;
	}

}