<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>채권자 추가</title>
</head>
<body>
<script type="text/javascript">
function nullCheck()    {
    var name = document.creditorTable.creditor_name.value;
    var hp1 = document.creditorTable.hp1.value;
    var hp2 = document.creditorTable.hp2.value;
    var hp3 = document.creditorTable.hp3.value;
    var email = document.creditorTable.creditor_id.value;
    
    if(name === "")    {
        alert("이름을 입력하세요.");
        document.creditorTable.creditor_name.focus();
        return false;
    }
    if(hp1 === "")    {
        alert("전화번호를 입력하세요.");
        document.creditorTable.hp1.focus();
        return false;
    }
    if(hp2 === "")    {
        alert("전화번호를 입력하세요.");
        document.creditorTable.hp2.focus();
        return false;
    }
    if(hp3 === "")    {
        alert("전화번호를 입력하세요.");
        document.creditorTable.hp3.focus();
        return false;
    }
    if(email === "")    {
        alert("이메일를 입력하세요.");
        document.creditorTable.creditor_id.focus();
        return false;
    }
    return true;
}
</script>


<form name="creditorTable" action="insertCreditorActivate" method="post" onsubmit="return nullCheck()">
<table border="2" style="width= 400px; margin-left: auto; margin-right: auto;">
    <tr style="height: 50px; text-align: center;">
        <td colspan="2" bgcolor="lightgray">
            <h2>채권자 추가</h2>
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이름
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="creditor_name" style="font-size:medium; height: 25px; width: 250px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            전화번호
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="hp1" style="font-size:medium; height: 25px; width: 40px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp2" style="font-size:medium; height: 25px; width: 60px;">
            &nbsp;-&nbsp;
            <input type="text" name="hp3" style="font-size:medium; height: 25px; width: 60px;">
        </td>
    </tr>
    <tr style="height: 40px;">
        <td style="text-align: center; width: 100px; bgcolor: lightgray">
            이메일
        </td>
        <td style="width: 300px;">
            &nbsp;&nbsp;<input type="text" name="creditor_id" style="font-size:medium; height: 25px; width: 250px;">
        </td>
    </tr>
</table>
<br>
<div style="text-align: center;">
    <input type="submit" value="추가" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
    <input type="button" value="뒤로가기" onclick="history.back()" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
</div>
</form>
</body>
</html>