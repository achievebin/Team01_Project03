<%@ page import="Review.ReviewDAO"%>
<%@ page import="Review.ReviewDTO"%>
<%@ page import="java.util.Random"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="./IsLoggedIn.jsp"%> --%>
<%

// 폼값 받기
String title = request.getParameter("rev_title");
String content = request.getParameter("rev_content");
String score = request.getParameter("rev_score");
String hotel = (String)request.getAttribute("actname");
String actnumber = (String)request.getAttribute("actnumber");
// 폼값을 DTO 객체에 저장
ReviewDTO dto = new ReviewDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setId("ryan");
dto.setScore(Integer.parseInt(score));
dto.setHotel(hotel);
dto.setActNumber(Integer.parseInt(actnumber));
// dto.setId(session.getAttribute("UserId").toString());

// DAO 객체를 통해 DB에 DTO 저장
ReviewDAO dao = new ReviewDAO(application);
Random random = new Random();
// 기존 코드
int iResult = dao.insertWrite(dto);

//더미 데이터를 삽입하기 위한 코드
/*   int iResult = 0;
 for (int i = 1; i <= 400; i++) {
     dto.setTitle(title + "-" + i); 
     dto.setHotel("test");
     dto.setScore(random.nextInt(5)+1);
     iResult = dao.insertWrite(dto);
 } */

dao.close();

// 성공 or 실패? 
if (iResult == 1) {
    response.sendRedirect("ReviewList.jsp");
} else {
//    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>