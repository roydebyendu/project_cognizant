package com.debyendu.application.security.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@Configuration
@EnableAuthorizationServer
public class AuthorizationServerConfiguration extends AuthorizationServerConfigurerAdapter{

	@Value("${user.oauth.clientId}")
	String USER_CLIENT_ID;

	@Value("${user.oauth.clientSecret}")
	String USER_CLIENT_SECRET;

	@Value("${user.oauth.authority}")
	String USER_CLIENT_AUTHORITY;


	@Value("${resource.oauth.clientId}")
	String RESOURCE_CLIENT_ID;

	@Value("${resource.oauth.clientSecret}")
	String RESOURCE_CLIENT_SECRET;

	@Value("${resource.oauth.authority}")
	String RESOURCE_CLIENT_AUTHORITY;


	@Value("${common.oauth.password}")
	String PASSWORD;

	@Value("${common.oauth.grant.type}")
	String GRANT_TYPE;

	@Value("${common.oauth.authorization.code}")
	String AUTHORIZATION_CODE;

	@Value("${common.oauth.refresh.token}")
	String REFRESH_TOKEN;

	@Value("${common.oauth.implicit}")
	String IMPLICIT;

	@Value("${common.oauth.scope.read}")
	String SCOPE_READ;

	@Value("${common.oauth.scope.write}")
	String SCOPE_WRITE;

	@Value("${common.oauth.access.token.validity.seconds}")
	int ACCESS_TOKEN_VALIDITY_SECONDS;

	@Value("${common.oauth.refresh.token_validity.seconds}")
	int REFRESH_TOKEN_VALIDITY_SECONDS;


	//@Autowired
	//@Qualifier("dataSource")
	//private DataSource dataSource;

	@Autowired
	private InMemoryUserDetailsManager userDetailsService;

	@Autowired
	private PasswordEncoder userPasswordEncoder;

	@Autowired
	private TokenStore tokenStore;

	@Autowired
	private AuthenticationManager authenticationManager;

	@Override
	public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
		//clients.jdbc(dataSource);
		clients.inMemory()
		.withClient(USER_CLIENT_ID)
		.secret(userPasswordEncoder.encode(USER_CLIENT_SECRET))
		.authorizedGrantTypes(GRANT_TYPE, AUTHORIZATION_CODE, REFRESH_TOKEN, IMPLICIT, PASSWORD)
		.scopes(SCOPE_READ, SCOPE_WRITE)
		.and()
		.withClient(RESOURCE_CLIENT_ID)
		.secret(userPasswordEncoder.encode(RESOURCE_CLIENT_SECRET))
		.authorities(RESOURCE_CLIENT_AUTHORITY)
		.scopes(SCOPE_READ, SCOPE_WRITE)
		.authorizedGrantTypes(GRANT_TYPE, AUTHORIZATION_CODE, REFRESH_TOKEN, IMPLICIT, PASSWORD )
		.accessTokenValiditySeconds(ACCESS_TOKEN_VALIDITY_SECONDS)
		.refreshTokenValiditySeconds(REFRESH_TOKEN_VALIDITY_SECONDS)

		//to get authorization code
		.authorities(USER_CLIENT_AUTHORITY)
		.redirectUris("http://localhost:9191/auth/getAuthTokenGrantTypeAuthCode");


	}

	@Override
	public void configure(AuthorizationServerSecurityConfigurer security) throws Exception {
		/*
        security.tokenKeyAccess("permitAll()")
                .checkTokenAccess("isAuthenticated()");
                //.passwordEncoder(userPasswordEncoder);
		 */
		//secure the oauth/check_token endpoint
		security.checkTokenAccess("hasAuthority('"+RESOURCE_CLIENT_AUTHORITY+"')");

	}


	@Override
	public void configure(AuthorizationServerEndpointsConfigurer endpoints) throws Exception {
		endpoints.tokenStore(tokenStore)
		.authenticationManager(authenticationManager);
		//.userDetailsService(userDetailsService);
	}            

}