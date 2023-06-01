<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page import="java.util.Random"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../common/isLoggedIn.jsp"%> 
<%

// 폼값 받기
String title = request.getParameter("rev_title");  //리뷰 제목
String content = request.getParameter("rev_content"); //리뷰 내용
String score = request.getParameter("rev_score");  //리뷰 점수
String hotel = request.getParameter("rev_hotel");  //리뷰한 숙소 명
String actnumber = (String)session.getAttribute("actnumber"); //리뷰한 숙소 번호
String id = (String)session.getAttribute("signInId");  //리뷰 작성자 id

// 폼값을 DTO 객체에 저장
ReviewDTO dto = new ReviewDTO();
dto.setTitle(title); //리뷰 제목
dto.setContent(content); //리뷰 내용
dto.setId(id); //리뷰 작성자 id
dto.setScore(Integer.parseInt(score)); //리뷰 점수
dto.setHotel(hotel); //리뷰한 숙소 명
dto.setActNumber(actnumber); //리뷰한 숙소 번호

// DAO 객체를 통해 DB에 DTO 저장
ReviewDAO dao = new ReviewDAO(application);
Random random = new Random(); //더미데이터용 랜덤함수
// 기존 코드
int iResult = dao.insertWrite(dto);

//더미 데이터를 삽입하기 위한 코드
/*    int iResult = 0;
 for (int i = 1; i <= 400; i++) {
     dto.setTitle(title + "-" + i); 
     dto.setHotel("test");
     dto.setScore(random.nextInt(5)+1);
     iResult = dao.insertWrite(dto);
 }  */

dao.close(); //db연결해제

// 성공 or 실패? 
if (iResult == 1) {
    response.sendRedirect("../actPage/actView.jsp?num=" + dto.getActNumber());
} else {
    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>