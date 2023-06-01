<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="bookmark.BmDAO"%>
<%@ page import="bookmark.BmDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
String num = (String)request.getParameter("num");  // 일련번호 얻기 

BmDTO dto = new BmDTO();             // DTO 객체 생성
BmDAO dao = new BmDAO(application);  // DAO 객체 생성



/* dto.setActNumber((String)num); // 일련번호를 dto에 입력 */

// 로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("signInId").toString(); 

int delResult = 0; // 값을 받으면 1로 변환

// 세션id가 공백이 아닐경우(로그인상태)
if (sessionId != null ) {  
 	//일련번호를 dto에 입력
    dto.setActNumber(num);
 	//아이디를 dto에 입력
    dto.setBmId(sessionId);
 	// 관심목록에 추가
    delResult = dao.addBookmark(dto);  

    dao.close(); //db연결종료

    // 성공/실패 처리
    if (delResult == 1) { 
        // 성공 시 목록 페이지로 이동
        JSFunction.alertLocation("추가되었습니다.", "../actPage/actView.jsp?num=" + num, out); 
    } else {
        // 실패 시 이전 페이지로 이동
        JSFunction.alertBack("추가를 실패하였습니다.", out);
    } 
} 
else { 
    // 로그인상태가 아니라면 이전 페이지로 이동
    JSFunction.alertBack("로그인.", out);

    return;
}
%>