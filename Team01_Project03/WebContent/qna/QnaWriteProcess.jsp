<%@ page import="QnA.QnAtblDAO" %>
<%@ page import="QnA.QnAtblDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/IsLoggedIn.jsp"%> <!-- 경고페이지 -->
<%
// 폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");

// 폼값을 DTO 객체에 저장
QnAtblDTO dto = new QnAtblDTO();
dto.setQna_title(title);
dto.setQna_content(content);
dto.setMit_id(session.getAttribute("signInId").toString());

// DAO 객체를 통해 DB에 DTO 저장
QnAtblDAO dao = new QnAtblDAO(application);
int iResult = dao.insertWrite(dto);
dao.close();

if (iResult == 1) {
    response.sendRedirect("QnaList.jsp");

} else {
    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>




