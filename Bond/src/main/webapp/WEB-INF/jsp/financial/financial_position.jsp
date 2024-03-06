<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>충당표</title>
</head>
<body>
<h3>[변제충당표]</h3>
<input type="button" style="width: 100px; height: 30px;" value="변제 / 대여">
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
    
    
    <tr style="border-color: black; height: 25px;">
        <td>
            1
        </td>
    </tr>
</table>
</body>
</html>