
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
/* '�뿩'�� �����ߴٸ�, �����ݾ��� 0���� ó�� */
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
	            [ �뿩 ]
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            ��¥
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" value="<%=date %>" name="date" >
	            <%=date %>
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            �뿩�ݾ�
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" value="<%=value %>" name="rental">
	            <%=value %>��
	        </td>
	    </tr>
	    <tr style="height: 50px; font-size: x-large;">
	        <td style="width: 150px;">
	            ����
	        </td>
	        <td style="width: 350px;">
	            <input type="hidden" value="<%=interest %>" name="interest">
	            <%=interest %>%
	        </td>
	    </tr>
	</table><br>
	<div style="text-align: center;">
		<input type="submit" style="width: 150px; height: 40px; font-size: large;" value="�뿩">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" onclick="history.back()" value="���">
    </div>
    </form>
<%} 
/* '����'�� �����ߴٸ�, �뿩���� 0���� ó��*/
else if(info.equals("liquidation"))  {%>
	<br><br>
	<form action="liquidation" method="post">
	<input type="hidden" name="debtor_id" value="<%=debtorId %>">
	<input type="hidden" name="creditor_id" value="<%=creditorId %>">
    <input type="hidden" name="lawyer_id" value="<%=lawyerId %>">
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
	            <input type="hidden" name="value" value="<%=value %>"> 
	            <%=value %>��
	        </td>
	    </tr>
	</table><br>
	
	<div style="text-align: center;">
		<input type="submit" style="width: 150px; height: 40px; font-size: large;" value="����">&nbsp;&nbsp;
		<input type="button" style="width: 150px; height: 40px; font-size: large;" value="���" onclick="history.back()">
    </div>
    </form>
<%} %>


</body>
</html>