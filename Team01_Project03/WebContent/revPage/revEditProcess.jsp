<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../actPage/isLoggedIn.jsp"%>
<%
// 수정 내용 얻기
// 폼값 받기
String revnum = request.getParameter("rev_num");
String title = request.getParameter("rev_title");
String content = request.getParameter("rev_content");
String score = request.getParameter("rev_score");
String actnumber = (String)session.getAttribute("actnumber");
String id = (String)session.getAttribute("signInId");

//폼값을 DTO 객체에 저장
ReviewDTO dto = new ReviewDTO();
dto.setNum(revnum);
dto.setTitle(title);
dto.setContent(content);
dto.setScore(Integer.parseInt(score));
dto.setId(id);
dto.setActNumber(actnumber);

// DB에 반영
ReviewDAO dao = new ReviewDAO(application);

int affected = dao.updateEdit(dto);
int scu = dao.scoreUpdate(dto);

dao.close();

// 성공/실패 처리
if (affected == 1) {
    // 성공 시 상세 보기 페이지로 이동
    response.sendRedirect("../actPage/actView.jsp?num=" + dto.getActNumber());
}
else {
    // 실패 시 이전 페이지로 이동
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
