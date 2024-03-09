<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>대여</title>
</head>
<body>
<%
String debtor_id = request.getParameter("debtor_id");
%>
<table border="3" style="text-align:center; border-color:black; width: 500px; height: 500px;">
    <tr style="height: 80px; font-size: xx-large;">    
        <td colspan="2">
            [ 대여 ]
        </td>
    </tr>
    <tr style="height: 50px; font-size: large;">
        <td style="width: 150px;">
            날짜
        </td>
        <td style="width: 350px;">
            <input type="date" name="rental_date" style="width: 300px; height: 35px; font-size: large;">
        </td>
    </tr>
    <tr style="height: 50px; font-size: large;">
        <td style="width: 150px;">
            변제금액
        </td>
        <td style="width: 350px;">
            <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" placeholder="금액 입력" name="rental_value" style="width: 300px; height: 35px; font-size: large;">
        </td>
    </tr>
    <tr>
        <td>
        1
        </td>
        <td>
        2
        </td>
    </tr>
</table>
</body>
</html>