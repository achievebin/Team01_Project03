<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String changeId = request.getParameter("prevId");
String changePw = request.getParameter("prevPw");
String changeName = request.getParameter("prevName");
String changeNickname = request.getParameter("prevNickname");
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
	<script type="text/javascript" src="./checkForm.js"></script>
	<span style="color: red; font-size: 1.2em;"> 
		        <%= request.getAttribute("updateInfoErrMsg") == null ?
		                "" : request.getAttribute("updateInfoErrMsg") %>
		</span>
	<form name="updateInfoForm" id="updateInfoForm" action="./updateInfoProcess.jsp" method="post">
			<fieldset>
			<legend>내 회원 정보</legend>
			<div>
			<label>아이디</label>
			<input type="text" name="newId" id="newId" value=<%=changeId %> readonly>
			</div>
			<div>
			<label>비밀번호</label>
			<input type="password" name="newPw" id="newPw" value=<%=changePw %>>
			</div>
			</fieldset>
			<fieldset>
			<legend>내 개인 정보</legend>
			<div>
			<label>이름</label>
			<input type="text" name="newName" id="newName" value=<%=changeName %>>
			</div>
			<div>
			<label>닉네임</label>
			<input type="text" name="newNickname" id="newNickname" value=<%=changeNickname %>>
			</div>
			<div>
			<label>생년월일</label>
			<input type="date" name="newBirth" id="newBirth" value=<%=changeBirth %> required>
			</div>
			<div>
			<label>성별</label>
			<% if (changeSex.equals("male")) {%>
			<input type="radio" name="newSex" value="male" checked>남자
			<input type="radio" name="newSex" value="female">여자
			<input type="radio" name="newSex" value="none">선택 안 함
			<%} else if (changeSex.equals("female")) {%>
			<input type="radio" name="newSex" value="male">남자
			<input type="radio" name="newSex" value="female" checked>여자
			<input type="radio" name="newSex" value="none">선택 안 함
			<%} else {%>
			<input type="radio" name="newSex" value="male">남자
			<input type="radio" name="newSex" value="female">여자
			<input type="radio" name="newSex" value="none" checked>선택 안 함
			<%} %>
			</div>
			<div>
			<label>주소</label>
			<input type="text" name="newAddress" id="newAddress" value=<%=changeAddress %>>
			</div>
			<div>
			<label>휴대폰번호</label>
			<input type="tel" name="newPhone" id="newPhone" value=<%=changePhone %>>
			</div>
			<div>
			<label>e-mail</label>
			<input type="email" name="newEmail" id="newEmail" value=<%=changeEmail %>>
			</div>
			</fieldset>
			<input type="button" value="회원수정" onclick="updateInfoFormCheck()">
			<input type="button" value="돌아가기" onclick="history.back()">
		</form>
</body>
</html>