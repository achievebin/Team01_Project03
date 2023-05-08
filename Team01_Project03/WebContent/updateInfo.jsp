<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String changeId = request.getParameter("prevId");
String changePw = request.getParameter("prevPw");
String changeName = request.getParameter("prevName");
//https://stackoverflow.com/questions/21575253/classcastexception-java-util-date-cannot-be-cast-to-java-sql-date
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utildate = formatter.parse(request.getParameter("prevBirth"));
java.sql.Date changeBirth = new java.sql.Date(utildate.getTime());
String changeSex = request.getParameter("prevSex");
String changeAddress = request.getParameter("prevAddress");
String changePhone = request.getParameter("prevPhone");
String changeEmail = request.getParameter("prevEmail");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
</head>
<body>
<span style="color: red; font-size: 1.2em;"> 
	        <%= request.getAttribute("updateInfoErrMsg") == null ?
	                "" : request.getAttribute("updateInfoErrMsg") %>
	</span>
<form name="updateInfoForm" action="./updateInfoProcess.jsp" method="post">
		<fieldset>
		<legend>내 회원 정보</legend>
		<div>
		<label>아이디</label>
		<input type="text" name="newId" value=<%=changeId %> readonly>
		</div>
		<div>
		<label>비밀번호</label>
		<input type="password" name="newPw" value=<%=changePw %> required>
		</div>
		</fieldset>
		<fieldset>
		<legend>내 개인 정보</legend>
		<div>
		<label>이름</label>
		<input type="text" name="newName" value=<%=changeName %> required>
		</div>
		<div>
		<label>생년월일</label>
		<input type="date" name="newBirth" value=<%=changeBirth %> required>
		</div>
		<div>
		<label>성별</label>
		<% if (changeSex.equals("m")) {%>
		<input type="radio" name="newSex" value="m" checked>남자
		<input type="radio" name="newSex" value="f">여자
		<%} else if (changeSex.equals("f")) {%>
		<input type="radio" name="newSex" value="m">남자
		<input type="radio" name="newSex" value="f" checked>여자
		<%} else {%>
		<input type="radio" name="newSex" value="m">남자
		<input type="radio" name="newSex" value="f">여자
		<%} %>
		</div>
		<div>
		<label>주소</label>
		<input type="text" name="newAddress" value=<%=changeAddress %>>
		</div>
		<div>
		<label>휴대폰번호</label>
		<input type="tel" name="newPhone" value=<%=changePhone %> required>
		</div>
		<div>
		<label>e-mail</label>
		<input type="email" name="newEmail" value=<%=changeEmail %> required>
		</div>
		</fieldset>
		<input type="submit" value="회원수정">
		<input type="button" value="돌아가기" onclick="location.href='myPage.jsp';">
		</form>
</body>
</html>