<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
</head>
<body>

<fieldset>
    <center>
        <form name="login" action="login" method="post">
            <br>
            <table border="2" style="width: 800px; height: 130px;" cellspacing = "0" cellpadding = "2">
                
                <tr style="height: 50px;">
                    <td colspan = "2" bgcolor = "lightgray" class = "style1"><h2><center>Bond �α���</center></h2></td>                   
                </tr>
                
                <tr style="height: 40px;">
                    <td width = "130" bgcolor = "lightgray" class = "style2"><center>���̵�</center></td>
                    <td  width = "500">
                        &nbsp;<input type="text" name="uID" style="width: 300px; height: 20px; font-size: large;" />
                    </td>
                </tr>
                <tr style="height: 40px;">
                    <td width = "130" bgcolor = "lightgray" class = "style2"><center>��й�ȣ</center></td>
                    <td  width = "500">
                        &nbsp;<input type="password" name="uPW" style="width: 300px; height: 20px; font-size: large;" />
                    </td>
                </tr>
            </table>
            <br>
            <center>
                <input type = "submit" style="WIDTH: 90pt; HEIGHT: 20pt; font-size: medium;" value="�α���">&nbsp;&nbsp;
                <input type = "button" style="WIDTH: 150pt; HEIGHT: 20pt; font-size: medium; " onclick = "location.href='find_user'" value="���̵�/��й�ȣ ã��"/>&nbsp;&nbsp;
            </center>
            <br>
        </form>
    </center>
</fieldset>
</body>
</html>