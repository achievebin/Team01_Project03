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
String myId = (String) session.getAttribute("signInId");
%>
	<script type="text/javascript" src="./checkForm.js"></script>
	<%@ include file="../common/header.jsp" %>
	<span style="color: red; font-size: 1.2em;"> 
			        <%= request.getAttribute("withdrawErrMsg") == null ?
			                "" : request.getAttribute("withdrawErrMsg") %>
			</span>
	<div>
		<form name="withdrawForm" id="withdrawForm" action="./withdrawProcess.jsp" method="post">
			<label>아이디</label>
			<input type="text" name="widid" id="widid" value=<%= myId%> readonly><br/>
			<label>비밀번호</label>
			<input type="password" name="widpw" id="widpw"><br/>
			<input type="button" value="회원탈퇴" onclick="withdrawFormCheck()">
			<input type="button" value="돌아가기" onclick="history.back()"><br>
		</form>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>