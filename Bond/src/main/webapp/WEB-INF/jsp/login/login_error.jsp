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
    alert("로그인 후 사용하세요.");
    location.href="login_page"; // 로그인 페이지 경로에 따라 수정
    </script>
<%
}
%>
</body>
</html>