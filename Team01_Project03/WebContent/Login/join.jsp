<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<script type="text/javascript" src="./checkForm.js"></script>
	<%@ include file="../Common/header.jsp" %>
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
		<input type="button" value="중복확인" onclick="idDuplicateCheck()">
		<input type="hidden" name="idCheck" value="uncheck">
		</div>
		<div>
		<label>비밀번호</label>
		<input type="password" maxlength="12" placeholder="비밀번호 입력" name="pw" id="pw">
		</div>
		<div>
		<label>비밀번호 확인</label>
		<input type="password" maxlength="12" placeholder="비밀번호 재입력" name="pwCheck" id="pwCheck">
		</div>
		</fieldset>
		<fieldset>
		<legend>개인 정보</legend>
		<div>
		<label>이름</label>
		<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name">
		</div>
		<div>
		<label>닉네임</label>
		<input type="text" maxlength="48" placeholder="닉네임을 기입" name="nickname" id="nickname">
		</div>
		<div>
		<label>생년월일</label>
		<input type="date" name="birth" id="birth">
		</div>
		<div>
		<label>성별</label>
		<input type="radio" name="sex" value="male">남자
		<input type="radio" name="sex" value="female">여자
		<input type="radio" name="sex" value="none" checked>선택 안 함
		</div>
		<div>
		<label>주소</label>
		<input type="text" maxlength="50" name="address" id="address">
		</div>
		<div>
		<label>휴대폰번호</label>
		<input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone">
		</div>
		<div>
		<label>e-mail</label>
		<input type="email" maxlength="40" placeholder="example@example.org" name="email" id="email">
		</div>
		</fieldset>
		<input type="button" value="가입하기" onclick="joinFormCheck()">
		<input type="button" value="돌아가기" onclick="history.back()">
	</form>
	<!-- 다음 주소 API 활용 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	function execDaumPostCode {
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	        }
	    }).open();
	}
	</script>
	<%@ include file="../Common/footer.jsp" %>
</body>
</html>
