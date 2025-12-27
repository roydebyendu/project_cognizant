package com.debyendu.application.controller;

import java.io.IOException;
import java.util.Arrays;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class ResourceAccessController {

	@RequestMapping("/getResources")
	public ResponseEntity getResources() throws IOException {

		ResponseEntity<String> response = null;

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		String get_token_url = "http://localhost:9191/auth/getAuthTokenGrantclientCredentials";

		HttpEntity<String> request = new HttpEntity<String>(headers);

		response = restTemplate.exchange(get_token_url, HttpMethod.POST, request, String.class);

		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(response.getBody());
		String token = node.path("access_token").asText();

		String url = "http://localhost:9292/secured/user";

		// Use the access token for authentication
		HttpHeaders headers1 = new HttpHeaders();
		headers1.add("Authorization", "Bearer " + token);
		HttpEntity<String> entity = new HttpEntity<>(headers1);

		ResponseEntity<String> data = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

		System.out.println("The Data from Resource server ---------" + data);

		return data;


	}
}