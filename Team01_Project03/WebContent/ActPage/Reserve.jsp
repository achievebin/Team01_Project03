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



dao.close();      
sdao.close();// DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 예약</title>

</head>
<body>
<div style=""></div>
<%-- <jsp:include page="../ActPage/MainLink.jsp" /> --%>
<h2><%=actname%> 예약</h2>
<%-- <div style="width:600px; height:600px; border:2px solid black; float:right">네번째 영역
        <jsp:include page="../ActPage/ReservPrint.jsp" />
        
        
        
        </div>    --%>
        <script type="text/javascript" src="../ActPage/reservercheck.js"></script>
<form name="ReserverFrm" action="./ReserveProcess.jsp" method="post" method="post">
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
        
 
        <%-- <tr>
            <td>전화번호</td>
            <td><%= dto.getActPhone() %></td>
            <td>주소</td>
            <td><%= dto.getActAddress() %></td>
        </tr>
        <tr>
            <td>숙소명</td>
            
            <td colspan="3"><%= dto.getActName() %></td>
        </tr>
        <tr>
            <td>숙소정보</td>
            <td colspan="3" height="100">
                <%= dto.getActInfo() %></td> 
        </tr>
        <tr>
            <td>숙소별점</td>
            
            <td><%= sdto.getAvgScore() %></td> 
        </tr>
        <tr>
            <td>숙소가격</td>
            
            <td><%= dto.getActPrice() %></td> 
        </tr>
        <tr>
            <td colspan="4" align="center">
            <%
            if (session.getAttribute("signInId") != null
                && session.getAttribute("signInId").toString().equals(dto.getActId())) {
            %>
                <button type="button"
                        onclick="location.href='Edit.jsp?num=<%= dto.getActNumber() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
            <%
            }
            %>
                <button type="button" onclick="location.href='ReviewWrite.jsp';">
                    예약 하기
                </button>
                <button type="button" onclick="location.href='ActList.jsp';">
                    목록 보기
                </button>
                <button type="button" onclick="location.href='ReviewWrite.jsp';">
                    리뷰 쓰기
                </button>
            </td>
        </tr> --%>

    


</body>
</html>
