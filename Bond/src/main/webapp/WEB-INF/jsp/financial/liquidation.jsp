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

%>
<table border="3" style="text-align:center; border-color:black; width: 500px;">
    <tr style="height: 80px; font-size: xx-large;">    
        <td colspan="2">
            [ 변제 ]
        </td>
    </tr>
    <tr style="height: 60px; font-size: large;">
        <td style="width: 150px;">
            날짜
        </td>
        <td style="width: 350px;">
            <input type="date" name="liqudiation_date" style="width: 300px; height: 35px; font-size: large;">
        </td>
    </tr>
    <tr style="height: 60px; font-size: large;">
        <td style="width: 150px;">
            변제금액
        </td>
        <td style="width: 350px;">
            <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" placeholder="금액 입력" name="liqudiation_value" style="width: 300px; height: 35px; font-size: large;">
        </td>
    </tr>
</table>
</body>
</html>