<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
<%
// 로그인 폼으로부터 받은 아이디와 패스워드
String signInId = request.getParameter("sinid"); 
String signInPwd = request.getParameter("sinpw");  

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDto memberDto = dao.signIn(signInId, signInPwd);
dao.close();

// 로그인 성공 여부에 따른 처리
if (memberDto.getId() != null) {
    // 로그인 성공
    session.setAttribute("signInId", memberDto.getId());
    session.setAttribute("signInNickname", memberDto.getNickname());
    session.setAttribute("signInGrade", memberDto.getGrade());
    response.sendRedirect("../common/index.jsp");
}
else {
    // 로그인 실패
    request.setAttribute("LoginErrMsg", "로그인 오류입니다."); 
    request.getRequestDispatcher("signIn.jsp").forward(request, response);
}
%>
</body>
</html>