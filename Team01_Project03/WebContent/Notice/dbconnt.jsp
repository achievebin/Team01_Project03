<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "testerid";
	String pwd = "testerpw";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "select * from MEMBERIDTBLE";%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC를 이용한 데이터베이스 테이블 만들기</title>
</head>
<body>
	<%
		try {
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, uid, pwd);
		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();
		// 쿼리 생성
		rs = stmt.executeQuery(sql);
	%>
	<table border="1">
		<tr>
			<td>회원번호</td>
			<td>아이디</td>
			<td>암호</td>
			<td>이름</td>
			<td>생일</td>
			<td>성별</td>
			<td>주소</td>
			<td>전화번호</td>
			<td>메일</td>
			<td>날짜</td>
		</tr>
		
		
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("mit_number") %></td>
			<td><%=rs.getString("mit_id")%></td>
			<td><%=rs.getString("mit_pw") %></td>
			<td><%=rs.getString("mit_name")%></td>
			<td><%=rs.getString("mit_birth")%></td>
			<td><%=rs.getString("mit_sex")%></td>
			<td><%=rs.getString("mit_address") %></td>
			<td><%=rs.getString("mit_phone") %></td>
			<td><%=rs.getString("mit_email") %></td>
			<td><%=rs.getString("mit_sdate") %></td>
		</tr>
		
	<%
		}
	} catch (Exception e) {
	e.printStackTrace();
	} finally {
	try {
	if (rs != null) {
		rs.close();
	}
	if (stmt != null) {
		stmt.close();
	}
	if (conn != null) {
		conn.close();
	}
	} catch (Exception e) {
	e.printStackTrace();
	}
	}
	%>
	</table>
</body>
</html>