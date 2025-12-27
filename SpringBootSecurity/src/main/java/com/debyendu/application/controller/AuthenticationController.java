package com.debyendu.application.controller;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.debyendu.application.model.LoginResponse;
import com.debyendu.application.model.LoginUserDto;
import com.debyendu.application.security.AuthenticationService;
import com.debyendu.application.security.JwtService;

@RequestMapping("/auth")
@RestController
public class AuthenticationController {

	@Autowired
	private JwtService jwtService;

	@Autowired
	private InMemoryUserDetailsManager userDetailsService;

	@Autowired
	private AuthenticationService authenticationService;


	@PostMapping("/login")
	public ResponseEntity<LoginResponse> authenticate(@RequestBody LoginUserDto loginUserDto) {
		UserDetails authenticatedUser = authenticationService.authenticate(loginUserDto);

		String jwtToken = jwtService.generateToken(authenticatedUser);

		LoginResponse loginResponse = new LoginResponse();
		loginResponse.setToken(jwtToken);
		loginResponse.setExpiresIn(jwtService.getExpirationTime());

		return ResponseEntity.ok(loginResponse);
	}



	@PostMapping("/token")
	public ResponseEntity<LoginResponse> getToken(@RequestHeader MultiValueMap<String, String> headers) {
		LoginUserDto loginUserDto = new LoginUserDto();
		loginUserDto.setEmail(headers.get("email").get(0));
		loginUserDto.setPassword(headers.get("password").get(0));

		headers.forEach((key, value) -> {
			System.out.println(String.format("Header '%s' = %s", key, value.stream().collect(Collectors.joining("|"))));
		});

		UserDetails authenticatedUser = authenticationService.authenticate(loginUserDto);

		String jwtToken = jwtService.generateToken(authenticatedUser);

		LoginResponse loginResponse = new LoginResponse();
		loginResponse.setToken(jwtToken);
		loginResponse.setExpiresIn(jwtService.getExpirationTime());

		return ResponseEntity.ok(loginResponse);
	}
	
	
	@PostMapping("/tokenvalidation")
	public ResponseEntity<String> isTokenValid(@RequestHeader MultiValueMap<String, String> headers) {
		String authHeader = headers.get("token").get(0);
		
		headers.forEach((key, value) -> {
			System.out.println(String.format("Header '%s' = %s", key, value.stream().collect(Collectors.joining("|"))));
		});
		
		
		if (authHeader == null || !authHeader.startsWith("Bearer ")) {
			return null;
		}

		try {
			final String jwt = authHeader.substring(7);
			final String userEmail = jwtService.extractUsername(jwt);

			System.out.println("userEmail : " +userEmail);
			
			if (userEmail != null) {
				UserDetails userDetails = this.userDetailsService.loadUserByUsername(userEmail);

				if (jwtService.isTokenValid(jwt, userDetails)) {
					return ResponseEntity.ok("valid");	
				}
			}

		} catch (Exception exception) {
			System.out.println(exception);
		}
		
		return ResponseEntity.ok("notvalid");
	}
	
}