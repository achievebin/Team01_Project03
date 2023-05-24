<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./isLoggedIn.jsp"%>
<%
// 수정 내용 얻기
String num = (String)session.getAttribute("actnumber");
String name = request.getParameter("reserv_name");
String phone = request.getParameter("reserv_phone");
String purchase = request.getParameter("reserv_purchase");
String price = request.getParameter("reserv_price");
String hotel = request.getParameter("reserv_hotel");
String id = (String)session.getAttribute("signInId");




DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date chkIndate = formatter.parse(request.getParameter("chk_in"));
java.sql.Date chkIn = new java.sql.Date(chkIndate.getTime());

java.util.Date chkoutdate = formatter.parse(request.getParameter("chk_out"));
java.sql.Date chkOut = new java.sql.Date(chkoutdate.getTime());

if (name == "") { // txt에 아무값도 입력되지 않았을 때
	out.print("<script>alert(\"예약자 성함이 입력되지 않았습니다. 다시 입력해주세요.\");" 
	+"history.back();</script>");}

if (phone == "") { // txt에 아무값도 입력되지 않았을 때
	out.print("<script>alert(\"예약자 휴대번호가 입력되지 않았습니다. 다시 입력해주세요.\");" 
	+"history.back();</script>");}



// DTO에 저장
ReserveDTO dto = new ReserveDTO();
dto.setResname(name);
dto.setActnumber(Integer.parseInt(num));
dto.setResstart(chkIn);
dto.setResend(chkOut);
dto.setResphone(phone);
dto.setRespurchase(purchase);
dto.setResprice(price);
dto.setResid(id);


// DB에 반영
ReserveDAO dao = new ReserveDAO(application);
int affected = dao.insertWrite(dto);
int upd = dao.updateRoom(Integer.parseInt(num));

dao.close();

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
