<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디 찾기</title>
</head>
<body>
<script>
function inputNullCheck()   {
    var name = document.forms["pi"]["uName"].value;
    var hp1 = document.forms["pi"]["hp1"].value;
    var hp2 = document.forms["pi"]["hp2"].value;
    var hp3 = document.forms["pi"]["hp3"].value;
    
    if(name === "") {
        alert("이름을 입력하세요.");
        document.pi.uName.focus();
        return false;
    }
    if(hp1 === "") {
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp1.focus();
        return false;
    }
    if(hp2 === "") {
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp2.focus();
        return false;
    }
    if(hp3 === "") {
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp3.focus();
        return false;
    }
    return true;
}
</script>
<fieldset>
    <form name="pi" method="post" action="checkId" onsubmit="return inputNullCheck()">
    <table border="2" style="margin-left: auto; margin-right: auto;">
        <tr style="height: 50px; text-align: center;">
            <td colspan = "2" bgcolor = "lightgray" class = "style1">
                <h2>ID 찾기</h2>
            </td>                   
        </tr>
        
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                이름
            </td>
            <td  width = "500">
                &nbsp;&nbsp;<input type="text" id="uName" name="uName" style="width: 300px; height: 20px; font-size: large;">
            </td>
        </tr>
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                전화번호
            </td>
            <td  width = "500">
                &nbsp;
                <input type="text" name="hp1" style="width: 50px; heigth: 20px; font-size: large;">
                &nbsp;-&nbsp;
                <input type="text" name="hp2" style="width: 70px; heigth: 20px; font-size: large;">
                &nbsp;-&nbsp;
                <input type="text" name="hp3" style="width: 70px; heigth: 20px; font-size: large;">                
            </td>
        </tr>
    </table>
    <br>
    <div style="text-align: center;">
        <input type="submit" style="WIDTH: 100pt; HEIGHT: 20pt; font-size: medium;" value="아이디 찾기">&nbsp;&nbsp;
        <input type="button" style="width: 100pt; height: 20pt; font-size: medium;" value="취소" onclick="location.href='login_page'">
    </div>
    <br>
    </form>
</fieldset>
</body>
</html>