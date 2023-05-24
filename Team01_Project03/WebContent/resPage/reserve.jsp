<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 
String actnum = (String)session.getAttribute("actnumber");
ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(actnum);        // 게시물 가져오기 
String actname = dto.getActName();
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(actnum); //점수 가져오기

int act_price = dto.getActPrice();



dao.close(); // 숙소DB 연결 해제    
sdao.close();// 점수DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 타이틀 -->
<title>숙소 예약</title>

</head>
<body>
<!-- 헤더 -->
<jsp:include page="/common/header.jsp" />
<div style=""></div>
<%-- <jsp:include page="../ActPage/MainLink.jsp" /> --%>
<!-- 숙소명 예약 출력 -->
<h2><%=actname%> 예약</h2>
        
        <!-- 예약 정보 입력 폼 -->
<form name="ReserverFrm" action="./reserveProcess.jsp" method="post" method="post">
    <h2>예약자 정보</h2>
    <table border="1" style="width:50%">

        <tr>
            <td>예약자 성함</td>
            <td>
                <input type="text" name="reserv_name" style="width: 90%;" id="reserv_name" />
            </td>
            
            <td>예약자 휴대번호</td>          
            <td>
                <input type="text" name="reserv_phone" style="width: 90%;" id="reserv_phone" />
            </td>
            </tr>
         <tr>
         <td>
		<label>체크인 날짜</label>
		<input type="date" name="chk_in" id="chk_in" required>
		</td>
		<td>
		<label>체크아웃 날짜</label>
		<input type="date" name="chk_out" id="chk_out" required>
		</td>
            
        </tr>
        </table>
        <hr width="50%" align="left">

	<h2>총 금액</h2>
    <table border="1" style="width:50%">
        <tr>
            <td width="15%">구매 총액</td>
            
            <td>
            <input type="hidden" name="reserv_price" value=<%=act_price %>/>
            <input type="hidden" name="reserv_hotel" value=<%=actname%>/>
            <input type="hidden" name="num" value=<%=num%>/>
                <%= act_price %></td>

            
        </tr>

        </table>
        <hr width="50%" align="left">

        <h2>결제수단 선택</h2>
            <select name="reserv_purchase" onchange="selectBoxChange(this.value);">
                <option value="신용카드">신용카드</option>
                <option value="무통장입금">무통장입금</option>
                <option value="간편결제">간편결제</option>   
            </select><br />
        <hr width="50%" align="left">
                
            <input type="checkbox" name="inter" value="terms_a" />약관A
            <input type="checkbox" name="inter" value="terms_b" />약관B
            
            <input type="submit" value="예약하기">
       
        </form> 
        <!-- 예약 정보 입력 폼 끝 -->
 
        

    


</body>
</html>
