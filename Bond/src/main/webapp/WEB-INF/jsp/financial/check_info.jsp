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
/* '�뿩'�� �����ߴٸ�, �����ݾ��� 0���� ó�� */
if(info.equals("rental"))    {
%>  
	<br><br>
	<table border="3" style="text-align:center; border-color:black; width: 500px; margin-left: auto; margin-right: auto;">
	    <tr style="height: 80px; font-size: xx-large;">    
	        <td colspan="2">
	            [ �뿩 ]
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            ��¥
	        </td>
	        <td style="width: 350px;">
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            �����ݾ�
	        </td>
	        <td style="width: 350px;">
	            <%=value %>��
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            ����
	        </td>
	        <td style="width: 350px;">
	            <%=interest %>%
	        </td>
	    </tr>
	</table><br>
	<div style="text-align: center;">
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="����">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" onclick="history.back()" value="���">
    </div>
<%} 
/* '����'�� �����ߴٸ�, �뿩���� 0���� ó��*/
else if(info.equals("liquidation"))  {%>
	<br><br>
	<form action="rental" method="post">
    <table border="3" style="text-align:center; border-color:black; width: 500px; margin-left: auto; margin-right: auto;">
	    <tr style="height: 80px; font-size: xx-large;">    
	        <td colspan="2">
	            [ ���� ]
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            ��¥
	        </td>
	        <td style="width: 350px;">
	           <input type="hidden" value="<%=date %>" name="date">
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            �����ݾ�
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" name="liquidation_value" value="<%=value %>"> 
	            <%=value %>��
	        </td>
	    </tr>
	</table><br>
	</form>
	<div style="text-align: center;">
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="����">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="���" onclick="history.back()">
    </div>
<%} %>


</body>
</html>