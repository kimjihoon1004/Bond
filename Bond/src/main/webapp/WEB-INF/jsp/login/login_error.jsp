<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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