<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>채권자 추가</title>
</head>
<body>
<c:choose>
    <c:when test="${success eq 1 }">
        <script type="text/javascript">
        alert("채권자 추가 완료");
        location.href="selectDebtor";
        </script>        
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
        alert("채권자 추가 불가");
        location.href="selectDebtor";
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>