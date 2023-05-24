<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./isLoggedIn.jsp"%>
<%
String num = request.getParameter("num");  // 일련번호 얻기 

ReserveDTO dto = new ReserveDTO();             // DTO 객체 생성
ReserveDAO dao = new ReserveDAO(application);  // DAO 객체 생성
dto = dao.scoreView(num);  // 주어진 일련번호에 해당하는 기존 게시물 얻기

// 로그인된 사용자 ID 얻기
String sessionId = session.getAttribute("signInId").toString(); 

int delResult = 0;

if (sessionId.equals(dto.getResid())) {  // 작성자가 본인인지 확인 
    // 작성자가 본인이면...
    dto.setResnumber(Integer.parseInt(num));
    delResult = dao.cancleReserve(dto);  // 삭제!!! 
    dao.updateRoom(dto.getActnumber());
/*     int delRev = dao.deleteReview(dto);
    int delSco = dao.deleteScore(dto); */
    dao.close();

    // 성공/실패 처리
    if (delResult == 1) { 
        // 성공 시 목록 페이지로 이동
        JSFunction.alertLocation("취소되었습니다.", "myReservation.jsp", out); 
    } else {
        // 실패 시 이전 페이지로 이동
        JSFunction.alertBack("취소를 실패하였습니다.", out);
    } 
} 
else { 
    // 작성자 본인이 아니라면 이전 페이지로 이동
    JSFunction.alertBack("본인만 취소할 수 있습니다.", out);

    return;
}
%>