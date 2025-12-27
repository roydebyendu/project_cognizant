package com.ccsc.application.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ccsc.application.model.Employee;
import com.ccsc.application.model.FileDataRequest;
import com.ccsc.application.model.FileDataResponse;
import com.ccsc.application.service.DataOperationInExcel;
import com.google.gson.JsonObject;

@RestController
@EnableAutoConfiguration
@PropertySource("classpath:application-server.properties")
@Component("FileController")
public class FileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(FileController.class);

	@Autowired
	DataOperationInExcel dataOperationInExcel;

	@RequestMapping("/index")
	public String index() {
		return "Greetings from Spring Boot!";
	}

	@RequestMapping(value="/file",
			method = RequestMethod.POST,
			consumes = "application/json",
			produces = "application/json")
	public FileDataResponse getFile(@RequestBody FileDataRequest fileDataRequest) {

		FileDataResponse fileDataResponse = new FileDataResponse();
		fileDataResponse.setFileData(fileDataRequest.getFileData());

		File file = null;
		File folder = new File(fileDataRequest.getFileData().getPath());
		if(folder.mkdirs()) {
			LOGGER.info("Folders are created ... "+folder.getAbsolutePath());
			file = new File(folder.getAbsolutePath()+"\\"+fileDataRequest.getFileData().getName());
		}else{
			LOGGER.info("Folders are already exists ... "+folder.getAbsolutePath());
			file = new File(folder.getAbsolutePath()+"\\"+fileDataRequest.getFileData().getName());
		}

		String initialString = fileDataRequest.getFileData().getContent();
		InputStream inputStream = IOUtils.toInputStream(initialString, StandardCharsets.UTF_8);

		try(OutputStream outputStream = new FileOutputStream(file)){
			IOUtils.copy(inputStream, outputStream);
		} catch (FileNotFoundException e) {
			System.out.println("This exception is : "+e);
		} catch (IOException e) {
			System.out.println("This exception is : "+e);
		}


		return fileDataResponse;

	}

	@RequestMapping(value="/writetoexcel",
			method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.APPLICATION_JSON_VALUE)
	public FileDataResponse writeDataToExcel(@RequestBody FileDataRequest fileDataRequest) throws Exception {

		FileDataResponse fileDataResponse = new FileDataResponse();
		fileDataResponse.setFileData(fileDataRequest.getFileData());

		List<Employee> empList = fileDataRequest.getFileData().getEmployeeList();

		//dataOperationInExcel.writeExcel(fileDataRequest.getFileData().getPath(), fileDataRequest.getFileData().getName(), "Data", empList);
		dataOperationInExcel.writeNewExcel(fileDataRequest.getFileData().getPath(), fileDataRequest.getFileData().getName(), "Data", empList);

		return fileDataResponse;

	}


	@RequestMapping(value="/readfromexcel",
			method = RequestMethod.POST,
			consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = MediaType.APPLICATION_JSON_VALUE)
	public FileDataResponse readDataFromExcel(@RequestBody FileDataRequest fileDataRequest) throws Exception {

		FileDataResponse fileDataResponse = new FileDataResponse();
		fileDataResponse.setFileData(fileDataRequest.getFileData());

		List<Employee> empList = new ArrayList<Employee>();


		//dataOperationInExcel.readExcel(fileDataRequest.getFileData().getPath(), fileDataRequest.getFileData().getName(), "Data");
		dataOperationInExcel.checkDuplicateValue(fileDataRequest.getFileData().getPath(), fileDataRequest.getFileData().getName(), "Data");

		return fileDataResponse;

	}

}