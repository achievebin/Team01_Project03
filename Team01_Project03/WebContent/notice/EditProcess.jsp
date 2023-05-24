<%@ page import="board.NoticetblDAO"%>
<%@ page import="board.NoticetblDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/IsLoggedIn.jsp"%>
<%
// 수정 내용 얻기
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

// DTO에 저장
NoticetblDTO dto = new NoticetblDTO();
dto.setNoc_num(num);
dto.setNoc_title(title);
dto.setNoc_content(content);

// DB에 반영
NoticetblDAO dao = new NoticetblDAO(application);
int affected = dao.updateEdit(dto);
dao.close();

// 성공/실패 처리
if (affected == 1) {
    // 성공 시 상세 보기 페이지로 이동
    response.sendRedirect("View.jsp?num=" + dto.getNoc_num());
}
else {
    // 실패 시 이전 페이지로 이동
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
