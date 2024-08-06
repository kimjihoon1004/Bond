<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${anme } 정보 수정</title>
</head>
<body>
<%-- 'hp' 값을 EL로 가져오기 --%>
<c:set var="phone" value="${hp}" />

<%
String phone = (String) pageContext.getAttribute("phone");
String[] phone_num = phone.split("-");
String phone1 = phone_num[0];
String phone2 = phone_num[1];
String phone3 = phone_num[2];
%>

<script>
function inputNullCheck()   {
    var name = document.forms["pi"]["uNAME"].value;
    var id = document.forms["pi"]["uID"].value;
    var hp1 = document.forms["pi"]["hp1"].value;
    var hp2 = document.forms["pi"]["hp2"].value;
    var hp3 = document.forms["pi"]["hp3"].value;
    
    if(name === "") {
        alert("이름을 입력하세요.");
        document.pi.uNAME.focus();
        return false;
    }
    if(id === "")   {
        alert("아이디를 입력하세요.");
        document.pi.uID.focus();
        return false;
    }
    if(hp1 === "") {
        console.log('hp1 비어있다');
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp1.focus();
        return false;
    }
    if(hp2 === "") {
        console.log('hp2 비어있다');
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp2.focus();
        return false;
    }
    if(hp3 === "") {
        console.log('hp3 비어있다');
        alert("핸드폰 번호를 입력하세요.");
        document.pi.hp3.focus();
        return false;
    }
    return true;
}
</script>
<fieldset>
    <form name="pi" method="post" action="lawyerUpdating" onsubmit="return inputNullCheck()">
    <input type="hidden" name="pk" value="${pk }">
    <table border="2" style="margin-left: auto; margin-right: auto;">
        <tr style="height: 50px; text-align: center;">
            <td colspan = "2" bgcolor = "lightgray" class = "style1">
                <h2>${name } 정보 수정</h2>
            </td>                   
        </tr>
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                이름
            </td>
            <td  width = "500">
                &nbsp;&nbsp;<input type="text" name="uNAME" value="${name }" style="width: 300px; height: 20px; font-size: large;" />
            </td>
        </tr>
        
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                전화번호
            </td>
            <td  width = "500">
                &nbsp;
                <input type="text" name="hp1" value="<%=phone1 %>" style="width: 50px; heigth: 20px; font-size: large;">
                &nbsp;-&nbsp;
                <input type="text" name="hp2" value="<%=phone2 %>" style="width: 70px; heigth: 20px; font-size: large;">
                &nbsp;-&nbsp;
                <input type="text" name="hp3" value="<%=phone3 %>" style="width: 70px; heigth: 20px; font-size: large;">                
            </td>
        </tr>
        
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                아이디
            </td>
            <td  width = "500">
                &nbsp;&nbsp;<input type="text" name="uID" value="${id }" style="width: 300px; height: 20px; font-size: large;" />
            </td>
        </tr>
        
    </table>
    <br>
    <div style="text-align: center;">
        <input type="submit" style="WIDTH: 100pt; HEIGHT: 20pt; font-size: medium;" value="정보수정">&nbsp;&nbsp;
        <input type="button" style="width: 100pt; height: 20pt; font-size: medium;" value="취소" onclick="history.back()">
    </div>
    <br>
    </form>
</fieldset>
</body>
</html>