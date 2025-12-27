package com.ccsc.application.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Properties;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

//To deploy the war in tomcat
public class TomcatApplication extends SpringBootServletInitializer {

	private static final Logger LOGGER = LoggerFactory.getLogger(TomcatApplication.class);

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {

		Properties defaultProperties = new Properties();
		return application.properties(defaultProperties ).sources(Application.class);

	}

}