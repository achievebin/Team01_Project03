<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
String num = (String)request.getParameter("revNum");  // 일련번호 얻기 
String id = (String)request.getParameter("revId");	//id 얻기

ReviewDTO dto = new ReviewDTO();             // DTO 객체 생성
ReviewDAO dao = new ReviewDAO(application);  // DAO 객체 생성
dto = dao.selectView(num);  // 주어진 일련번호에 해당하는 기존 게시물 얻기

// 로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("signInId").toString(); 

int delResult = 0;

if (sessionId.equals(id)) {  // 작성자가 본인인지 확인 
    // 작성자가 본인이면...
    dto.setActNumber(num);
    delResult = dao.deletePost(dto);  // 삭제!!! 
    int revUpdate = dao.scoreUpdate(dto);//삭제 시 숙소 점수 업데이트
    
    // 성공/실패 처리
    if (delResult == 1) { 
        // 성공 시 목록 페이지로 이동
        JSFunction.alertLocation("삭제되었습니다.", "../actPage/actList.jsp", out); 
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
dao.close();
%>