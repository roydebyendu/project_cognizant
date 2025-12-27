package com.debyendu.application.services;
 
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.provider.token.RemoteTokenServices;
import org.springframework.security.oauth2.provider.token.ResourceServerTokenServices;
 
@Configuration
public class TokenValidationService {
 
              @Value("${resource.oauth.clientId}")
              String RESOURCE_CLIENT_ID;
             
              @Value("${resource.oauth.clientSecret}")
              String RESOURCE_CLIENT_SECRET;
             
             
              @Bean
    public ResourceServerTokenServices tokenService() {
        RemoteTokenServices tokenServices = new RemoteTokenServices();
        tokenServices.setClientId(RESOURCE_CLIENT_ID);
        tokenServices.setClientSecret(RESOURCE_CLIENT_SECRET);
        tokenServices.setCheckTokenEndpointUrl("http://localhost:9090/oauth/check_token");
        return tokenServices;
    }
}