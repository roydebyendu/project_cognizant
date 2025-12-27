package com.debyendu.employeemicroservice.configuration;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableEurekaClient
@EnableDiscoveryClient
@ComponentScan(basePackages = { "com.debyendu.employeemicroservice.controller" })
public class EmployeeMicroserviceApplication {

	public static void main(String[] args) {
		// Tell Boot to look for application-server.yml
		System.setProperty("spring.config.name", "application-server");
		SpringApplication.run(EmployeeMicroserviceApplication.class, args);
	}
}