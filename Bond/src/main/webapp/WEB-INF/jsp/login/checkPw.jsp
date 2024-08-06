<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String id = request.getParameter("uID");
String name = request.getParameter("uNAME");
String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");
String hp = hp1 + "-" + hp2 + "-" + hp3;
%>
<script type="text/javascript">
function pwCheck()  {
	var check1 = document.pi.pw.value;
	var check2 = document.pi.pwCheck.value;
	
	if(check1 === "")  {
		alert("비밀번호를 입력하세요.");
		document.pi.pw.focus();
		return false;
	}
	if(check2 === "")  {
		alert("비밀번호 확인을 입력하세요.");
		document.pi.pwCheck.focus();
		return false;
	}
	if(!(check1 === check2)) {
		alert("비밀번호가 일치하지 않습니다.");
		document.pi.pw.focus();
		return false;
	}
}
</script>

<fieldset>
    <form name="pi" method="post" action="updateLawyer_Pw" onsubmit="return inputNullCheck()">
    <input type="hidden" name="id" value="<%=id %>">
    <input type="hidden" name="name" value="<%=name %>">
    <input type="hidden" name="hp" value="<%=hp %>">
   
    <table border="2" style="margin-left: auto; margin-right: auto;">
        <tr style="height: 50px; text-align: center;">
            <td colspan = "2" bgcolor = "lightgray" class = "style1">
                <h2>비밀번호 수정</h2>
            </td>                   
        </tr>
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                비밀번호
            </td>
            <td  width = "500">
                &nbsp;&nbsp;<input type="password" name="pw" style="width: 300px; height: 20px; font-size: large;" />
            </td>
        </tr>
        
        <tr style="height: 40px;">
            <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                비밀번호 확인
            </td>
            <td  width = "500">
                &nbsp;&nbsp;<input type="password" name="pwCheck" style="width: 300px; height: 20px; font-size: large;" />
            </td>
        </tr>
    </table>
    <br>
    <div style="text-align: center;">
        <input type="submit" style="WIDTH: 100pt; HEIGHT: 20pt; font-size: medium;" value="비밀번호 수정">&nbsp;&nbsp;
        <input type="button" style="width: 100pt; height: 20pt; font-size: medium;" value="취소" onclick="history.back()">
    </div>
    <br>
    </form>
</fieldset>
</body>
</html>