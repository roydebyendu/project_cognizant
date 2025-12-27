package com.ccsc.application.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ccsc.application.dao.DatabaseConnection;
import com.ccsc.application.model.Employee;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Component
public class DataOperationInExcel {

	@Autowired
	DatabaseConnection databaseConnection;

	private static final Logger LOGGER = LoggerFactory.getLogger(DataOperationInExcel.class);

	public void writeExcel(String filePath, String fileName, String sheetName, List<Employee> empList)
			throws IOException {
		// Create an object of File class to open XLSX or XLS file
		File file = new File(filePath + "\\" + fileName);

		// Create an object of FileInputStream class to read excel file
		FileInputStream inputStream = new FileInputStream(file);
		Workbook workBook = null;
		// Find the file extension by splitting file name in substring and getting only extension name
		String fileExtensionName = fileName.substring(fileName.indexOf("."));
		// Check condition if the file is xlsx file
		if (fileExtensionName.equals(".xlsx")) {
			// If it is xlsx file then create object of XSSFWorkbook class
			workBook = new XSSFWorkbook(inputStream);
		}
		// Check condition if the file is xls file
		else if (fileExtensionName.equals(".xls")) {
			// If it is xls file then create object of HSSFWorkbook class
			workBook = new HSSFWorkbook(inputStream);
		}
		// Read excel sheet by sheet name
		Sheet sheet = workBook.getSheet(sheetName);
		Row newRow = null;
		Row headerRow = null;
		int rowCount = 0;

		Class empClass = Employee.class;
		Field[] fields = empClass.getDeclaredFields();

		if(sheet == null) {
			// If sheet is null then create new sheet
			sheet = workBook.createSheet(sheetName);

			headerRow = sheet.createRow(rowCount);
			for(int j=0; j < fields.length; j++) {
				String fieldName = String.valueOf(fields[j]).substring(String.valueOf(fields[j]).lastIndexOf(".")+1);
				// Fill data in row
				Cell cell = headerRow.createCell(j);
				if (fieldName.equals("empId")){                                                       
					cell.setCellValue("Employee Id");
				}else if(fieldName.equals("empName")) {
					cell.setCellValue("Employee Name");
				}else if(fieldName.equals("empDesignation")) {
					cell.setCellValue("Employee Designation");
				}
			}

			rowCount++;

		} else {
			// Get the current count of rows in excel file
			rowCount = sheet.getLastRowNum() + 1;
		}
		// Create a loop over the cell of newly created Row
		for (Employee emp : empList) {
			// Create a new row and append it at last of sheet
			newRow = sheet.createRow(rowCount);

			// Increase Row number
			rowCount++;

			for(int j=0; j < fields.length; j++) {
				String fieldName = String.valueOf(fields[j]).substring(String.valueOf(fields[j]).lastIndexOf(".")+1);
				// Fill data in row
				Cell cell = newRow.createCell(j);
				if (fieldName.equals("empId")){                                                       
					cell.setCellValue(emp.getEmpId());
				}else if(fieldName.equals("empName")) {
					cell.setCellValue(emp.getEmpName());
				}else if(fieldName.equals("empDesignation")) {
					cell.setCellValue(emp.getEmpDesignation());
				}
			}
		}

		// Close input stream
		inputStream.close();
		// Create an object of FileOutputStream class to create write data in excel file
		FileOutputStream outputStream = new FileOutputStream(file);
		// write data in the excel file
		workBook.write(outputStream);
		// close output stream
		outputStream.close();

	}

	public void writeNewExcel(String filePath, String fileName, String sheetName, List<Employee> empList)
			throws IOException {
		// Create an object of File class to open XLSX or XLS file
		File file = new File(filePath + "\\" + fileName);

		// Create an object of FileOutputStream class to create write data in excel file
		FileOutputStream outputStream = new FileOutputStream(file);

		Workbook workBook = null;
		// Find the file extension by splitting file name in substring and getting only extension name
		String fileExtensionName = fileName.substring(fileName.indexOf("."));
		// Check condition if the file is xlsx file
		if (fileExtensionName.equals(".xlsx")) {
			// If it is xlsx file then create object of XSSFWorkbook class
			workBook = new XSSFWorkbook();
		}
		// Check condition if the file is xls file
		else if (fileExtensionName.equals(".xls")) {
			// If it is xls file then create object of HSSFWorkbook class
			workBook = new HSSFWorkbook();
		}
		// Read excel sheet by sheet name
		Sheet sheet = workBook.getSheet(sheetName);
		Row newRow = null;
		Row headerRow = null;
		int rowCount = 0;

		List<Map<String,Object>> listOfMap = databaseConnection.getDBData();

		Set<String> headerFields = listOfMap.get(0).keySet();

		if(sheet == null) {
			// If sheet is null then create new sheet
			sheet = workBook.createSheet(sheetName);


			CellStyle styleHeader = workBook.createCellStyle();
			Font font = workBook.createFont();
			font.setFontName("Courier New");
			font.setBold(true);
			font.setColor((short) 10);
			font.setFontHeightInPoints((short) 12);
			styleHeader.setFont(font);
			//styleHeader.setFillBackgroundColor(IndexedColors.BLACK.index);
			//styleHeader.setFillPattern(FillPatternType.BIG_SPOTS);
			styleHeader.setFillForegroundColor(IndexedColors.AQUA.getIndex());
			styleHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);

			headerRow = sheet.createRow(rowCount);
			int column = 0;
			for(String headerFieldName : headerFields) {
				// Fill data in row
				Cell cell = headerRow.createCell(column);
				cell.setCellValue(headerFieldName);
				cell.setCellStyle(styleHeader);
				sheet.autoSizeColumn(column);
				column++;
			}

			rowCount++;

		} else {
			// Get the current count of rows in excel file
			rowCount = sheet.getLastRowNum() + 1;
		}

		CellStyle styleBody = workBook.createCellStyle();
		styleBody.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		styleBody.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		// Create a loop over the cell of newly created Row
		for (Map<String,Object> map : listOfMap) {
			int column = 0;
			Collection<Object> fieldsValues = map.values();

			// Create a new row and append it at last of sheet
			newRow = sheet.createRow(rowCount);

			for(Object fieldValue : fieldsValues) {
				// Fill data in row
				Cell cell = newRow.createCell(column);
				cell.setCellValue(String.valueOf(fieldValue));
				if(rowCount%2==0) {
					cell.setCellStyle(styleBody);
				}
				column++;
			}
			// Increase Row number
			rowCount++;
		}

		// write data in the excel file
		workBook.write(outputStream);
		// close output stream
		outputStream.close();

	}


	public void readExcel(String filePath, String fileName, String sheetName) throws IOException {
		// Create an object of File class to open xlsx file
		File file = new File(filePath + "\\" + fileName);
		// Create an object of FileInputStream class to read excel file
		FileInputStream inputStream = new FileInputStream(file);
		Workbook workBook = null;
		// Find the file extension by splitting file name in substring and getting only extension name
		String fileExtensionName = fileName.substring(fileName.indexOf("."));
		// Check condition if the file is xlsx file
		if (fileExtensionName.equals(".xlsx")) {
			// If it is xlsx file then create object of XSSFWorkbook class
			workBook = new XSSFWorkbook(inputStream);
		}
		// Check condition if the file is xls file
		else if (fileExtensionName.equals(".xls")) {
			// If it is xls file then create object of HSSFWorkbook class
			workBook = new HSSFWorkbook(inputStream);
		}
		// Read sheet inside the workbook by its name
		//Sheet sheet = workbook.getSheetAt(0);
		Sheet sheet = workBook.getSheet(sheetName);
		Row rowHeader = null;

		JsonObject innerObject = null;
		JsonArray jArray = new JsonArray();
		for(Row row : sheet) {
			if(row.getRowNum()==0) {
				rowHeader = row;
			}else {
				innerObject = new JsonObject();
				for (Cell cell : row) {
					switch(cell.getCellType()) {
					case STRING :
						innerObject.addProperty(rowHeader.getCell(cell.getColumnIndex()).getStringCellValue(), cell.getStringCellValue());
						break;
					case NUMERIC :
						innerObject.addProperty(rowHeader.getCell(cell.getColumnIndex()).getStringCellValue(), cell.getNumericCellValue());
						break;
					}
				}
				if(!innerObject.entrySet().isEmpty()) {
					jArray.add(innerObject);
				}
			}
		}

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String prettyJson = gson.toJson(jArray);
		System.out.println(prettyJson);

	}

	public void checkDuplicateValue(String filePath, String fileName, String sheetName) throws IOException {
		// Create an object of File class to open xlsx file
		File file = new File(filePath + "\\" + fileName);
		// Create an object of FileInputStream class to read excel file
		FileInputStream inputStream = new FileInputStream(file);
		Workbook workBook = null;
		// Find the file extension by splitting file name in substring and getting only extension name
		String fileExtensionName = fileName.substring(fileName.indexOf("."));
		// Check condition if the file is xlsx file
		if (fileExtensionName.equals(".xlsx")) {
			// If it is xlsx file then create object of XSSFWorkbook class
			workBook = new XSSFWorkbook(inputStream);
		}
		// Check condition if the file is xls file
		else if (fileExtensionName.equals(".xls")) {
			// If it is xls file then create object of HSSFWorkbook class
			workBook = new HSSFWorkbook(inputStream);
		}
		// Read sheet inside the workbook by its name
		//Sheet sheet = workbook.getSheetAt(0);
		Sheet sheet = workBook.getSheet(sheetName);
		Row rowHeader = null;

		int bodyRowCount = sheet.getLastRowNum() - sheet.getFirstRowNum();
		int itarationCount = 0;
		Set<Employee> employeeSet = new HashSet<Employee>();

		for(Row row : sheet) {
			if(row.getRowNum()==0) {
				rowHeader = row;
			}else {
				for (Cell cell : row) {
					itarationCount++;
					Employee emp = new Employee();
					switch(rowHeader.getCell(cell.getColumnIndex()).getStringCellValue()) {
					case "Employee Id" :
						emp.setEmpId((int)cell.getNumericCellValue());
						break;
					case "Employee Name" :
						emp.setEmpName(cell.getStringCellValue());
						break;
					case "Employee Designation" :
						emp.setEmpDesignation(cell.getStringCellValue());
						break;
					}

					employeeSet.add(emp);
				}

			}
		}
		if(itarationCount != employeeSet.size()) {
			LOGGER.info("There is duplicate row...");
		}


	}

}