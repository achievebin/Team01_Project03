<%@ page import="java.sql.Date" %>
<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String myId = (String) session.getAttribute("signInId");
//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberDao dao = new MemberDao(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDto dto = dao.getInfo(myId);
dao.close();

String yourId = (String)request.getAttribute("mypageId");
String yourPw = (String)request.getAttribute("mypagePw");
String yourName = (String)request.getAttribute("mypageName");
String yourNickname = (String)request.getAttribute("mypageNickname");
Date yourBirth = (Date)request.getAttribute("mypageBirth");
String yourSex = (String)request.getAttribute("mypageSex");
String yourAddress = (String)request.getAttribute("mypageAddress");
String yourPhone = (String)request.getAttribute("mypagePhone");
String yourEmail = (String)request.getAttribute("mypageEmail");
String yourGrade = (String)request.getAttribute("mypageGrade");
%>
<!DOCTYPE html>
<html>
<head>
<!-- css 연결 -->
<link href="./css/myPage.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>내 페이지</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div id="myPage">
	<h2>마이 페이지</h2>
	<form name="myPageForm" action="./updateInfoB.jsp" method="post">
	<input type="hidden" name="prevId" value=<%=dto.getId() %> readonly>
	<input type="hidden" name="prevPw" value=<%=dto.getPw() %> readonly>
	<input type="hidden" name="prevName" value=<%=dto.getName() %> readonly>
	<input type="hidden" name="prevNickname" value=<%=dto.getNickname() %> readonly>
	<input type="hidden" name="prevBirth" value=<%=dto.getBirth() %> readonly>
	<input type="hidden" name="prevSex" value=<%=dto.getSex() %>>
	<input type="hidden" name="prevAddress" value=<%=dto.getAddress() %> readonly>
	<input type="hidden" name="prevPhone" value=<%=dto.getPhone() %> readonly>
	<input type="hidden" name="prevEmail" value=<%=dto.getEmail() %> readonly>
	
	<table id="myPageTable">
		<tr ><td colspan = '2' style="text-align: center;" ><font size="5">회원 정보</font></td></tr>
			
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>아이디</label></td>
				<td><%=dto.getId() %></td>
			</tr>
			
			
			
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>이름</label></td>
				<td><%=dto.getName()%></td>
			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>닉네임</label></td>
				<td><%=dto.getNickname()%></td>
			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>생년월일</label></td>
				<td><%=dto.getBirth()%></td>
			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>성별</label></td>
				<td><%=dto.getSex()%></td>

			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>주소</label></td>
				<td><%=dto.getAddress()%></td>
			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>휴대폰번호</label></td>
				<td><%=dto.getPhone()%></td>
			</tr>
			<tr>
				<td style="text-align: right; padding-right: 10px;"><label>e-mail</label></td>
				<td><%=dto.getEmail()%></td>
			</tr>
			<tr align="center">
						
				<td colspan = '3'><a href="../revPage/myReview.jsp">활동내역</a>
							  <a href="../resPage/myReservation.jsp">예약정보</a>
							  <a href="../bmPage/bookMark.jsp">관심목록</a>
				</td>
		
			</tr>
			<tr>
				<td colspan = '2' align="center">
					<input type="submit" value="회원수정">
					<input type="button" value="회원탈퇴" onclick="location.href='withdraw.jsp';">
				</td>
			</tr>
			
		</table>
	</form>
	</div>
	<aside>

	</aside>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
