package com.debyendu.configurartionserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class ConfigurationServerApplication {

	public static void main(String[] args) {
		// Tell Boot to look for registration-server.yml
		System.setProperty("spring.config.name", "registration-server");
		SpringApplication.run(ConfigurationServerApplication.class, args);
	}
}