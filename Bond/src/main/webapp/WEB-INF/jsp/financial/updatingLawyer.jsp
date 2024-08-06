<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
</head>
<body>
<c:choose>
    <c:when test="${result > 0 }">
        <script type="text/javascript">
        alert("정보 수정 완료");
        location.href="selectDebtor";
        </script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
        alert("정보 수정 실패");
        history.back();
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>