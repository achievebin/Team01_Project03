<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<script type="text/javascript" src="./checkForm.js"></script>
	<jsp:include page="./header.jsp"/>
	<span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg")%>
        <%= request.getAttribute("joinOKMsg") == null ?
                "" : request.getAttribute("joinOKMsg")%>
    </span>
	<form name="signInForm" action="./signInProcess.jsp" method="post">
		<label>아이디</label>
		<input type="text" name="sinid" id="sinid"><br/>
		<label>비밀번호</label>
		<input type="password" name="sinpw" id="sinpw"><br/>
		<input type="button" value="로그인" onclick="signInFormCheck()">
		<input type="submit" value="테스트">
		<input type="button" value="돌아가기" onclick="history.back()">
	</form>
	<div>
	아직 회원이 아니신가요? <a href="./join.jsp">회원가입하기</a>
	</div>
	<div>
	아이디나 비밀번호를 잊어버리셨나요?
	</div>
	<jsp:include page="./footer.jsp"/>
</body>
</html>