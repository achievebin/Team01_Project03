<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
// 수정 내용 얻기
String num = (String)session.getAttribute("actnumber");
String name = request.getParameter("act_name");
String info = request.getParameter("act_info");
String address = request.getParameter("act_address");
String phone = request.getParameter("act_phone");
String room = request.getParameter("act_room");

// DTO에 저장
ActDTO dto = new ActDTO();
dto.setActName(name);
dto.setActInfo(info);
dto.setActAddress(address);
dto.setActPhone(phone);
dto.setActRoom(Integer.parseInt(room));
dto.setActNumber(num);

// DB에 반영
ActDAO dao = new ActDAO(application);
int affected = dao.updateEdit(dto);
int upRev = dao.updateRev(dto);
int upScore = dao.updateScore(dto);
dao.close();

// 성공/실패 처리
if (affected == 1) {
    // 성공 시 상세 보기 페이지로 이동
    response.sendRedirect("ActView.jsp?num=" + dto.getActNumber());
}
else {
    // 실패 시 이전 페이지로 이동
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
