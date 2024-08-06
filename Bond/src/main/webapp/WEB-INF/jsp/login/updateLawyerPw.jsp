<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
</head>
<body>
    <c:choose>
        <c:when test="${result > 0 }">
            <script>
            alert("비밀번호를 수정하였습니다.");
            location.href="/";
            </script>
        </c:when>
        <c:otherwise>
            <script type="text/javascript">
            alert("비밀번호 수정을 실패하였습니다.");
            history.back();
            </script>
        </c:otherwise>
    </c:choose>
</body>
</html>