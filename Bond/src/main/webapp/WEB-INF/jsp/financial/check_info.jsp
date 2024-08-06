
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
<%
/* '대여'를 선택했다면, 변제금액은 0으로 처리 */
if(info.equals("rental"))    {
%>  
	<br><br>
	<form action="rental" method="post">
	<input type="hidden" name="debtor_id" value="<%=debtorId%>">
	<input type="hidden" name="creditor_id" value="<%=creditorId %>">
	<input type="hidden" name="lawyer_id" value="<%=lawyerId %>">
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
	            <input type="hidden" value="<%=date %>" name="date" >
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            대여금액
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" value="<%=value %>" name="rental">
	            <%=value %>원
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            이율
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" value="<%=interest %>" name="interest">
	            <%=interest %>%
	        </td>
	    </tr>
	</table><br>
	<div style="text-align: center;">
		<input type="submit" style="width: 150px; height: 40px; font-size: large;" value="대여">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" onclick="history.back()" value="취소">
    </div>
    </form>
<%} 
/* '변제'를 선택했다면, 대여금은 0으로 처리*/
else if(info.equals("liquidation"))  {%>
	<br><br>
	<form action="liquidation" method="post">
	<input type="hidden" name="debtor_id" value="<%=debtorId %>">
	<input type="hidden" name="creditor_id" value="<%=creditorId %>">
    <input type="hidden" name="lawyer_id" value="<%=lawyerId %>">
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
	            <input type="hidden" name="value" value="<%=value %>"> 
	            <%=value %>원
	        </td>
	    </tr>
	</table><br>
	
	<div style="text-align: center;">
		<input type="submit" style="width: 150px; height: 40px; font-size: large;" value="변제">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="취소" onclick="history.back()">
    </div>
    </form>
<%} %>


</body>
</html>