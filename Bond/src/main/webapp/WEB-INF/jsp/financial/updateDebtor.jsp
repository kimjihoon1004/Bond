<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.eugeneprogram.service.*"%>
<%@page import="com.eugeneprogram.dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>채무자 수정</title>
</head>
<body>
<%
String debtorId = request.getParameter("id");
%>
<form action="updateDebtorActivate" method="post">
<input type="hidden" value="<%=debtorId %>" name="debtor_id">
<table border="2" style="width= 400px; margin-left: auto; margin-right: auto;">
    <tr style="height: 50px; text-align: center;">
        <td colspan="2" bgcolor="lightgray">
            <h2>${debtor_name } 수정</h2>
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이름
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" value="${debtor_name } " name="debtor_name" style="font-size:medium; height: 25px; width: 250px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            전화번호
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" value="${hp1 }" name="hp1" style="font-size:medium; height: 25px; width: 40px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp2" value="${hp2 }" style="font-size:medium; height: 25px; width: 60px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp3" value="${hp3 }" style="font-size:medium; height: 25px; width: 60px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이메일
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" value="${debtor_id }" name="debtor_email" style="font-size:medium; height: 25px; width: 250px;">
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
                    <c:choose>
                        <c:when test="${creditor_id eq creditorName.id}">
                            <option value="${creditorName.id }" selected="selected">${creditorName.creditor_name }</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${creditorName.id }">${creditorName.creditor_name }</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select> 
        </td>
    </tr>
</table>
<br>
<div style="text-align: center;">
    <input type="submit" value="수정" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
    <input type="button" value="뒤로가기" onclick="history.back()" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
</div>
</form>
</body>
</html>