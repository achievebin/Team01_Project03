<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./isLoggedIn.jsp"%>
<%

// 폼값 받기
String name = request.getParameter("act_name"); //숙소명
String info = request.getParameter("act_info"); //숙소정보
String address = request.getParameter("act_address"); //숙소주소
String phone = request.getParameter("act_phone"); //숙소 전화번호
String room = request.getParameter("act_room"); //숙소 객실수
String price = request.getParameter("act_price"); // 숙소 가격
String div = request.getParameter("act_div"); //숙소 구분

// 폼값을 DTO 객체에 저장
ActDTO dto = new ActDTO();
dto.setActName(name); //숙소명
dto.setActInfo(info); //숙소정보
dto.setActAddress(address); //숙소주소
dto.setActPhone(phone);  //숙소 전화번호
dto.setActRoom(Integer.parseInt(room)); //숙소 객실수
dto.setActId(session.getAttribute("signInId").toString()); //작성자 아이디
dto.setActPrice(Integer.parseInt(price)); // 숙소 가격
dto.setActDiv(div);
// DAO 객체를 통해 DB에 DTO 저장
ActDAO dao = new ActDAO(application);

//더미데이터용 랜덤함수
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

dao.close(); //db연결종료

// 성공 or 실패? 
if (iResult == 1) {
    response.sendRedirect("actList.jsp");
} else {
    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>