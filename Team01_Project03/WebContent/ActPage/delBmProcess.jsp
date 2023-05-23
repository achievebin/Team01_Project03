<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="bookmark.bmDAO"%>
<%@ page import="bookmark.bmDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%
String num = (String)request.getParameter("num");  // 일련번호 얻기 

bmDTO dto = new bmDTO();             // DTO 객체 생성
bmDAO dao = new bmDAO(application);  // DAO 객체 생성



dto.setActNumber((String)num);

// 로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("signInId").toString(); 
dto.setBmId(sessionId);
int delResult = 0;

if (sessionId != null ) {  // 
 
    dto.setActNumber(num);
    dto.setBmId(sessionId);
    delResult = dao.delBookmark(dto);  // 관심목록에 추가
/*     int delRev = dao.deleteReview(dto);
    int delSco = dao.deleteScore(dto); */
    dao.close();

    // 성공/실패 처리
    if (delResult == 1) { 
        // 성공 시 목록 페이지로 이동
        JSFunction.alertLocation("삭제되었습니다.", "ActView.jsp?num=" + num, out); 
    } else {
        // 실패 시 이전 페이지로 이동
        JSFunction.alertBack("삭제를 실패하였습니다.", out);
    } 
} 
else { 
    // 작성자 본인이 아니라면 이전 페이지로 이동
    JSFunction.alertBack("로그인.", out);

    return;
}
%>