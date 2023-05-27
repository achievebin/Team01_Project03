<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="./css/test.css" rel="stylesheet" type="text/css">
</head>
<style>

</style>
<body>

	<script type="text/javascript" src="./js/checkForm.js"></script>
	<jsp:include page="/common/header.jsp" />
	<span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg")%>
        <%= request.getAttribute("joinOKMsg") == null ?
                "" : request.getAttribute("joinOKMsg")%>
    </span>
    
    <!-- 로그인 박스 -->
	<div class="box">
<!-- 		<input type="email" placeholder="Email" />
  		<input type="password" placeholder="Password" /> -->
		<form name="signInForm" id="signInForm" action="./test.jsp" method="post">
			<!-- 아이디 패스워드 -->
			<div class="contents">
				<ul>
					<li>
						<div class="idpw">
							<!-- <label>아이디</label> -->
							<input type="text" name="sinid" id="sinid" placeholder="아이디를 입력하세요"><br/>
							<!-- <label>비밀번호</label> -->
							<input type="password" name="sinpw" id="sinpw" placeholder="비밀번호를 입해력하세요"><br/>
						</div>
						<!-- 버튼 -->
						<div class="buttons">					
			<!-- 					<input class="my-button" type="button" value="로그인" onclick="signInFormCheck()">
								<input type="button" value="돌아가기" onclick="history.back()"><br> -->
								
								<button class="my-button" onclick="signInFormCheck()">로그인</button>
								<button class="my-button" onclick="history.back()">돌아가기</button>
							
						</div>
						<div class="join-Acc">
							<ul>
								<li>								
								<label>아직 회원이 아니신가요? <a href="./join.jsp">회원가입하기</a></label><br>
								<label><a href="./findMyAccount.jsp">아이디나 비밀번호를 잊어버리셨나요?</a></label>
								</li>
							</ul>
						</div>
						<li>
				</ul>
			</div>
		</form>
	</div>
	<form class="fixed-bottom">
	<jsp:include page="/common/footer.jsp" />
	</form>
</body>
</html>