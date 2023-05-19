<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<style>

</style>
<body>
	<script type="text/javascript" src="./checkForm.js"></script>
	<jsp:include page="/Common/header.jsp" />
	<span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg")%>
        <%= request.getAttribute("joinOKMsg") == null ?
                "" : request.getAttribute("joinOKMsg")%>
    </span>
    
    
	<div>
		<form class="position-absolute top-50 start-50 translate-middle" name="signInForm" id="signInForm" action="./signInProcess.jsp" method="post">
			<label>아이디</label>
			<input type="text" name="sinid" id="sinid"><br/>
			<label>비밀번호</label>
			<input type="password" name="sinpw" id="sinpw"><br/>
			<input type="button" value="로그인" onclick="signInFormCheck()">
			<input type="button" value="돌아가기" onclick="history.back()"><br>
			<label>아직 회원이 아니신가요? <a href="./join.jsp">회원가입하기</a></label>
		</form>
	</div>
	<!-- <div>
	아직 회원이 아니신가요? <a href="./join.jsp">회원가입하기</a>
	</div>
	<div>
	아이디나 비밀번호를 잊어버리셨나요?
	</div>
	</div> -->
	<form class="fixed-bottom">
	<jsp:include page="/Common/footer.jsp" />
	</form>
</body>
</html>
