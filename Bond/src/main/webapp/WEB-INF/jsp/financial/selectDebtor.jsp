<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file="../login/login_error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
function go(debtorId, creditorId, debtorName) {
	document.frm.debtor_id.value = debtorId;
	document.frm.creditor_id.value = creditorId;
	document.frm.debtor_name.value = debtorName;
	document.frm.submit();
}
</script>
</head>
<body>
<form name="frm" action="financial" method="post">
<input type="hidden" name="lawyer_id" value="${lawyer_id }">
<table border="2" style="margin-left: auto; margin-right: auto;">
    <tr style="height: 50px; text-align: center;">
        <td colspan = "3" bgcolor = "lightgray" class = "style1">
            <h2>${lawyer_name}님의 Bond</h2>
        </td>                   
    </tr>
    <tr>
        <td style="text-align: center; width: 130px; bgcolor: lightgray">
            이름
        </td>
        <td style="text-align: center; width: 300px; bgcolor: lightgray">
            핸드폰번호
        </td>
        <td style="text-align: center; width: 100px;">
            선택
        </td>
    </tr>
    <c:forEach var="debtorList" items="${debtorList }" varStatus="status">
	<tr style="height: 40px;">
        <td style="text-align: center; width: 130px;"> 
            ${debtorList.debtor_name }
        </td>
        <td style="text-align: center; width: 200px;">
            ${debtorList.debtor_hp } 
        </td>
        <td style="text-align: center; width: 100px;">
            <input type="button" onclick="go('${debtorList.id}','${debtorList.creditorId }','${debtorList.debtor_name}')" value="선택" style="width:60px; height:30px;">
        </td>
    </tr>
    </c:forEach>
</table>
<input type="hidden" name="debtor_id" value=""> 
<input type="hidden" name="creditor_id" value="">
<input type="hidden" name="debtor_name" value="">

</form>

</body>
</html>