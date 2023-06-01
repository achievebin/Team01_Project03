<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
String num = request.getParameter("num");  // 일련번호 얻기 

ActDTO dto = new ActDTO();             // DTO 객체 생성
ActDAO dao = new ActDAO(application);  // DAO 객체 생성
dto = dao.selectView(num);  // 주어진 일련번호에 해당하는 기존 게시물 얻기

// 로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("signInId").toString(); 

int delResult = 0;

//작성자가 본인인지 확인 
if (sessionId.equals(dto.getActId())) {  // 작성자가 본인일경우
    
    dto.setActNumber(num); //dto에 선택된 숙소의 숙소번호를 입력
    delResult = dao.deletePost(dto);  // 해당 숙소번호를 가진 데이터 삭제
/*     int delRev = dao.deleteReview(dto);
    int delSco = dao.deleteScore(dto); */
    dao.close();

    // 성공/실패 처리
    if (delResult == 1) { 
        // 성공 시 목록 페이지로 이동
        JSFunction.alertLocation("삭제되었습니다.", "actList.jsp", out); 
    } else {
        // 실패 시 이전 페이지로 이동
        JSFunction.alertBack("삭제에 실패하였습니다.", out);
    } 
} 
else { 
    // 작성자 본인이 아니라면 이전 페이지로 이동
    JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);

    return;
}
%>