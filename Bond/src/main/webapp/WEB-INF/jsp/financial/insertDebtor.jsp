<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>채무자 추가</title>
</head>
<body>
<script type="text/javascript">
function nullCheck()    {
	var name = document.debtorTable.debtor_name.value;
	var hp1 = document.debtorTable.hp1.value;
	var hp2 = document.debtorTable.hp2.value;
	var hp3 = document.debtorTable.hp3.value;
	var email = document.debtorTable.debtor_id.value;
	
	if(name === "")    {
		alert("이름을 입력하세요.");
		document.debtorTable.debtor_name.focus();
		return false;
	}
	if(hp1 === "")    {
        alert("전화번호를 입력하세요.");
        document.debtorTable.hp1.focus();
        return false;
    }
	if(hp2 === "")    {
        alert("전화번호를 입력하세요.");
        document.debtorTable.hp2.focus();
        return false;
    }
	if(hp3 === "")    {
        alert("전화번호를 입력하세요.");
        document.debtorTable.hp3.focus();
        return false;
    }
	if(email === "")    {
        alert("이메일를 입력하세요.");
        document.debtorTable.debtor_id.focus();
        return false;
    }
	return true;
}
</script>

<%
int lawyer_id = (int) session.getAttribute("lawyerId");
%>
<form name="debtorTable" action="insertDebtorActivate" method="post" onsubmit="return nullCheck()" >
<input type="hidden" value="<%=lawyer_id %>" name="lawyerId">
<table border="2" style="width= 400px; margin-left: auto; margin-right: auto;">
    <tr style="height: 50px; text-align: center;">
        <td colspan="2" bgcolor="lightgray">
            <h2>채무자 추가</h2>
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이름
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="debtor_name" style="font-size:medium; height: 25px; width: 250px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            전화번호
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="hp1" style="font-size:medium; height: 25px; width: 40px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp2" style="font-size:medium; height: 25px; width: 60px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp3" style="font-size:medium; height: 25px; width: 60px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이메일
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="debtor_id" style="font-size:medium; height: 25px; width: 250px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            채권자
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;
            <!-- <input type="text" value="" name="debtor_id" style="font-size:medium; height: 25px; width: 250px;"> -->
            <select name="creditorList">            
                <c:forEach var="creditorName" items="${creditorList}" varStatus="status">                    
                    <option value="${creditorName.id }">${creditorName.creditor_name }</option>
                </c:forEach>
            </select> 
        </td>
    </tr>
</table>
<br>
<div style="text-align: center;">
    <input type="submit" value="추가" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
    <input type="button" value="뒤로가기" onclick="history.back()" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
</div>
</form>
</body>
</html>