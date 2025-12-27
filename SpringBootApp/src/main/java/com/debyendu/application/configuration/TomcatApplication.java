package com.debyendu.application.configuration;

import java.util.Properties;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

//To deploy the war in tomcat
public class TomcatApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		Properties defaultProperties = new Properties();
		return application.properties(defaultProperties ).sources(Application.class);
	}

}