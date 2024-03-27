<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String category = request.getParameter("category");
String debtor_id = request.getParameter("debtor_id");
String excelStatus = request.getParameter("excelStatus");
if(excelStatus.equals("0")) {
%>
<h1>부분액셀화</h1>
<%} 
else    {%>
<h1>전체엑셀화</h1>

<%} %>
</body>
</html>