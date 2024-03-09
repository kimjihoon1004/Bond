<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String info = request.getParameter("chk_info");
String value = request.getParameter("value");
String date = request.getParameter("date");
String interest = request.getParameter("interest");
%>

<%
/* '대여'를 선택했다면, 변제금액은 0으로 처리 */
if(info.equals("rental"))    {
%>  
<br><br>
<center>
	<table border="3" style="text-align:center; border-color:black; width: 500px; height: 500px;">
	    <tr style="height: 80px; font-size: xx-large;">    
	        <td colspan="2">
	            [ 변제 ]
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            날짜
	        </td>
	        <td style="width: 350px;">
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            변제금액
	        </td>
	        <td style="width: 350px;">
	            <%=value %>원
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            이율
	        </td>
	        <td style="width: 350px;">
	            <%=interest %>%
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
	</table><br>
	<input type="button" style="width: 150px; height: 40px; font-size: large;" value="변제">&nbsp;&nbsp;
	<input type="button" style="width: 150px; height: 40px; font-size: large;" value="취소">
</center>
<%} 
/* '변제'를 선택했다면, 대여금은 0으로 처리*/
else if(info.equals("liquidation"))  {%>
	<h1>this is liquidation</h1>
<%} %>


</body>
</html>