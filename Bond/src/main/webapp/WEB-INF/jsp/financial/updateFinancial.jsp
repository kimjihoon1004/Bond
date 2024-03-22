<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>변제금/대여금 수정</title>
</head>
<body>
<c:choose>
    <c:when test="${debtMap.debt_condition eq 'rental'}">
		<form action="updateFinancialActivate" method="post">
		<input type="hidden" name="debtor_name" value="${debtor_name}">
		<input type="hidden" name="creditor_id" value="${creditor_id}">
		<input type="hidden" name="lawyer_id" value="${lawyer_id}">
		<input type="hidden" name="debt_condition" value="${debtMap.debt_condition }">
		<input type="hidden" name="debt_id" value="${debtMap.debt_id }">
        <input type="hidden" name="debtor_id" value="${debtMap.debtor_id }">
		<table border="2" style="width= 400px; margin-left: auto; margin-right: auto;">
		    <tr style="height: 50px; text-align: center;">
		        <td colspan="2" bgcolor="lightgray">
		            <h2>대여금 수정</h2>
		        </td>
		    </tr>
		    <tr style="height: 40px;">
		        <td style="text-align: center; width: 100px; bgcolor: lightgray">
		            이름
		        </td>
		        <td style="width: 300px; font-size:medium;">
		            &nbsp;&nbsp;${debtor_name }
		        </td>
		    </tr>
		    <tr style="height: 40px;">
                <td style="text-align: center; width: 100px; bgcolor: lightgray">
                    날짜
                </td>
                <td style="width: 300px; font-size:medium;">
                    &nbsp;&nbsp;<input type="date" value="${debtMap.debt_date}" name="debt_date">
                </td>
            </tr>
		    <tr style="height: 40px;">
		        <td style="text-align: center; width: 100px; bgcolor: lightgray">
		            대여금
		        </td>
		        <td style="width: 300px;">
		            &nbsp;&nbsp;<input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')"  value="${debtMap.debt_rental }" name="value">
		        </td>
		    </tr>
		    <tr style="height: 40px;">
                <td style="text-align: center; width: 100px; bgcolor: lightgray">
                    적용이율
                </td>
                <td style="width: 300px;">
                    &nbsp;&nbsp;
                    <select name="debt_interest">
                        <%
                        String debt_interest = request.getParameter("debt_interest");
                        String interest[] = {"12%", "18%", "30%"}; 
                        for(int i = 0; i < interest.length; i++)    {
                            if(debt_interest.equals(interest[i]))    {%>                        
                                <option value="<%=interest[i] %>" selected="selected"><%=interest[i] %></option>
                        <%  
                            }
                            else    {
                                %>
                                <option value="<%=interest[i] %>"><%=interest[i] %></option>
                                <%
                            }
                        }
                        %>
                    </select>
                </td>
            </tr>
		</table>
		<br>
		<div style="text-align: center;">
		    <input type="submit" value="수정" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
		    <input type="button" value="뒤로가기" onclick="history.back()" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
		</div>
		</form>
	</c:when>
	<c:when test="${debtMap.debt_condition eq 'liquidation'}">
        <form action="updateFinancialActivate" method="post">
        <input type="hidden" name="lawyer_id" value="${lawyer_id} ">
        <input type="hidden" name="creditor_id" value="${creditor_id }">
        <input type="hidden" name="debt_interest" value="${debt_interest }">
        <input type="hidden" name="debt_condition" value="${debtMap.debt_condition }">
        <input type="hidden" name="debt_id" value="${debtMap.debt_id }">
        <input type="hidden" name="debtor_id" value="${debtMap.debtor_id }">
        <input type="hidden" name="debtor_name" value="${debtor_name }">
        <table border="2" style="width= 400px; margin-left: auto; margin-right: auto;">
            <tr style="height: 50px; text-align: center;">
                <td colspan="2" bgcolor="lightgray">
                    <h2>변제금 수정</h2>
                </td>
            </tr>
            <tr style="height: 40px;">
                <td style="text-align: center; width: 100px; bgcolor: lightgray">
                    이름
                </td>
                <td style="width: 300px; font-size: medium;">
                    &nbsp;&nbsp;${debtor_name }
                </td>
            </tr>
            <tr style="height: 40px;">
                <td style="text-align: center; width: 100px; bgcolor: lightgray">
                    날짜
                </td>
                <td style="width: 300px; font-size:medium;">
                    &nbsp;&nbsp;<input type="date" value="${debtMap.debt_date}" name="debt_date">
                </td>
            </tr>
            <tr style="height: 40px;">
                <td style="text-align: center; width: 100px; bgcolor: lightgray">
                    변제금
                </td>
                <td style="width: 300px;">
                    &nbsp;&nbsp;<input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')"  value="${debtMap.debt_liquidation }" name="value">
                </td>
            </tr>
        </table>
        <br>
        <div style="text-align: center;">
            <input type="submit" value="수정" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
            <input type="button" value="뒤로가기" onclick="history.back()" style="font-size:medium; width:100px; height:30px;">&nbsp;&nbsp;
        </div>
        </form>
	</c:when>
</c:choose>
</body>
</html>