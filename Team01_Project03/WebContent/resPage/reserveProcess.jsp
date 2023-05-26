<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
// 수정 내용 얻기
String num = (String)session.getAttribute("actnumber"); // 숙소 번호
String name = request.getParameter("reserv_name");	// 예약자 성함
String phone = request.getParameter("reserv_phone");	// 예약자 전화번호
String purchase = request.getParameter("reserv_purchase");	// 결제수단
String price = request.getParameter("reserv_price");	// 총 금액
String hotel = request.getParameter("reserv_hotel");	// 숙소명
String id = (String)session.getAttribute("signInId");	// 예약자id

//날짜 포맷 설정
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date chkIndate = formatter.parse(request.getParameter("chk_in"));	//체크인 날짜
java.sql.Date chkIn = new java.sql.Date(chkIndate.getTime());

java.util.Date chkoutdate = formatter.parse(request.getParameter("chk_out")); //체크아웃 날짜
java.sql.Date chkOut = new java.sql.Date(chkoutdate.getTime());




// DTO에 저장
ReserveDTO dto = new ReserveDTO();
dto.setResname(name);	//예약자 명
dto.setActnumber(Integer.parseInt(num));	//숙소 번호
dto.setResstart(chkIn);	//체크인
dto.setResend(chkOut);	//체크아웃
dto.setResphone(phone);	//예약자 전화번호
dto.setRespurchase(purchase);	//결제수단
dto.setResprice(price);	// 총 금액
dto.setResid(id);	//예약자 아이디


// DB에 반영
ReserveDAO dao = new ReserveDAO(application);
int affected = dao.insertWrite(dto);	//db에 입력
int upd = dao.updateRoom(Integer.parseInt(num));	//객실수 업데이트

dao.close();	//db연결 해제

// 성공/실패 처리
if (affected == 1) {
    // 성공 시 예약 보기 페이지로 이동
    JSFunction.alertLocation("예약이 완료되었습니다.", "myReservation.jsp", out);
    /* response.sendRedirect("ReservePrint.jsp?num="+dto.getResnumber()+".jsp"); */
}
else {
    // 실패 시 이전 페이지로 이동
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
