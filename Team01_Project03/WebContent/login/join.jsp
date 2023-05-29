<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<script type="text/javascript" src="./js/checkForm.js"></script>
	<%@ include file="../common/header.jsp" %>
	<span style="color: red; font-size: 1.2em;"> 
	        <%= request.getAttribute("joinErrMsg") == null ?
	                "" : request.getAttribute("joinErrMsg") %>
	</span>
	<h2>회원가입</h2>
	<form name="joinForm" id="joinForm" action="./joinProcess.jsp" method="post">
		<fieldset>
			<legend>신규 회원 정보</legend>
			<div>
				<label>아이디</label>
				<input type="text" maxlength="12" placeholder="아이디" name="id" id="id">
				<input type="button" value="중복확인" onclick="isIdDuplicate()">
				<input type="hidden" name="isIdChecked" value="unchecked">
				<span id="idDuplicateResult"></span>
			</div> <!-- 아이디 div -->
			<div>
				<label>비밀번호</label>
				<input type="password" maxlength="12" placeholder="비밀번호 입력" name="pw" id="pw">
			</div> <!-- 비밀번호 div -->
			<div>
				<label>비밀번호 확인</label>
				<input type="password" maxlength="12" placeholder="비밀번호 재입력" name="pwCheck" id="pwCheck">
			</div> <!-- 비밀번호 확인 div -->
		</fieldset> <!-- first fieldset end -->
		<fieldset>
			<legend>개인 정보</legend>
			<div>
				<label>이름</label>
				<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name">
			</div> <!-- 이름 div -->
			<div>
				<label>닉네임</label>
				<input type="text" maxlength="48" placeholder="닉네임을 기입" name="nickname" id="nickname">
			</div> <!-- 닉네임 div -->
			<div>
				<label>생년월일</label>
				<input type="date" name="birth" id="birth">
			</div> <!-- 생년월일 div -->
			<div>
				<label>성별</label>
				<input type="radio" name="sex" value="male">남자
				<input type="radio" name="sex" value="female">여자
				<input type="radio" name="sex" value="none" checked>선택 안 함
			</div> <!-- 성별 div -->
			<div>
				<label>주소</label>
				<input type="text" maxlength="50" name="address" id="address">
			</div> <!-- 주소 div -->
			<div>
				<label>휴대폰번호</label>
				<input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone">
			</div> <!-- 휴대폰번호 div -->
			<div>
				<label>e-mail</label>
				<input type="email" maxlength="40" placeholder="example@example.org" name="email" id="email">
			</div> <!-- 이메일 div -->
		</fieldset> <!-- second fieldset end -->
		<input type="button" value="가입하기" onclick="joinFormCheck()">
		<input type="button" value="돌아가기" onclick="history.back()">
	</form>
	<%@ include file="../common/footer.jsp" %>
	<!-- 제이쿼리 사용을 위한 CDN(Contents Delivery Network) 삽입 -->
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	//아이디 중복 체크
	function isIdDuplicate() {
		let uncheckedId = $('#id').val();
		
		//페이지 변경 없이 값을 전달하기 위해 비동기 방식인 ajax 통신 사용
		$.ajax({
			url: "isIdDuplicate.jsp",
			type: "post",
			data: {uncheckedId: uncheckedId},
			dataType: "json",
			success: function(result) {
				if (result == 0) {
					$("#idDuplicateResult").html("사용 불가능한 아이디입니다.");
					$("#idDuplicateResult").attr('color', 'red');
				} else {
					$("#idDuplicateResult").html('사용 가능한 아이디입니다.');
					$("#idDuplicateResult").attr('color', 'green');
				}
			},
			error: function() {
				alert("서버 요청에 실패했습니다.");
			}
		});
	}
	</script>
</body>
</html>
