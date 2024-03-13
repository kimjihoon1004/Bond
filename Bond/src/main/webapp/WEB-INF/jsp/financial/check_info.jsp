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
String debtorId = request.getParameter("debtorId");
String creditorId = request.getParameter("creditorId");
String uID = (String) session.getAttribute("uID");
int lawyerId = (int) session.getAttribute("lawyerId"); 
%>
<h1>debtorId : <%=debtorId %></h1>
<h1>creditorId : <%=creditorId %></h1>
<%
/* '대여'를 선택했다면, 변제금액은 0으로 처리 */
if(info.equals("rental"))    {
%>  
	<br><br>
	<table border="3" style="text-align:center; border-color:black; width: 500px; margin-left: auto; margin-right: auto;">
	    <tr style="height: 80px; font-size: xx-large;">    
	        <td colspan="2">
	            [ 대여 ]
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
	</table><br>
	<div style="text-align: center;">
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="변제">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" onclick="history.back()" value="취소">
    </div>
<%} 
/* '변제'를 선택했다면, 대여금은 0으로 처리*/
else if(info.equals("liquidation"))  {%>
	<br><br>
	<form action="rental" method="post">
    <table border="3" style="text-align:center; border-color:black; width: 500px; margin-left: auto; margin-right: auto;">
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
	           <input type="hidden" value="<%=date %>" name="date">
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            변제금액
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" name="liquidation_value" value="<%=value %>"> 
	            <%=value %>원
	        </td>
	    </tr>
	</table><br>
	</form>
	<div style="text-align: center;">
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="변제">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="취소" onclick="history.back()">
    </div>
<%} %>


</body>
</html>