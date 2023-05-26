<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디·비밀번호 찾기</title>
</head>
<body>
	<script type="text/javascript" src="./js/checkForm.js"></script>
	<%@ include file="../common/header.jsp" %>
	<section>
		<input type="radio" name="index" value="findId">아이디 찾기
		<input type="radio" name="index" value="findPw">비밀번호 찾기
	</section>
	<!-- 아이디 찾기 폼 -->
	<div id="findIdTab">
		<form name="findMyIdForm" id="findMyIdForm" action="findMyIdProcess.jsp" method="post">
			<fieldset>
				<label>이름</label>
				<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="findIdName" id="findIdName"><br>
				<label>휴대폰번호</label>
				<input type="tel" maxlength="20" placeholder="010-1234-5678" name="findIdPhone" id="findIdPhone"><br>
				<input type="button" onclick="findMyIdFormCheck()" value="아이디 찾기">
			</fieldset>
		</form>
	</div> <!-- findIdTab End -->
	<!-- 비밀번호 찾기 폼 -->
	<div id="findPwdTab">
		<form name="findMyPwdForm" id="findMyPwdForm" action="findMyPwdProcess.jsp" method="post">
			<fieldset>
				<label>이름</label>
				<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="findPwdName" id="findPwdName"><br>
				<label>휴대폰번호</label>
				<input type="tel" maxlength="20" placeholder="010-1234-5678" name="findPwdPhone" id="findPwdPhone"><br>
				<label>아이디</label>
				<input type="text" maxlength="12" placeholder="아이디" name="findPwdId" id="findPwdId"><br>
				<input type="button" onclick="findMyPwdFormCheck()" value="비밀번호 찾기">
			</fieldset>
		</form>
	</div> <!-- findPwdTab End -->
	<%@ include file="../common/footer.jsp" %>
</body>
</html>