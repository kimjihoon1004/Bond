<%@page import="com.eugeneprogram.dao.BondMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.eugeneprogram.service.*"%>
<%@ include file="../login/login_error.jsp" %>

<!-- lawyer 로그인 id, lawyer가 채무자를 선택하면 해당 채무자의 id, 채무자의 id에 연결된 채권자의 id까지 3가지 id 가져올 것 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충당표</title>
</head>

<body>
<script type="text/javascript">

function updateFinancial(debtId, debtorId, debtInterest, lawyerId, creditorId)  {
	document.frm.debt_id.value = debtId;
	document.frm.debtor_id.value = debtorId;
	document.frm.lawyer_id.value = lawyerId;
	document.frm.creditor_id.value = creditorId;
	if(debtInterest)  {		
		document.frm.debt_interest.value = debtInterest;
	}
	else   {
		document.frm.debt_interest.value = "aa";
	}
	document.frm.submit();
}

function entireExcelize()   {
	document.excelize.excelStatus.value = "1";
	
	var x = document.excelize.fileName.value;
	
	if(!check())   {
		return false;
	}
	if(x === "")   {
		alert("엑셀파일 이름을 입력하세요.");
        document.excelize.fileName.focus();
		return false;
	}
	else{
		document.excelize.submit();
	}
}

function excelizeCheck()    {
    if(!numInputNullCheck())   {
        return false;
    }
    if(!check())   {
        return false;
    }
    return true;
}


function check()    {
	var count = 0;
	var length = document.excelize.category.length;
	var i = 0;
	while(i < length)  {
		if(document.excelize.category[i].checked) {
			count++;
		}
		i++;
	}
	if(count == 0) {
		alert("카테고리를 한개이상 체크하세요.");
		return false;
	}
	return true;
}

function numInputNullCheck() {
	var x = document.forms["excelize"]["num1"].value;
	var y = document.forms["excelize"]["num2"].value;
	var z = document.excelize.fileName.value;
	
	if(z === "")   {
		alert("엑셀파일 이름을 입력하세요.");
		document.excelize.fileName.focus();
		return false;
	}
	

    if(Number(x) > Number(y))   {
        alert("시작순번과 끝순번의 순서가 올바르지 않습니다.");
        document.excelize.num1.focus();
        return false;
    }
    
    if(Number(x) > Number(${debtListSize})) {
    	alert("시작순번의 값이 순번을 초과하였습니다.");
    	document.excelize.num1.focus();
        return false;
    }
    
    if(Number(y) > Number(${debtListSize})) {
        alert("끝순번의 값이 순번을 초과하였습니다.");
        document.excelize.num2.focus();
        return false;
    }
	
	return true;
}



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

function moneySubmitForm()   {
	return inputNullCheck() && validateForm();
}
</script>
<%
String uID = (String) session.getAttribute("uID");
String uPW = (String) session.getAttribute("uPW");
int lawyerId = (Integer) session.getAttribute("lawyerId");
String debtorName = request.getParameter("debtor_name");
%>
<!-- white-space: nowrap; 문자 내용이 모니터화면만큼에서 줄을 내리지 않고 끝까지 출력하는 속성 -->
<h2>[ ${debtor_name }님의 변제충당표 ]&nbsp;&nbsp;&nbsp;<button onclick="history.back()">뒤로가기</button></h2>
<form name="pay" action="check_info" method="post" onsubmit="return moneySubmitForm()">
<input type="hidden" name="creditorId" value="${creditor_id }">
<input type="hidden" name="debtorId" value="${debtor_id }">
<fieldset style="broder-color: black; width: 830px; height: 50px;">
    <legend>대여 or 변제</legend>
    &nbsp;
    <input type="radio" name="chk_info" value="liquidation">변제
    <input type="radio" name="chk_info" value="rental">대여&nbsp;&nbsp;&nbsp;
    이율&nbsp;:&nbsp; 
    <select name="interest">
        <option value="5" selected="selected">5%</option>
        <option value="12">12%</option>
        <option value="18">18%</option>
           <option value="30">30%</option>
    </select>
    &nbsp;&nbsp;
    날짜&nbsp;:&nbsp;
    <input type="date" name="date" style="width: 100px; heigth:50px;">&nbsp;&nbsp;
    금액&nbsp;:&nbsp;
    <input type="text" id="value" name="value" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" style="width: 200px; heigth:50px;">원&nbsp;&nbsp;
    <input type="submit" style="width: 60px; height:30px;" value="납부">
</fieldset>
</form>
<script>
  // 문서가 로드되면 실행
  document.addEventListener('DOMContentLoaded', function() {
    // 폼 요소 선택
    var form = document.getElementsByName('pay')[0];
    
    // 폼 내에서의 키다운 이벤트 감지
    form.addEventListener('keydown', function(event) {
      // 엔터 키가 눌렸는지 확인 (엔터 키의 keyCode는 13입니다)
      if (event.keyCode === 13) {
        // 기본 동작 방지 (엔터 키로 인한 폼 제출 방지)
        event.preventDefault();
        // 필요한 경우 여기에 추가 코드를 삽입
        // 함수 실행 중단
        return false;
      }
    });
  });
</script>
<!--  onsubmit="return excelizeCheck()" -->
&nbsp;&nbsp;&nbsp;&nbsp;
<form action="excel" name="excelize" method="post" onsubmit="return excelizeCheck()" >
<input type="hidden" name="excelStatus" value="0">
<input type="hidden" name="debtor_id" value="${debtor_id }">
<input type="hidden" name="creditor_id" value="${creditor_id }">
<input type="hidden" name="lawyer_id" value="${lawyer_id }">
<input type="hidden" name="debtor_name" value="${debtor_name }">
<fieldset style="broder-color: black; width: 1230px; height: 110px;">
     <legend>엑셀화</legend>     
     &nbsp;
     <input type="checkbox" name="category" value="날짜">날짜&nbsp;
     <input type="checkbox" name="category" value="대여금">대여금&nbsp;
     <input type="checkbox" name="category" value="적용이율">적용이율&nbsp;
     <input type="checkbox" name="category" value="30%원금(충당전)">30%원금(충당전)&nbsp;
     <input type="checkbox" name="category" value="18%원금(충당전)">18%원금(충당전)&nbsp;
     <input type="checkbox" name="category" value="12%원금(충당전)">12%원금(충당전)&nbsp;
     <input type="checkbox" name="category" value="30%이자(충당전)">30%이자(충당전)&nbsp;
     <input type="checkbox" name="category" value="18%이자(충당전)">18%이자(충당전)&nbsp;
     <input type="checkbox" name="category" value="12%이자(충당전)">12%이자(충당전)&nbsp;<br>
     &nbsp;<input type="checkbox" name="category" value="변제금액">변제금액&nbsp;
     <input type="checkbox" name="category" value="30%원금(충당후)">30%원금(충당후)&nbsp;
     <input type="checkbox" name="category" value="18%원금(충당후)">18%원금(충당후)&nbsp;
     <input type="checkbox" name="category" value="12%원금(충당후)">12%원금(충당후)&nbsp;
     <input type="checkbox" name="category" value="30%이자(충당후)">30%이자(충당후)&nbsp;
     <input type="checkbox" name="category" value="18%이자(충당후)">18%이자(충당후)&nbsp;
     <input type="checkbox" name="category" value="12%이자(충당후)">12%이자(충당후)&nbsp;
     <input type="checkbox" name="category" value="피고채권">피고채권&nbsp;
     <br>
     &nbsp;
     엑셀파일 이름 &nbsp;:&nbsp; 
     <input type="text" name="fileName" placeholder="파일 이름 입력" style="width: 200px; height: 18px; font-size: medium;">
     <br>
     &nbsp;
     순번입력&nbsp;:&nbsp;
     <input type="text" name="num1" placeholder="시작순번" style="width: 100px; height: 18px; font-size: medium;">&nbsp;~&nbsp;
     <input type="text" name="num2" placeholder="끝순번" style="width: 100px; height: 18px; font-size: medium;">&nbsp;
     <input type="submit" value="엑셀화" name="part" style="width: 100px; height: 23px;">&nbsp;&nbsp;( 순번이 입력되지 않을 시 전체 엑셀화 진행 )
     <!-- &nbsp;&nbsp;|&nbsp;&nbsp;<input type="button" value="전체 엑셀화" name="entire" onclick="entireExcelize()" style="width: 100px; height: 23px;"> -->
</fieldset>
</form>
<br>

<script>
  // 문서가 로드되면 실행
  document.addEventListener('DOMContentLoaded', function() {
    // 폼 요소 선택
    var form = document.getElementsByName('excelize')[0];
    
    // 폼 내에서의 키다운 이벤트 감지
    form.addEventListener('keydown', function(event) {
      // 엔터 키가 눌렸는지 확인 (엔터 키의 keyCode는 13입니다)
      if (event.keyCode === 13) {
        // 기본 동작 방지 (엔터 키로 인한 폼 제출 방지)
        event.preventDefault();
        // 필요한 경우 여기에 추가 코드를 삽입
        // 함수 실행 중단
        return false;
      }
    });
  });
</script>

<table border="1" style="border-color:white; width: 2420px; text-align: center; border-collapse: collapse; ">
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
        <td colspan="2" style="border-color:black; border-right: none; border-top: none;">
        
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
        <td style="width: 60px;">
            수정
        </td>
        <td style="width: 40px;">
            순번
        </td>
    </tr>
    <form name="frm" action="updateFinancial" method="post">
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
	        <td>
	           <input type="button" onclick="updateFinancial('${tempDebtList.debt_id}','${tempDebtList.debtor_id}','${tempDebtList.debt_interest }','${tempDebtList.lawyer_id }','${tempDebtList.creditor_id }')" value="수정" style="height: 25px; width:50px;">   
	        </td>
	        <td>
                ${i} 
            </td>
        </tr>    
    </c:forEach>
    <input type="hidden" name="debtor_id" value="">
    <input type="hidden" name="debt_id" value="">
    <input type="hidden" name="debt_interest" value="">
    <input type="hidden" name="lawyer_id" value="">
    <input type="hidden" name="creditor_id" value="">
    </form>  
</table>
</body>
</html>