<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<script type="text/javascript">
function nullCheck()    {
	var id = document.login.uID.value;
	var pw = document.login.uPW.value;
	if(id === "")  {
		alert("아이디를 입력하세요.");
		document.login.uID.focus();
		return false;
	}
	if(pw === "")  {
		alert("비밀번호를 입력하세요.");
		document.login.uPW.focus();
		return false;
	}
	return true;
}
</script>

<fieldset>
        <form name="login" action="login" method="post" onsubmit="return nullCheck()">
            <br>
            <table border="2" style="width: 800px; height: 130px; margin-left: auto; margin-right: auto;">                
                <tr style="height: 50px; text-align: center;">
                    <td colspan = "2" bgcolor = "lightgray" class = "style1">
                    <h2>Bond 로그인</h2>
                    </td>                   
                </tr>
                
                <tr style="height: 40px;">
                    <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                        아이디
                    </td>
                    <td  width = "500">
                        &nbsp;&nbsp;<input type="text" name="uID" style="width: 300px; height: 20px; font-size: large;" />
                    </td>
                </tr>
                <tr style="height: 40px;">
                    <td style="text-align: center;" width = "130" bgcolor = "lightgray" class = "style2">
                        비밀번호
                    </td>
                    <td  width = "500">
                        &nbsp;&nbsp;<input type="password" name="uPW" style="width: 300px; height: 20px; font-size: large;" />
                    </td>
                </tr>
            </table>
            <br>
            <div style="text-align: center;">
	            <input type = "submit" style="WIDTH: 90pt; HEIGHT: 20pt; font-size: medium;" value="로그인">&nbsp;&nbsp;
                <input type = "button" style="WIDTH: 110pt; HEIGHT: 20pt; font-size: medium; " onclick = "location.href='insertLawyer'" value="회원가입"/>&nbsp;&nbsp;
	            <input type = "button" style="WIDTH: 110pt; HEIGHT: 20pt; font-size: medium; " onclick = "location.href='find_id'" value="아이디 찾기"/>&nbsp;&nbsp;
	            <input type = "button" style="WIDTH: 110pt; HEIGHT: 20pt; font-size: medium; " onclick = "location.href='find_pw'" value="비밀번호 찾기"/>&nbsp;&nbsp;       
            </div>
            <br>
        </form>
</fieldset>
</body>
</html>