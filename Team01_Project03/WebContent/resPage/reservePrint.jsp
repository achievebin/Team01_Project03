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

// 날짜 포맷 설정
String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date sysdate = new Date(dateFormat.parse(todayfm).getTime());

String num = request.getParameter("num");  // 일련번호 받기 



ReserveDAO rdao = new ReserveDAO(application); //예약 dao 생성

ReserveDTO rdto = rdao.scoreView(num); //예약 가져오기

String actnum = String.valueOf(rdto.getActnumber()); //숙소번호 가져오기



ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(actnum);        // 게시물 가져오기 
String actname = dto.getActName();
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성
ScoreDTO sdto = sdao.scoreView(actnum); //점수 가져오기

//예약날짜가 지날경우 취소 불가능
if (rdto.getResend().compareTo(sysdate)>0){
int upd = rdao.updateRoom(Integer.parseInt(actnum));
}
int act_price = dto.getActPrice();


dao.close(); //숙소 DB 연결 해제    
sdao.close();//점수 DB 연결 해제
rdao.close();//예약 DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<!-- 예약취소 함수 -->
<script>
function resCancel() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ReserverFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "reserveCancelProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
<!-- 예약취소 함수 끝 -->

<!-- 타이틀 -->
<title>예약 정보</title>

</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>
<div style=""></div>

<h2>예약 정보</h2>
 <!-- 예약 정보 출력  폼-->
<form name="ReserverFrm" method="post">
<input type="hidden" name="num" value="<%= rdto.getResnumber() %>" />
    <table border="1" style="width=50%">
        <tr>

        
            <td style="width: 10%;">숙소 이름</td>
            <td style="width: 20%;"><%= rdto.getReshotel() %></td>
        </tr>
         <tr>
            <td style="width: 20%;">숙소 정보</td>          
            <td style="width: 30%;"><%= dto.getActInfo() %></td>
         </tr>
         <tr>
            <td>예약자명</td><td><%=rdto.getResname()%> </td>
            
         </tr>
         <tr>
           	<td>예약 아이디</td><td><%=rdto.getResid()%> </td>
         </tr>
         <tr>
            <td>예약자 휴대번호</td><td><%=rdto.getResphone()%> </td>
         </tr>
         <tr>
         	<td><label>체크인 날짜</label><%= rdto.getResstart() %></td>
			<td><label>체크아웃 날짜</label><%= rdto.getResend() %></td>   
        </tr>
    </table>
        <hr width="50%" align="left">
 </form>
 <!-- 예약 정보 출력  폼 끝-->
  <!-- 총 금액 출력 폼-->
<form name="saleFrm" method="post">
	<h2>총 금액</h2>
    <table border="1" style="width:50%">
        <tr>
            <td width="15%">구매 총액</td>
            <td><%= rdto.getResprice() %> 원</td>
		</tr>
	</table>
        <hr width="50%" align="left">
</form>
  <!-- 총 금액 출력 폼 끝-->
  
   <!-- 결제수단 출력 폼 -->
<form name="purchaseFrm" method="post">
        <h2>결제수단</h2>
        <table>
	        <tr>
	        	<td><%=rdto.getRespurchase() %></td>
	        </tr>
        </table>
			<button type="button" onclick="location.href='myReservation.jsp';">목록 보기</button>
</form> 
<!-- 결제수단 출력 폼 끝 -->

		<!-- 날짜가 오늘보다 미래일경우 예약 취소버튼 출력 -->
        <%if (rdto.getResstart().compareTo(sysdate) >=0 && rdto.getRescancle().equals("예약됨")){%>
        	<button type="button" onclick="resCancel();">예약 취소</button>  	
       <%} %>
</body>
</html>
