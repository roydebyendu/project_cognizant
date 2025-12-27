package com.debyendu.application.filters;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.Enumeration;

import org.springframework.core.annotation.Order;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@Component
@Order(1)
public class TokenValidationFilter implements Filter {

    @Override
    public void doFilter(
      ServletRequest request, 
      ServletResponse response, 
      FilterChain chain) throws IOException, ServletException {
 
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        res.setContentType(MediaType.APPLICATION_JSON_VALUE);
    	PrintWriter printWriter = null;
        
        
        Enumeration<String> headerNames = req.getHeaderNames();
        
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        while (headerNames.hasMoreElements()) {
			String headerName = (String) headerNames.nextElement();
			headers.add(headerName, req.getHeader(headerName));
		}
        
        System.out.println("Header value : "+headers);
        
        if(null != headers.get("token") && !headers.get("token").toString().isEmpty() && !headers.get("token").toString().isBlank()) {
        	/*
            WebClient client = WebClient.create("http://localhost:8080/SpringBootSecurity");
    		String validationResponse = client.post().uri("/auth/tokenvalidation")
    		.accept(MediaType.APPLICATION_JSON)
    		.contentType(MediaType.APPLICATION_JSON)
    		.bodyValue("")
    		.retrieve()
    		.bodyToMono(String.class)
    		.block();
            */
            WebClient client = WebClient.create("http://localhost:8080/SpringBootSecurity");
    		String validationResponse = client.post().uri("/auth/tokenvalidation")
    		.accept(MediaType.APPLICATION_JSON)
    		.contentType(MediaType.APPLICATION_JSON)
    		.headers(h -> h.addAll(headers))
    		.retrieve()
    		.bodyToMono(String.class)
    		.block();
    		
    		System.out.println("Token validation result ... "+validationResponse);
    		
    		if(null != validationResponse && !validationResponse.isEmpty() && !validationResponse.isBlank() 
    				&& "valid".equalsIgnoreCase(validationResponse)) {
    			
    			System.out.println( "Logging Request  {} : {}"+req.getMethod()+" : "+req.getRequestURI());
                chain.doFilter(request, response);
                System.out.println("Logging Response :{}"+res.getContentType());
    		
    		} else {
    			printWriter = res.getWriter();
    			printWriter.print("{\"message\" : \"Token validation failed ...\"}");
    		}	
            
        }else {
        	printWriter = res.getWriter();
        	printWriter.print("{\"message\" : \"Token Not Found ...\"}");
        }
        
    
    }

    // other methods
}
