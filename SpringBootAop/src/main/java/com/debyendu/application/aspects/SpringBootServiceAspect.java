package com.debyendu.application.aspects;

import org.aspectj.lang.JoinPoint;  
import org.aspectj.lang.annotation.Aspect;  
import org.aspectj.lang.annotation.Before;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;  
import org.springframework.web.reactive.function.client.WebClient;

@Aspect  
@Component 
public class SpringBootServiceAspect {

	
	@Before(value = "execution(* com.debyendu.application.*.*(..))")  
	public void beforeAdvice() {  
		
		
	}  
	
}
