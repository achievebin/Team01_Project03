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
String yid = request.getParameter("userid");

//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
int idResult = dao.findId(yid);
dao.close();

if (idResult == 1) {
	request.setAttribute("IdCheckMsg", "중복되는 아이디입니다."); 
    request.getRequestDispatcher("IdDuplicateCheck.jsp").forward(request, response);
} else if (idResult == 0) {
	request.setAttribute("IdCheckMsg", "사용 가능한 아이디입니다."); 
    request.getRequestDispatcher("IdDuplicateCheck.jsp").forward(request, response);
	%>
	<input type="button" value="사용하기" onclick="insertCheckedId()">
	<%
} else {
	request.setAttribute("IdCheckMsg", "오류가 발생했습니다."); 
    request.getRequestDispatcher("IdDuplicateCheck.jsp").forward(request, response);
}
%>
</body>
</html>