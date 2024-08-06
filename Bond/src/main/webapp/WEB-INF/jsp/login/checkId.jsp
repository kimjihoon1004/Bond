<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl 사용시 만든다. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<!-- jstl을 활용하여 조건문을 만든다. -->
<c:choose>
    <c:when test="${not empty id}">
        <!-- id 값이 존재하는 경우 이 부분이 실행됩니다. -->
        <!-- @Controller에서 ModelAndView에서 addObject로 넘긴값을 <script>태그에서 받는 방법은 var변수를 만들고 addObject변수를 문자열로 대입한다. -->
        <script>
        var id = "${id}";
        alert("회원님의 아이디는 " + id + " 입니다.");
        location.href="/";
        </script>
    </c:when>
    <c:otherwise>
        <!-- id 값이 없는 경우 이 부분이 실행됩니다. -->
        <script>
        alert("회원님의 회원정보가 존재하지 않습니다.");
        history.back();
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>