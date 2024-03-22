<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>채무자 추가</title>
</head>
<body>
<h1>채무자 추가</h1>

<c:choose>
    <c:when test="${success eq 1 }">
        <script type="text/javascript">
        alert("채무자 추가 완료");
        location.href="selectDebtor";
        </script>        
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
        alert("채무자 추가 불가");
        location.href="selectDebtor";
        </script>
    </c:otherwise>
</c:choose>


</body>
</html>