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
System.out.println("wow!");
String iidCheck = (String) session.getAttribute("uID");
if(iidCheck == null || "".equals(iidCheck) || iidCheck == "") {
%>
    <script>
    alert("�α��� �� ����ϼ���.");
    location.href="login_page"; // �α��� ������ ��ο� ���� ����
    </script>
<%
}
%>
</body>
</html>