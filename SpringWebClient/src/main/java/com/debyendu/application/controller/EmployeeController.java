package com.debyendu.application.controller;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import com.debyendu.application.model.EmployeeRequest;
import com.debyendu.application.model.EmployeeResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import reactor.core.publisher.Mono;

@RestController
@EnableAutoConfiguration
@PropertySource("classpath:application-server.properties")
public class EmployeeController {

	@RequestMapping(value="/employee",
			method = RequestMethod.POST,
			consumes = "application/json",
			produces = "application/json")
	public EmployeeResponse getEmployee(@RequestBody EmployeeRequest employeeRequest) {

		WebClient client = WebClient.create("http://localhost:8080/SpringBootApp");
			EmployeeResponse employeeResponse = client.post().uri("/employee")
			.accept(MediaType.APPLICATION_JSON)
			.contentType(MediaType.APPLICATION_JSON)
			.bodyValue(employeeRequest)
			.retrieve()
			.bodyToMono(EmployeeResponse.class)
			.block();
		return employeeResponse;

	}

	@RequestMapping(value="/employeegson",
			method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.APPLICATION_JSON_VALUE)
	public JsonObject getEmployeeGson(@RequestBody JsonObject employeeRequest) {

		String empReq = new Gson().toJson(employeeRequest);
		/*
                             WebClient client = WebClient.create(http://localhost:8080/SpringBootApp);
                             String empResp = client.post().uri("/employeegson")
                                                                                                                                                               .block();
		 */

		WebClient client = WebClient.create("http://localhost:8080/SpringBootApp/employeegson");
			String empResp = client.post()
			.accept(MediaType.APPLICATION_JSON)
			.contentType(MediaType.APPLICATION_JSON)
			.bodyValue(empReq)
			.retrieve()
			.bodyToMono(String.class)
			.block();

		JsonObject employeeResponse =  new Gson().fromJson(empResp, JsonObject.class);
		return employeeResponse;

	}

	@RequestMapping(value="/employeeasync",
			method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.APPLICATION_JSON_VALUE)
	public JsonObject getEmployeeAsyncWebClient(@RequestBody JsonObject employeeRequest) {

		String empReq = new Gson().toJson(employeeRequest);

		MultiValueMap<String, String> headers = new LinkedMultiValueMap<String, String>();
		headers.add("content-type", MediaType.APPLICATION_JSON_VALUE);
		headers.add("accept", MediaType.APPLICATION_JSON_VALUE);

		WebClient webClient = WebClient.builder().build();
		WebClient.RequestBodySpec requestBodySpec = webClient
				.method(HttpMethod.POST)
				.uri("http://localhost:8080/SpringBootApp/employeegson");

					requestBodySpec.headers(h -> h.addAll(headers));

				requestBodySpec.bodyValue(empReq);

				Mono<ResponseEntity<String>> apiResponseMono = requestBodySpec.retrieve()
						.toEntity(String.class);

				ResponseEntity<String> apiResponse = apiResponseMono.block();
				String empResp = apiResponse.getBody();

				JsonObject employeeResponse =  new Gson().fromJson(empResp, JsonObject.class);
				return employeeResponse;
	}



}