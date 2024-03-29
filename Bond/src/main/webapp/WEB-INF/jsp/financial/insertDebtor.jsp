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
<%
int lawyer_id = (int) session.getAttribute("lawyerId");
%>
<form action="insertDebtorActivate" method="post">
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