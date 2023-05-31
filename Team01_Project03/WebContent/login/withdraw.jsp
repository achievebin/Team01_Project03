<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="./css/signIn.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String myId = (String) session.getAttribute("signInId");
%>
	<script type="text/javascript" src="./js/checkForm.js"></script>
	<%@ include file="../common/header.jsp" %>
	<span style="color: red; font-size: 1.2em;"> 
			        <%= request.getAttribute("withdrawErrMsg") == null ?
			                "" : request.getAttribute("withdrawErrMsg") %>
			</span>
	<div class="box">
		<form name="withdrawForm" id="withdrawForm" action="./withdrawProcess.jsp" method="post">
			<div class="contents">
				<ul>
					<li>
						<!-- 아이디 패스워드 -->
						<div id="idpw">
							<label for="widid">아이디</label>
							<input type="text" name="widid" id="widid" value=<%= myId%> readonly><br/>
							<label for="widpw">비밀번호</label>
							<input type="password" name="widpw" id="widpw"><br/>
						</div>
						<!-- 버튼 -->
						<div id="buttons">					
							<button type="button" class="my-button" onclick="withdrawFormCheck()">회원탈퇴</button>
							<button type="button" class="my-button" onclick="history.back()">돌아가기</button>
						</div>
					<li>
				</ul>
			</div>
		</form>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>