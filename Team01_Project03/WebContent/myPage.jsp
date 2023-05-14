<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이지</title>
</head>
<body>
<%
//세션
String myId = (String) session.getAttribute("signInId");

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDto memberDto = dao.getInfo(myId);
dao.close();

if (myId != null) {
	request.setAttribute("mypageId", memberDto.getId()); 
	request.setAttribute("mypagePw", memberDto.getPw()); 
	request.setAttribute("mypageName", memberDto.getName());
	request.setAttribute("mypageNickname", memberDto.getNickname());
	request.setAttribute("mypageBirth", memberDto.getBirth()); 
	request.setAttribute("mypageSex", memberDto.getSex());
	request.setAttribute("mypageAddress", memberDto.getAddress());
	request.setAttribute("mypagePhone", memberDto.getPhone());
	request.setAttribute("mypageEmail", memberDto.getEmail());
	request.setAttribute("mypageGrade", memberDto.getGrade());
	request.getRequestDispatcher("myPageProcess.jsp").forward(request, response);
} else {
	response.sendRedirect("./signIn.jsp");
}
%>
</body>
</html>