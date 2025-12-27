package com.debyendu.clientmicroservice.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.client.RestTemplate;

import com.debyendu.clientmicroservice.repository.RemoteEmployeeRepository;

@SpringBootApplication
@EnableEurekaClient
@EnableDiscoveryClient
@ComponentScan(basePackages = { "com.debyendu.clientmicroservice" })
@PropertySource("classpath:config.properties")
public class ClientMicroserviceApplication {


	@Value("${EMPLOYEE_SERVICE}")
	private String EMPLOYEE_SERVICE_URL;

	public static void main(String[] args) {
		// Tell Boot to look for application-server.yml
		System.setProperty("spring.config.name", "application-server");
		SpringApplication.run(ClientMicroserviceApplication.class, args);
	}

	@Bean
	@LoadBalanced
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}

	@Bean
	@LoadBalanced
	public RemoteEmployeeRepository remoteEmployeeRepository() {
		return new RemoteEmployeeRepository(EMPLOYEE_SERVICE_URL);
	}


}