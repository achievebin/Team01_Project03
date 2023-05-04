<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
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
// 회원가입 폼으로부터 받은 내용
String joinId = request.getParameter("id");
String joinPwd = request.getParameter("pw");
String joinName = request.getParameter("name");
//https://stackoverflow.com/questions/21575253/classcastexception-java-util-date-cannot-be-cast-to-java-sql-date
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utildate = formatter.parse(request.getParameter("birth"));
java.sql.Date joinBirth = new java.sql.Date(utildate.getTime());

String joinSex = request.getParameter("sex");
String joinAddress = request.getParameter("address");
String joinPhone = request.getParameter("phone");
String joinEmail = request.getParameter("email");


// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDto dto = new MemberDto(joinId, joinPwd, joinName, joinBirth, joinSex, joinAddress, joinPhone, joinEmail);
int joinresult = dao.join(dto);
dao.close();

// 회원가입 성공 여부에 따른 처리
if (joinresult != 0) {
    // 회원가입 성공
    response.sendRedirect("signIn.jsp");
}
 else {
    // 회원가입 실패
    request.setAttribute("joinErrMsg", "회원가입 오류입니다.");
    request.getRequestDispatcher("join.jsp").forward(request, response);
}
%>
</body>
</html>