package com.debyendu.application.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.stereotype.Service;

import com.debyendu.application.model.LoginUserDto;

@Service
public class AuthenticationService {

	@Autowired
	private InMemoryUserDetailsManager userDetailsService;

	@Autowired
	private AuthenticationManager authenticationManager;

	public UserDetails authenticate(LoginUserDto input) {

		Authentication  authentication = new UsernamePasswordAuthenticationToken(input.getEmail(), input.getPassword());

		authentication  =  authenticationManager.authenticate(authentication);

		return userDetailsService.loadUserByUsername(authentication.getName());

	}

}