<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인 처리</title>
</head>
<body>
<%
// 아이디 찾기 폼으로부터 받은 아이디와 패스워드
String uncheckedId = request.getParameter("uncheckedId");  

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
int DuplicateResult = dao.checkValidId(uncheckedId);
dao.close();

// 아이디 중복 여부에 따른 처리
if (DuplicateResult == 1) {
	//가입된 아이디가 존재하지 않는 경우 사용 가능
} else if (DuplicateResult == 0) {
	//가입된 아이디가 존재하는 경우 사용 불가
}
%>
</body>
</html>