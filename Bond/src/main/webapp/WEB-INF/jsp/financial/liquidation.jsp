<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����</title>
</head>
<body>
<!-- 
    input���� ���� �Է� 3���� ���� ��ǥ�� �������� �Լ�
    <script>
    function inputAutoComma(el) {
        el.addEventListener("input", function(e) {
            var val = e.target.value.replace(/[^0-9]/g, "");
            e.target.value = val.replace(/\d(?=(?:\d{3})+$)/g, '$&,');
        });
    }
    inputAutoComma(document.getElementById("testInput"));
    </script>
    
    �Լ� ������ �ȴٸ� input�� oninput �Ӽ� �߰�
    <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />
    
 -->
<%
String debtor_id = request.getParameter("debtor_id");
String lawyer_id = request.getParameter("lawyer_id");
String creditor_id = request.getParameter("creditor_id");
String date = request.getParameter("date");
String value = request.getParameter("value");
%>
<!-- financial���� �ʿ��� �Էº������� form���·� �����, �ؿ��� form id�� Ȱ���Ͽ� submit�Ѵ�. -->
<form id="financialForm" action="financial" method="post">
    <input type="hidden" name="lawyer_id" value="<%=lawyer_id%>">
    <input type="hidden" name="debtor_id" value="<%=debtor_id %>">
    <input type="hidden" name="creditor_id" value="<%=creditor_id %>">
    <input type="hidden" name="debtor_name" value="${debtorName }">
</form>
 <script type="text/javascript">
 if(${debtList_size} == 0)  {
	 alert("������ ���� �������� �ʽ��ϴ�.");
	 location.href="javascript:history.back();";
 }
 else   {
	 if(${success} == 0)   {
		 alert("���� ���� �߻�");
		 location.href="javascript:history.back();";
	 }
	 else  {
		 alert("�����Ͽ����ϴ�.");
		 document.getElementById("financialForm").submit();
	 }
 }
 </script>


</body>
</html>