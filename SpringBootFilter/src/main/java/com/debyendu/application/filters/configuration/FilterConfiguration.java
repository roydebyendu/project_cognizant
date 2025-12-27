package com.debyendu.application.filters.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.debyendu.application.filters.TokenValidationFilter;

@Component
public class FilterConfiguration {

	@Autowired
	TokenValidationFilter tokenValidationFilter;
	
	@Bean
	public FilterRegistrationBean<TokenValidationFilter> filterRegistrationBean() { 
	    
	  // Filter Registration Bean 
	  FilterRegistrationBean<TokenValidationFilter> registrationBean = new FilterRegistrationBean(); 
	    
	  // Configure Authorization Filter 
	  registrationBean.setFilter(tokenValidationFilter); 
	    
	  // Specify URL Pattern 
	  registrationBean.addUrlPatterns("/index/*"); 
	    
	  // Set the Execution Order of Filter 
	  registrationBean.setOrder(1); 
	    
	  return registrationBean; 
	}
	
}
