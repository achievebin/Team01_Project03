<%@ page import="Act.ActDAO"%>
<%@ page import="Act.ActDTO"%>
<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="./IsLoggedIn.jsp"%> --%>
<%

// 폼값 받기
String name = request.getParameter("act_name");
String info = request.getParameter("act_info");
String address = request.getParameter("act_address");
String phone = request.getParameter("act_phone");
String room = request.getParameter("act_room");
String price = request.getParameter("act_price");


// 폼값을 DTO 객체에 저장
ActDTO dto = new ActDTO();
dto.setActName(name);
dto.setActInfo(info);
dto.setActAddress(address);
dto.setActPhone(phone);
dto.setActRoom(Integer.parseInt(room));
dto.setActId(session.getAttribute("signInId").toString());
dto.setActPrice(Integer.parseInt(price));

// DAO 객체를 통해 DB에 DTO 저장
ActDAO dao = new ActDAO(application);
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
    response.sendRedirect("ActList.jsp");
} else {
//    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>