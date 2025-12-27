<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
              pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><spring:message code="title" /></title>
</head>
<body>
 
              <h2>${message}</h2>
              <form:form method="POST" action="/SpringWebMVC/login" modelAttribute="employee">
                             <table>
                                           <tr>
                                                          <td><form:label path="userName"><spring:message code="username" /></form:label></td>
                                                          <td><form:input path="userName" /></td>
                                           </tr>
                                           <tr>
                                                          <td><form:label path="password"><spring:message code="password" /></form:label></td>
                                                          <td><form:input path="password" /></td>
                                           </tr>
                                           <tr>
                                                          <td><input type="submit" value="Submit" /></td>
                                           </tr>
                             </table>
              </form:form>
</body>
 
</body>
</html>