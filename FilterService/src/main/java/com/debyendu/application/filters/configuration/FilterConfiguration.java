package com.debyendu.application.filters.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.debyendu.application.filters.RequestResponseLoggingFilter;

@Component
public class FilterConfiguration {

	@Autowired
	RequestResponseLoggingFilter requestResponseLoggingFilter;
	
	@Bean
	public FilterRegistrationBean<RequestResponseLoggingFilter> filterRegistrationBean() { 
	    
	  // Filter Registration Bean 
	  FilterRegistrationBean<RequestResponseLoggingFilter> registrationBean = new FilterRegistrationBean(); 
	    
	  // Configure Authorization Filter 
	  registrationBean.setFilter(requestResponseLoggingFilter); 
	    
	  // Specify URL Pattern 
	  registrationBean.addUrlPatterns("/login/*"); 
	    
	  // Set the Execution Order of Filter 
	  registrationBean.setOrder(1); 
	    
	  return registrationBean; 
	}
	
}
