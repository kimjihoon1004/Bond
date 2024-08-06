<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>    
<%@page import="java.util.Arrays"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String lawyer_id = request.getParameter("lawyer_id");
String debtor_id = request.getParameter("debtor_id");
String creditor_id = request.getParameter("creditor_id");
String debtor_name = request.getParameter("debtor_name");
String excelStatus = request.getParameter("excelStatus");
String fileName = request.getParameter("fileName");
%>
<form id="financialForm" action="financial" method="post">
    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
    <input type="hidden" name="debtor_name" value="<%=debtor_name %>">
</form>
<%
if(excelStatus.equals("0")) {
%>
<script type="text/javascript">
alert("<%=fileName%> 부분 엑셀 저장 성공");
location.href="javascript:history.back();";
</script>
<%
} 
else    {%>
<script type="text/javascript">
alert("<%=fileName%> 전체 엑셀 저장 성공");
location.href="javascript:history.back();";
</script>
<%} %>
</body>
</html>