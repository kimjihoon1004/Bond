<%@page import="com.eugeneprogram.dao.BondMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.eugeneprogram.service.*"%>
<%@ include file="../login/login_error.jsp" %>

<!-- lawyer 로그인 id, lawyer가 채무자를 선택하면 해당 채무자의 id, 채무자의 id에 연결된 채권자의 id까지 3가지 id 가져올 것 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>충당표</title>
</head>

<body>
<script type="text/javascript">
function inputNullCheck()   {
    var x = document.forms["pay"]["date"].value;
    var y = document.forms["pay"]["value"].value;
    
    if(x === "") {
    	alert("날짜를 입력하세요.");
    	document.pay.date.focus();
    	return false;
    }
    if(y === "") {
    	alert("금액을 입력하세요.");
    	document.pay.value.focus();
    	return false;
    }
    return true;
}
function validateForm() {
    var radios = document.getElementsByName("chk_info");
    var formValid = false;

    var i = 0;
    while (!formValid && i < radios.length) {
        if (radios[i].checked) {
        	formValid = true;
        }
        i++;        
    }

    if (!formValid) {
    	alert("변제 or 대여를 선택하세요.");
    	return false;
    }
}

function submitForm()   {
	return inputNullCheck() && validateForm();
}
</script>
<%
String uID = (String) session.getAttribute("uID");
String uPW = (String) session.getAttribute("uPW");
int lawyerId = (Integer) session.getAttribute("lawyerId");
System.out.println(uID + " " + uPW + " " + lawyerId);
String debtorName = request.getParameter("debtor_name");
System.out.println("===============================" + debtorName + "===============================");
%>
<!-- white-space: nowrap; 문자 내용이 모니터화면만큼에서 줄을 내리지 않고 끝까지 출력하는 속성 -->
<h2>[ ${debtor_name }님의 변제충당표 ]</h2>
<form name="pay" action="check_info" method="post" onsubmit="return submitForm()">
<input type="hidden" name="creditorId" value="${creditor_id }">
<input type="hidden" name="debtorId" value="${debtor_id }">
<table border="1" style="broder-color: black; width: 830px; height: 50px;">
    <tr>
        <td>
	        &nbsp;
	        <input type="radio" name="chk_info" value="liquidation">변제
	        <input type="radio" name="chk_info" value="rental">대여&nbsp;&nbsp;&nbsp;
	        이율&nbsp;:&nbsp; 
	        <select name="interest">
	            <option value="12" selected="selected">12%</option>
	            <option value="18">18%</option>
                <option value="30">30%</option>
	        </select>
	        &nbsp;&nbsp;
	        날짜&nbsp;:&nbsp;
	        <input type="date" name="date" style="width: 100px; heigth:50px;">&nbsp;&nbsp;
	        금액&nbsp;:&nbsp;
	        <input type="text" id="value" name="value" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" style="width: 200px; heigth:50px;">원&nbsp;&nbsp;
	        <input type="submit" style="width: 60px; height:30px;" value="납부">
	    </td>
    </tr>
</table>
</form>
<br>
<!--  
<input type="button" onclick="location.href = 'liquidationButton?debtor_id=${debtor_id}'" style="width: 100px; height: 30px;" value="변제">
<input type="button" onclick="location.href = 'rentalButton?debtor_id=${debtor_id}'" style="width: 100px; height: 30px;" value="대여">
-->
<table border="1" style="border-color:white; width: 2380px; text-align: center; border-collapse: collapse; ">
    <tr style="height: 30px;">
        <td colspan="4" style="border-color: black; border-top: none; border-left: none;">        
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            해당일까지 발생한 변제 충당 전의 원금
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            해당일까지 발생한 변제 충당 전의 이자
        </td>
        <td style="border-color: black; border-top:none;">        
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            변제충당 후 이자
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            변제충당 후 원금
        </td>
        <td style="border-color:black; border-right: none; border-top: none;">
        
        </td>
    </tr>
    <tr style="height: 25px; border-color: black; background-color: yellow;">
        <td style="width: 40px;">
            순번
        </td>   
        <td style="width: 100px;">
            날짜
        </td>
        <td style="width: 110px;">
            대여금
        </td>
        <td style="width: 80px;">
            적용이율
        </td>
        <td style="width: 150px;">
            30%원금(누적)
        </td>
        <td style="width: 150px;">
            18%원금(누적)
        </td>
        <td style="width: 150px;">
            12%원금(누적)
        </td>
        <td style="width: 150px;">
            30%이자(합계액)
        </td>
        <td style="width: 150px;">
            18%이자(합계액)
        </td>
        <td style="width: 150px;">
            12%이자(합계액)
        </td>
        <td style="width: 150px; color: blue;">
            변제금액
        </td>
        <td style="width: 150px;">
            30%이자(충당후)
        </td>
        <td style="width: 150px;">
            18%이자(충당후)
        </td>
        <td style="width: 150px;">
            12%이자(충당후)
        </td>
        <td style="width: 150px;">
            30%원금(충당후)
        </td>
        <td style="width: 150px; color: red;">
            18%원금(충당후)
        </td>
        <td style="width: 150px; color: red;">
            12%원금(충당후)
        </td>
        <td style="width: 100px; font-size:small;">
            피고채권<br>
            (부당이득권)
        </td>
    </tr>
    <c:forEach var="tempDebtList" items="${debtList}" varStatus="status">
        <c:set var="i" value="${i+1 }" />
        <tr style="height: 25px; border-color: black;">
            <td>
	            ${i} 
	        </td>
	        <td>
	            ${tempDebtList.debt_date }
	        </td>
	        <td>
	            ${tempDebtList.debt_rental }
	        </td>
	        <td>            
                ${tempDebtList.debt_interest }
	        </td>
	        <td>
                ${tempDebtList.debt_30rental }	        
	        </td>
	        <td>
	           ${tempDebtList.debt_18rental }
	        </td>
	        <td>
	           ${tempDebtList.debt_12rental }
	        </td>
	        <td>
	            ${tempDebtList.debt_30interest }
	        </td>
	        <td>
	            ${tempDebtList.debt_18interest }
	        </td>
	        <td>
	            ${tempDebtList.debt_12interest }
	        </td>
	        <td style="color: blue;">
	            ${tempDebtList.debt_liquidation }
	        </td>
	        <td>
	            ${tempDebtList.debt_after30interest }
	        </td>
	        <td>
	            ${tempDebtList.debt_after18interest }
	        </td>
	        <td>
	            ${tempDebtList.debt_after12interest }
	        </td>
	        <td>
	            ${tempDebtList.debt_after30rental }
	        </td>
	        <td style="color: red;">
	            ${tempDebtList.debt_after18rental }
	        </td>
	        <td style="color: red;">
	            ${tempDebtList.debt_after12rental }
	        </td>
	        <td>
	            ${tempDebtList.debt_defendant}
	        </td>
        </tr>    
    </c:forEach>
        
</table>
</body>
</html>