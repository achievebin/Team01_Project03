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
act.ActDAO dao = new act.ActDAO(application);  // DAO 생성 
              
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
<h2><%=dto.getActName() %>숙소 예약</h2>
<%-- <div style="width:600px; height:600px; border:2px solid black; float:right">네번째 영역
        <jsp:include page="../ActPage/ReservPrint.jsp" />
        
        
        
        </div>    --%>
<form name="ReserverFrm" action="./ReservProcess.jsp" method="post" method="post">
    <table border="1" width="50%">
        <tr>

        <h2>예약 하기</h2>
            <td>예약자 성함</td>
            <td>
                <input type="text" name="reserv_name" style="width: 90%;" />
            </td>
            
            <td>예약자 휴대번호</td>          
            <td>
                <input type="text" name="reserv_phone" style="width: 90%;" />
            </td>
            </tr>
         <tr>
         <td>
		<label>체크인 날짜</label>
		<input type="date" name="chk_in" required>
		</td>
		<td>
		<label>체크아웃 날짜</label>
		<input type="date" name="chk_out" required>
		</td>
            
        </tr>
        </table>
        <hr width="50%" align="left">

    <table border="1" width="50%">
        <tr>

        <h2>총 금액</h2>
            <td width="15%">구매 총액</td>
            <td>
                <%= act_price %> 
            </td>

            
        </tr>

        </table>
        <hr width="50%" align="left">

        <h2>결제수단 선택</h2>
            <select name="purchase">
                <option value="credit">신용카드</option>
                <option value="cash">무통장입금</option>
                <option value="ezpay">간편결제</option>   
            </select><br />
        <hr width="50%" align="left">
                
            <input type="checkbox" name="inter" value="terms_a" />약관A
            <input type="checkbox" name="inter" value="terms_b" />약관B
            
            <button type="button" onclick="location.href='ReservPrint.jsp';">전송
                </button>
       
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
