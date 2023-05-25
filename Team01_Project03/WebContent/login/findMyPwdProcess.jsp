<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 처리</title>
</head>
<body>
<%
//비밀번호 찾기 폼으로부터 받은 이름과 전화번호와 아이디
String thatName = request.getParameter("findPwdName"); 
String thatPhone = request.getParameter("findPwdPhone"); 
String thatId = request.getParameter("findPwdId");

//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
String foundYourPwd = dao.findMyPwd(thatName, thatPhone, thatId);
dao.close();

//비밀번호 찾기 성공 여부에 따른 처리
if (foundYourPwd != null) {
	//비밀번호 찾기 성공
} else {
	//비밀번호 찾기 실패
}
%>
</body>
</html>