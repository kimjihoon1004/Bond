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
/* '�뿩'�� �����ߴٸ�, �����ݾ��� 0���� ó�� */
if(info.equals("rental"))    {
%>  
<br><br>
<center>
	<table border="3" style="text-align:center; border-color:black; width: 500px; height: 500px;">
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
	    <tr>
	        <td>
	        1
	        </td>
	        <td>
	        2
	        </td>
	    </tr>
	</table><br>
	<input type="button" style="width: 150px; height: 40px; font-size: large;" value="����">&nbsp;&nbsp;
	<input type="button" style="width: 150px; height: 40px; font-size: large;" value="���">
</center>
<%} 
/* '����'�� �����ߴٸ�, �뿩���� 0���� ó��*/
else if(info.equals("liquidation"))  {%>
	<h1>this is liquidation</h1>
<%} %>


</body>
</html>