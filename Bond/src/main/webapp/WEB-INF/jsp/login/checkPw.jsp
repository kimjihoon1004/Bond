<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String id = request.getParameter("uID");
String name = request.getParameter("uNAME");
String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");
String hp = hp1 + "-" + hp2 + "-" + hp3;
%>

<h1><%=id %></h1>
<h1><%=name %></h1>
<h1><%=hp %></h1>
<input type="hidden" value="<%=id %>" name="id">
<input type="hidden" value="<%=name %>" name="pw">
<input type="hidden" value="<%=hp %>" name="pw">

</body>
</html>