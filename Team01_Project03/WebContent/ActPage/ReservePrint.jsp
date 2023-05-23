<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date sysdate = new Date(dateFormat.parse(todayfm).getTime());

String num = request.getParameter("num");  // 일련번호 받기 



ReserveDAO rdao = new ReserveDAO(application); //예약 dao 생성

ReserveDTO rdto = rdao.scoreView(num); //예약 가져오기

String actnum = String.valueOf(rdto.getActnumber());



ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(actnum);        // 게시물 가져오기 
String actname = dto.getActName();
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성
ScoreDTO sdto = sdao.scoreView(actnum); //점수 가져오기


if (rdto.getResend().compareTo(sysdate)>0){
int upd = rdao.updateRoom(Integer.parseInt(actnum));
}
int act_price = dto.getActPrice();


dao.close();      
sdao.close();// DB 연결 해제
rdao.close();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../Common/header.jsp" %>
<meta charset="UTF-8">

<script>
function resCancel() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ReserverFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "ReserveCancelProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>

<title>예약 정보</title>

</head>
<body>
<div style=""></div>
<%-- <jsp:include page="../ActPage/MainLink.jsp" /> --%>
<h2>예약 정보</h2>
 
<form name="ReserverFrm" method="post">
<input type="hidden" name="num" value="<%= rdto.getResnumber() %>" />
    <table border="1" style="width=50%">
        <tr>

        
            <td style="width: 10%;">숙소 이름</td>
            <td style="width: 20%;">
                <%= rdto.getReshotel() %>
            </td>
            </tr>
            <tr>
            <td style="width: 20%;">숙소 정보</td>          
            <td style="width: 30%;">
                <%= dto.getActInfo() %>
            </td>
            </tr>
            <tr>
            <td>예약자명</td><td><%=rdto.getResname()%> </td>
            
            </tr>
            <tr><td>예약 아이디</td><td><%=rdto.getResid()%> </td></tr>
            <tr>
            <td>예약자 휴대번호</td><td><%=rdto.getResphone()%> </td>
            </tr>
         <tr>
         <td>
		<label>체크인 날짜</label>

		<%= rdto.getResstart() %>
		</td>
		<td>
		<label>체크아웃 날짜</label>
		<%= rdto.getResend() %>
		</td>
            
        </tr>
        </table>
        <hr width="50%" align="left">
        </form>

<form name="saleFrm" method="post">
	<h2>총 금액</h2>
    <table border="1" style="width:50%">
        <tr>
            <td width="15%">구매 총액</td>
            <td>
                <%= rdto.getResprice() %> 원
            </td>

            
        </tr>

        </table>
        <hr width="50%" align="left">
        </form>

<form name="purchaseFrm" method="post">
        <h2>결제수단</h2>
        <table>
	        <tr>
	        	<td><%=rdto.getRespurchase() %></td>
	        </tr>
        </table>
			<button type="button" onclick="location.href='myReservation.jsp';">목록 보기</button>
        </form> 
        <%if (rdto.getResstart().compareTo(sysdate) >=0 && rdto.getRescancle().equals("예약됨")){%>
        	<button type="button" onclick="resCancel();">예약 취소</button>
        	
        	
        	
       <%} %>
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
