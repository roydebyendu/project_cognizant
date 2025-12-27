package com.ccsc.application.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class DatabaseConnection {

	static Logger logger = LoggerFactory.getLogger(DatabaseConnection.class);

	public Connection conn=null;

	public String TBL_INTEG_CURATED = "TBL_INTEG_CURATED";


	private void getMySqlDatabaseConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://mysqlforlambda.cehql0eychse.us-east-1.rds.amazonaws.com:3306/ExampleDB";
			String username = "admin";
			String password = "password";

			conn = DriverManager.getConnection(url, username, password);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Caught exception: " + e.getMessage());
		}

	}



	public Map<String, String> getConnectorConfigInfo(String fromSystemId, String toSystemId, Connection conn) throws SQLException {

		logger.info("Enter getConnectorConfigInfo method of AuroraDBDao...");

		String TYPE_ASYNCHRONOUS = "ASYNCHRONOUS";

		Map<String, String> connectorSQSorLambdaMap = new HashMap<String,String>();

		StringBuilder sbSQL = new StringBuilder("SELECT ");
		sbSQL.append("CONNECTORID,");
		sbSQL.append("ACCOUNTID,");
		sbSQL.append("CONNECTORNAME,");
		sbSQL.append("FROMORGID,");
		sbSQL.append("FROMSYSTEMID,");
		sbSQL.append("TOORGID,");
		sbSQL.append("TOSYSTEMID,");
		sbSQL.append("EXCHANGETYPE,");
		sbSQL.append("CONNECTORTYPE,");
		sbSQL.append("CONNLISTENERSQSURL,");
		sbSQL.append("FAILEDMSGSQSURL,");
		sbSQL.append("FAILUREEMAILSNSARN,");
		sbSQL.append("STDCONNECTORAPIARN,");
		sbSQL.append("STDCONNECTORAPIURL,");
		sbSQL.append("HIGHCONFCONNECTORAPIARN,");
		sbSQL.append("HIGHCONFCONNECTORAPIURL,");
		sbSQL.append("ISTOSYSTEMDOWN,");
		sbSQL.append("ISLOCKREQ,");
		sbSQL.append("ORGSYSEVENTPATHKEY,");
		sbSQL.append("ISREGIONCDSPECURL,");
		sbSQL.append("MAXRETRYATTEMPTS,");
		sbSQL.append("S3BUCKETNAME,");
		sbSQL.append("ISACTIVE,");
		sbSQL.append("CREATEDBY,");
		sbSQL.append("CREATEDDT,");
		sbSQL.append("MODIFIEDBY,");
		sbSQL.append("MODIFIEDDT");
		sbSQL.append(" FROM ");
		sbSQL.append(" TBL_CONNECTORLIST ");
		sbSQL.append(" WHERE ");
		sbSQL.append(" FROMSYSTEMID = ? ");
		sbSQL.append(" AND ");
		sbSQL.append(" TOSYSTEMID = ? ");

		logger.info("SQL query Statement : "+sbSQL.toString());

		PreparedStatement ps = conn.prepareStatement(sbSQL.toString());
		ps.setInt(1, Integer.parseInt(fromSystemId));
		ps.setInt(2, Integer.parseInt(toSystemId));
		ResultSet rs = ps.executeQuery();

		if(null != rs) {
			while (rs.next()){
				if(TYPE_ASYNCHRONOUS.equalsIgnoreCase(rs.getString("CONNECTORTYPE"))) {
					logger.info("SQS URL is ..."+rs.getString("CONNLISTENERSQSURL"));
					connectorSQSorLambdaMap.put(rs.getString("CONNECTORTYPE"), rs.getString("CONNLISTENERSQSURL"));
				}
				logger.info("Exit getConnectorConfigInfo method of AuroraDBDao...");
				return connectorSQSorLambdaMap;  
			}

		}
		logger.info("Exit getConnectorConfigInfo method of AuroraDBDao...");

		return null;
	}

	public List<Map<String,Object>> getDBData(){

		List<Map<String,Object>> listOfMap = new ArrayList<Map<String,Object>>();

		Map<String,Object> map1 = new LinkedHashMap<String,Object>();

		map1.put("Employee Id", "793668");
		map1.put("Employee Name", "Debyendu Roy");
		map1.put("Employee Designation", "Senior Associate");

		Map<String,Object> map2 = new LinkedHashMap<String,Object>();
		map2.put("Employee Id", "12345");
		map2.put("Employee Name", "Chinmoy Roy");
		map2.put("Employee Designation", "Manager");

		Map<String,Object> map3 = new LinkedHashMap<String,Object>();
		map3.put("Employee Id", "793668");
		map3.put("Employee Name", "Debyendu Roy");
		map3.put("Employee Designation", "Senior Associate");

		Map<String,Object> map4 = new LinkedHashMap<String,Object>();
		map4.put("Employee Id", "12345");
		map4.put("Employee Name", "Chinmoy Roy");
		map4.put("Employee Designation", "Manager");

		listOfMap.add(map1);
		listOfMap.add(map2);
		listOfMap.add(map3);
		listOfMap.add(map4);

		return listOfMap;
	}

}