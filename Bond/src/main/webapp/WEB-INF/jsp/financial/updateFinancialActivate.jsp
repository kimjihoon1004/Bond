<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������/�뿩�� ����</title>
</head>
<body>
<%
String lawyer_id = request.getParameter("lawyer_id");
String debtor_id = request.getParameter("debtor_id");
String creditor_id = request.getParameter("creditor_id");
String debtor_name = request.getParameter("debtor_name");
System.out.println(lawyer_id + " " + debtor_id + " " + debtor_name + " " + creditor_id);
%>
<form id="financialForm" action="financial" method="post">
    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
    <input type="hidden" name="debtor_name" value="<%=debtor_name %>">
</form>
<script type="text/javascript">
if(${success} == 0) {
	alert("ä�� ���� ����");
	location.href="javascript:history.back();";
}
else    {
	alert("ä�� ���� �Ϸ�");
	document.getElementById("financialForm").submit();
}
</script>


</body>
</html>