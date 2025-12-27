package com.debyendu.application.controller;

import java.io.IOException;
import java.net.URI;
import java.util.Arrays;
import java.util.Base64;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RequestMapping("/auth")
@RestController
public class ClientController {

	@RequestMapping("/getAuthTokenGrantTypePassword")
	public ResponseEntity getAuthTokenGrantTypePassword() throws IOException {
		ResponseEntity<String> response = null;

		RestTemplate restTemplate = new RestTemplate();

		// According OAuth documentation we need to send the client id and secret key in the header for authentication
		String credentials = "client:secret";
		String encodedCredentials = new String(Base64.getEncoder().encode(credentials.getBytes()));

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		headers.add("Authorization", "Basic " + encodedCredentials);
		headers.add("Content-Type", "application/x-www-form-urlencoded");

		String access_token_url = "http://localhost:9090/oauth/token";

		String access_token_body = "";
		access_token_body += "username=" + "debyendu";
		access_token_body += "&password=" + "roy";
		access_token_body += "&grant_type=password";

		HttpEntity<String> request = new HttpEntity<String>(access_token_body, headers);

		System.out.println("Authorization Token URL ---------" + access_token_url);

		response = restTemplate.exchange(access_token_url, HttpMethod.POST, request, String.class);

		System.out.println("Access Token Response ---------" + response.getBody());

		return response;
	}


	@RequestMapping("/getAuthTokenGrantclientCredentials")
	public ResponseEntity getAuthTokenGrantclientCredentials() throws IOException {
		ResponseEntity<String> response = null;

		RestTemplate restTemplate = new RestTemplate();

		// According OAuth documentation we need to send the client id and secret key in the header for authentication
		String credentials = "client:secret";
		String encodedCredentials = new String(Base64.getEncoder().encode(credentials.getBytes()));

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		headers.add("Authorization", "Basic " + encodedCredentials);
		headers.add("Content-Type", "application/x-www-form-urlencoded");

		String access_token_url = "http://localhost:9090/oauth/token";

		String access_token_body = "";
		access_token_body += "client_id=" + "client";
		access_token_body += "&secret=" + "secret";
		access_token_body += "&grant_type=client_credentials";

		HttpEntity<String> request = new HttpEntity<String>(access_token_body, headers);

		System.out.println("Authorization Token URL ---------" + access_token_url);

		response = restTemplate.exchange(access_token_url, HttpMethod.POST, request, String.class);

		System.out.println("Access Token Response ---------" + response.getBody());

		return response;
	}

	@RequestMapping("/getAuthCode")
	public ResponseEntity getAuthCode() throws IOException {
		ResponseEntity<String> response = null;

		RestTemplate restTemplate = new RestTemplate();


		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		headers.add("Content-Type", "application/x-www-form-urlencoded");

		HttpEntity<String> request = new HttpEntity<String>(headers);


		String auth_code_url = "http://localhost:9090/oauth/authorize";
		auth_code_url += "?response_type=code";
		auth_code_url += "&client_id=" + "client";

		System.out.println("Authorization Code URL ---------" + auth_code_url);

		//response = restTemplate.exchange(auth_code_url, HttpMethod.GET, request, String.class);

		//System.out.println("Authorization Code Response ---------" + response);

		//return null;
		return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(auth_code_url)).build();
	}

	@RequestMapping("/getAuthTokenGrantTypeAuthCode")
	public ResponseEntity getAuthTokenGrantTypeAuthCode(@RequestParam("code") String code) throws IOException {
		ResponseEntity<String> response = null;
		System.out.println("Authorization Code------" + code);

		RestTemplate restTemplate = new RestTemplate();

		// According OAuth documentation we need to send the client id and secret key in the header for authentication
		String credentials = "client:secret";
		String encodedCredentials = new String(Base64.getEncoder().encode(credentials.getBytes()));

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		headers.add("Authorization", "Basic " + encodedCredentials);
		headers.add("Content-Type", "application/x-www-form-urlencoded");

		HttpEntity<String> request = new HttpEntity<String>(headers);

		String access_token_url = "http://localhost:9090/oauth/token";
		access_token_url += "?code=" + code;
		access_token_url += "&grant_type=authorization_code";

		System.out.println("Authorization Token URL ---------" + access_token_url);

		response = restTemplate.exchange(access_token_url, HttpMethod.POST, request, String.class);

		System.out.println("Access Token Response ---------" + response.getBody());

		return response;
	}
}
