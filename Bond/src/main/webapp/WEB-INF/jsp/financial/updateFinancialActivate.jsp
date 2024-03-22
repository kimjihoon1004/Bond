<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>변제금/대여금 수정</title>
</head>
<body>
<%
String debt_condition = request.getParameter("debt_condition");
String lawyer_id = request.getParameter("lawyer_id");
String debtor_id = request.getParameter("debtor_id");
String creditor_id = request.getParameter("creditor_id");
String debtor_name = request.getParameter("debtor_name");
if(debt_condition.equals("rental")) {
	%>
    
	<form id="financialForm" action="financial" method="post">
	    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
	    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
	    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
	    <input type="hidden" name="debtor_name" value="<%=debtor_name %>">
	</form>
	<script type="text/javascript">
	if(${success} == 0) {
		alert("대여 수정 실패");
		location.href="javascript:history.back();";
	}
	else    {
		alert("대여 수정 완료");
		document.getElementById("financialForm").submit();
	}
	</script>
<%}
else    {%>
    <form id="financialForm" action="financial" method="post">
        <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
        <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
        <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
        <input type="hidden" name="debtor_name" value="<%=debtor_name %>">
    </form>
    <script type="text/javascript">
    if(${success} == 0) {
        alert("변제 수정 실패");
        location.href="javascript:history.back();";
    }
    else    {
        alert("변제 수정 완료");
        document.getElementById("financialForm").submit();
    }
    </script>
<%} %>

</body>
</html>