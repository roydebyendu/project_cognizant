<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
              pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><spring:message code="title" /></title>
</head>
<body>
             
              <h2>${message}</h2>
              <h2><spring:message code="username" /> : ${UserName}</h2>
              <h2><spring:message code="username" /> : ${Password}</h2>
</body>
 
</body>
</html>
