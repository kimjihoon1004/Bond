<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ǥ</title>
</head>
<body>
<h3>[�������ǥ]</h3>
<input type="button" style="width: 100px; height: 30px;" value="���� / �뿩">
<table border="1" style="border-color:white; width: 2380px; text-align: center; border-collapse: collapse; ">
    <tr style="height: 30px;">
        <td colspan="4" style="border-color: black; border-top: none; border-left: none;">        
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            �ش��ϱ��� �߻��� ���� ��� ���� ����
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            �ش��ϱ��� �߻��� ���� ��� ���� ����
        </td>
        <td style="border-color: black; border-top:none;">
        
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            ������� �� ����
        </td>
        <td colspan="3" style="border-color: black; background-color: yellow;">
            ������� �� ����
        </td>
        <td style="border-color:black; border-right: none; border-top: none;">
        
        </td>
    </tr>
    <tr style="height: 25px; border-color: black; background-color: yellow;">
        <td style="width: 40px;">
            ����
        </td>   
        <td style="width: 100px;">
            ��¥
        </td>
        <td style="width: 110px;">
            �뿩��
        </td>
        <td style="width: 80px;">
            ��������
        </td>
        <td style="width: 150px;">
            30%����(����)
        </td>
        <td style="width: 150px;">
            18%����(����)
        </td>
        <td style="width: 150px;">
            12%����(����)
        </td>
        <td style="width: 150px;">
            30%����(�հ��)
        </td>
        <td style="width: 150px;">
            18%����(�հ��)
        </td>
        <td style="width: 150px;">
            12%����(�հ��)
        </td>
        <td style="width: 150px; color: blue;">
            �����ݾ�
        </td>
        <td style="width: 150px;">
            30%����(�����)
        </td>
        <td style="width: 150px;">
            18%����(�����)
        </td>
        <td style="width: 150px;">
            12%����(�����)
        </td>
        <td style="width: 150px;">
            30%����(�����)
        </td>
        <td style="width: 150px; color: red;">
            18%����(�����)
        </td>
        <td style="width: 150px; color: red;">
            12%����(�����)
        </td>
        <td style="width: 100px; font-size:small;">
            �ǰ�ä��<br>
            (�δ��̵��)
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