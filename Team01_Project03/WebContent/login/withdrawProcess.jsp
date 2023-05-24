<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 회원탈퇴 폼으로부터 받은 아이디와 패스워드
String withdrawId = request.getParameter("widid"); 
String withdrawPwd = request.getParameter("widpw");  

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
int withdrawResult = dao.withdraw(withdrawId, withdrawPwd);
dao.close();

// 회원탈퇴 성공 여부에 따른 처리
if (withdrawResult != 0) {
	response.sendRedirect("signOut.jsp");
} else {
	request.setAttribute("withdrawErrMsg", "회원탈퇴 오류입니다.");
    request.getRequestDispatcher("withdraw.jsp").forward(request, response);
}
%>
</body>
</html>