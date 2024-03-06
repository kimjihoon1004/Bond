<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
            <!-- debt_id -->
            순번
        </td>   
        <td style="width: 100px;">
            <!-- debt_date -->
            날짜
        </td>
        <td style="width: 110px;">
            <!-- debt_rental -->
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
    <tr style="height: 25px; border-color: black;">
        <td>
            <!-- 순번 -->
            1
        </td>
        <td>
            <!-- 날짜 -->
            2024-03-05
        </td>
        <td>
            <!-- 대여금 -->
            2,000,000,000
        </td>
        <td>
            <!-- 적용이율 -->
            12%
        </td>
        <td>
            <!-- 30%원금(누적) -->
        
        </td>
        <td>
            <!-- 18%원금(누적) -->
        
        </td>
        <td>
            <!-- 12%원금(누적) -->
        
        </td>
        <td>
            <!-- 30%이자 합계액 -->
        </td>
        <td>
            <!-- 18%이자 합계액 -->
        </td>
        <td>
            <!-- 12%이자 합계액 -->
        </td>
        <td style="color: blue;">
            <!-- 변제금액 -->
            700,000
        </td>
        <td>
            <!-- 30%이자(충당후) 합계액 -->
        </td>
        <td>
            <!-- 18%이자(충당후) 합계액 -->
        </td>
        <td>
            <!-- 12%이자(충당후) 합계액 -->
        </td>
        <td>
            <!-- 30%원금(충당후) 합계액 -->
        </td>
        <td style="color: red;">
            <!-- 18%원금(충당후) 합계액 -->
        </td>
        <td style="color: red;">
            <!-- 12%원금(충당후) 합계액 -->
        </td>
        <td>
            <!-- 피고채권 -->
            77,595
        </td>
    </tr>
    <tr style="border-color: black; height: 25px;">
        <td>
            1
        </td>
    </tr>
</table>
</body>
</html>