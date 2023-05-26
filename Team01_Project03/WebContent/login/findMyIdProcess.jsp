<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 처리</title>
</head>
<body>
<%
// 아이디 찾기 폼으로부터 받은 아이디와 패스워드
String thatName = request.getParameter("findIdName"); 
String thatPhone = request.getParameter("findIdPhone");  

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
String foundYourId = dao.findMyId(thatName, thatPhone);
dao.close();

// 아이디 찾기 성공 여부에 따른 처리
if (foundYourId != null) {
	//아이디 찾기 성공
	%>
	<form>
	<div>회원님의 아이디는</div>
	<input type="button" value="로그인하기" onClick="a href='./signIn.jsp'">
	</form>
	<%
} else {
	//아이디 찾기 실패
	%>
	<form>
	<div>아이디를 찾을 수 없습니다.</div>
	<input type="button" value="다시 찾기" onClick="history.back()">
	<input type="button" value="회원가입하기" onClick="a href='./join.jsp'">
	</form>
	<%
}
%>
</body>
</html>