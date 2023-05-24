<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../actPage/isLoggedIn.jsp"%>
<%
// 수정 내용 얻기
// 폼값 받기
String revnum = request.getParameter("rev_num"); //리뷰 번호
String title = request.getParameter("rev_title");  // 리뷰 제목
String content = request.getParameter("rev_content");	//리뷰 내용
String score = request.getParameter("rev_score");	//리뷰 점수
String actnumber = (String)session.getAttribute("actnumber");	//숙소 번호
String id = (String)session.getAttribute("signInId"); // 작성자 아이디

//폼값을 DTO 객체에 저장
ReviewDTO dto = new ReviewDTO();
dto.setNum(revnum); //리뷰 번호
dto.setTitle(title); // 리뷰 제목
dto.setContent(content); //리뷰 내용
dto.setScore(Integer.parseInt(score)); //리뷰 점수
dto.setId(id); // 작성자 아이디
dto.setActNumber(actnumber); //숙소 번호

// DB에 반영
ReviewDAO dao = new ReviewDAO(application);

int affected = dao.updateEdit(dto);	// 리뷰db 업데이트
int scu = dao.scoreUpdate(dto);	//리뷰 점수 db 업데이트

dao.close(); //db 연결해제

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
