<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>채무자 수정</h1>

<c:choose>
    <c:when test="${success eq 1 }">
        <script type="text/javascript">
        alert("수정 완료");
        </script>        
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
        alert("수정 불가");
        </script>
    </c:otherwise>
</c:choose>

</body>
</html>