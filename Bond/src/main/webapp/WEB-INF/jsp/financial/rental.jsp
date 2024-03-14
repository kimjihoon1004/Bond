<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>대여</title>
</head>
<body>
<%
String lawyer_id = request.getParameter("lawyer_id");
String debtor_id = request.getParameter("debtor_id");
String creditor_id = request.getParameter("creditor_id");
String date = request.getParameter("date");
String rental = request.getParameter("rental");
String interest = request.getParameter("interest");
%>
<form id="financialForm" action="financial" method="post">
    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
    <input type="hidden" name="debtor_name" value="${debtor_name }">
</form>
<script type="text/javascript">
if(${success} == 0)   {
    alert("대여 오류 발생");
    location.href="javascript:history.back();";
}
else  {
    alert("대여하였습니다.");
    document.getElementById("financialForm").submit();
}
</script>


</body>
</html>