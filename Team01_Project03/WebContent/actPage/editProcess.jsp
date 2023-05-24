<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../actPage/isLoggedIn.jsp"%>
<%
// 수정 내용 얻기
String num = (String)session.getAttribute("actnumber"); //숙소 번호
String name = request.getParameter("act_name"); //숙소명
String info = request.getParameter("act_info"); //숙소정보
String address = request.getParameter("act_address"); //숙소주소
String phone = request.getParameter("act_phone"); //숙소 전화번호
String room = request.getParameter("act_room"); //숙소 객실수

// DTO에 저장
ActDTO dto = new ActDTO();
dto.setActName(name);  //숙소명
dto.setActInfo(info);  //숙소정보
dto.setActAddress(address);  //숙소주소
dto.setActPhone(phone);  //숙소 전화번호
dto.setActRoom(Integer.parseInt(room));  //숙소 객실수
dto.setActNumber(num);  //숙소번호

// DB에 반영
ActDAO dao = new ActDAO(application);
int affected = dao.updateEdit(dto);  //숙소 데이터 변경
int upRev = dao.updateRev(dto);  //리뷰 데이터 변경
int upScore = dao.updateScore(dto);  //숙소 점수 데이터 변경
dao.close(); //db 연결해제

// 성공/실패 처리
if (affected == 1) {
    // 성공 시 상세 보기 페이지로 이동
    response.sendRedirect("actView.jsp?num=" + dto.getActNumber());
}
else {
    // 실패 시 이전 페이지로 이동
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
