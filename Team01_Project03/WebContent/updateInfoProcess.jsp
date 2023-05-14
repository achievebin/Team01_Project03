<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 처리</title>
</head>
<body>
<%
String updateId = request.getParameter("newId");
String updatePw = request.getParameter("newPw");
String updateName = request.getParameter("newName");
String updateNickname = request.getParameter("newNickname");
//https://stackoverflow.com/questions/21575253/classcastexception-java-util-date-cannot-be-cast-to-java-sql-date
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utildate = formatter.parse(request.getParameter("newBirth"));
java.sql.Date updateBirth = new java.sql.Date(utildate.getTime());
String updateSex = request.getParameter("newSex");
String updateAddress = request.getParameter("newAddress");
String updatePhone = request.getParameter("newPhone");
String updateEmail = request.getParameter("newEmail");

//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDto dto = new MemberDto(updateId, updatePw, updateName, updateNickname, updateBirth, updateSex, updateAddress, updatePhone, updateEmail);
int updateresult = dao.update(dto);
dao.close();

if (updateresult != 0) {
    // 회원정보수정 성공
    response.sendRedirect("myPage.jsp");
}
 else {
    // 회원정보수정 실패
    request.setAttribute("updateInfoErrMsg", "정보수정 오류입니다.");
    request.getRequestDispatcher("updateInfo.jsp").forward(request, response);
}
%>
</body>
</html>