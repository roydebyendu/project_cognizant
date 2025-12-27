package com.debyendu.application.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;

@Configuration
@EnableResourceServer
public class ResourceServerConfiguration  extends ResourceServerConfigurerAdapter {

	@Value("${resource.oauth.resourceId}")
	String SECURED_RESOURCE_ID;

	@Value("${resource.oauth.read.scope}")
	String SECURED_READ_SCOPE;

	@Value("${resource.oauth.write.scope}")
	String SECURED_WRITE_SCOPE;

	@Value("${resource.oauth.secured.pattern}")
	String SECURED_PATTERN;

	@Value("${user.oauth.authority}")
	String USER_CLIENT_AUTHORITY;

	@Override
	public void configure(ResourceServerSecurityConfigurer resources) {
		resources.resourceId(SECURED_RESOURCE_ID);
	}

	@Override
	public void configure(HttpSecurity http) throws Exception {

		http.requestMatchers()
		.antMatchers(SECURED_PATTERN)
		.and()
		.authorizeRequests()
		.antMatchers(HttpMethod.POST, SECURED_PATTERN)
		.hasAuthority(USER_CLIENT_AUTHORITY);
		//.access(SECURED_WRITE_SCOPE)
		//.anyRequest()
		//.access(SECURED_READ_SCOPE);
	}

}
