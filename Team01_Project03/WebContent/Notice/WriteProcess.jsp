<%@ page import="board.NoticetblDAO"%>
<%@ page import="board.NoticetblDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%> <!-- 경고페이지 -->
<%
// 폼값 받기
String title = request.getParameter("noc_title");
String content = request.getParameter("noc_content");

// 폼값을 DTO 객체에 저장
NoticetblDTO dto = new NoticetblDTO();
dto.setNoc_title(title);
dto.setNoc_content(content);
dto.setMit_id(session.getAttribute("signInId").toString());

// DAO 객체를 통해 DB에 DTO 저장
NoticetblDAO dao = new NoticetblDAO(application);
int iResult = dao.insertWrite(dto);
dao.close();

if (iResult == 1) {
    response.sendRedirect("List.jsp");
} else {
    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>




