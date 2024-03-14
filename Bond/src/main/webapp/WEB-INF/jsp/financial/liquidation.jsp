<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>변제</title>
</head>
<body>
<!-- 
    input에서 숫자 입력 3개씩 마다 쉼표를 찍으려는 함수
    <script>
    function inputAutoComma(el) {
        el.addEventListener("input", function(e) {
            var val = e.target.value.replace(/[^0-9]/g, "");
            e.target.value = val.replace(/\d(?=(?:\d{3})+$)/g, '$&,');
        });
    }
    inputAutoComma(document.getElementById("testInput"));
    </script>
    
    함수 생성이 싫다면 input에 oninput 속성 추가
    <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />
    
 -->
<%
String debtor_id = request.getParameter("debtor_id");
String lawyer_id = request.getParameter("lawyer_id");
String creditor_id = request.getParameter("creditor_id");
String date = request.getParameter("date");
String value = request.getParameter("value");
%>
<!-- financial에서 필요한 입력변수들을 form형태로 만들고, 밑에서 form id를 활용하여 submit한다. -->
<form id="financialForm" action="financial" method="post">
    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
    <input type="hidden" name="debtor_name" value="${debtorName }">
</form>
 <script type="text/javascript">
 if(${debtList_size} == 0)  {
	 alert("변제할 값이 존재하지 않습니다.");
	 location.href="javascript:history.back();";
 }
 else   {
	 if(${success} == 0)   {
		 alert("변제 오류 발생");
		 location.href="javascript:history.back();";
	 }
	 else  {
		 alert("변제하였습니다.");
		 document.getElementById("financialForm").submit();
	 }
 }
 </script>


</body>
</html>