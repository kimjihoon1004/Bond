<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ä���� �߰�</title>
</head>
<body>
<h1>ä���� �߰�</h1>

<c:choose>
    <c:when test="${success eq 1 }">
        <script type="text/javascript">
        alert("ä���� �߰� �Ϸ�");
        location.href="selectDebtor";
        </script>        
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
        alert("ä���� �߰� �Ұ�");
        location.href="selectDebtor";
        </script>
    </c:otherwise>
</c:choose>


</body>
</html>