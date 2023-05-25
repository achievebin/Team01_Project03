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
		<input type="radio" name="what" value="findId">아이디 찾기
		<input type="radio" name="what" value="findPw">비밀번호 찾기
	</section>
	<!-- 아이디 찾기 -->
	<div>
		<form name="findMyIdForm" id="findMyIdForm" action="findMyAccountProcess.jsp">
			<fieldset>
				<label>이름</label>
				<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name">
				<label>휴대폰번호</label>
				<input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone">
				<input type="button" onclick="findMyIdFormCheck()" value="아이디 찾기">
			</fieldset>
		</form>
	</div> <!-- first end -->
	<!-- 비밀번호 찾기 -->
	<div>
		<form name="findMyPwdForm" id="findMyPwdForm" action="findMyAccountProcess.jsp">
			<fieldset>
				<label>이름</label>
				<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name">
				<label>휴대폰번호</label>
				<input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone">
				<label>아이디</label>
				<input type="text" maxlength="12" placeholder="아이디" name="id" id="id">
				<input type="button" onclick="findMyPwdFormCheck()" value="비밀번호 찾기">
			</fieldset>
		</form>
	</div> <!-- second end -->
	<%@ include file="../common/footer.jsp" %>
</body>
</html>