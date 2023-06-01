<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="./css/join.css" rel="stylesheet" type="text/css">
</head>
<body>
	<script type="text/javascript" src="./js/checkForm.js"></script>
	<%@ include file="../common/header.jsp" %>
	<span style="color: red; font-size: 1.2em;"> 
	        <%= request.getAttribute("joinErrMsg") == null ?
	                "" : request.getAttribute("joinErrMsg") %>
	</span>
	<div id="formbox">
		<h2>회원가입</h2>
		<form name="joinForm" id="joinForm" action="./joinProcess.jsp" method="post">
			<fieldset class="fs" id="idpwfs">
				<legend>신규 회원 정보</legend>
				<div class="my-input" id="idDiv">
					<label for="id">아이디</label><br>
					<input type="text" maxlength="12" placeholder="아이디" name="id" id="id" onclick="resetIdCheck()">
					<input type="button" id="idCheckButton" name="idCheckButton" value="중복확인" onclick="isIdDuplicate()">
					<input type="hidden" id="isIdChecked" name="isIdChecked" value="unchecked">
					<span id="idDuplicateResult"></span>
					<br><span class="errMsg" id="idErrMsg"></span>
				</div> <!-- 아이디 div -->
				<div class="my-input" id="pwDiv">
					<label for="pw">비밀번호</label><br>
					<input type="password" maxlength="12" placeholder="비밀번호 입력" name="pw" id="pw">
					<br><span class="errMsg" id="pwErrMsg"></span>
				</div> <!-- 비밀번호 div -->
				<div class="my-input" id="pwCheckDiv">
					<label for="pwCheck">비밀번호 확인</label><br>
					<input type="password" maxlength="12" placeholder="비밀번호 재입력" name="pwCheck" id="pwCheck">
					<br><span class="errMsg" id="pwCheckErrmsg"></span>
				</div> <!-- 비밀번호 확인 div -->
			</fieldset> <!-- first fieldset end -->
			<fieldset class="fs" id="privacyfs">
				<legend>개인 정보</legend>
				<div class="my-input" id="nameDiv">
					<label for="name">이름</label><br>
					<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name">
					<br><span class="errMsg" id="nameCheckErrmsg"></span>
				</div> <!-- 이름 div -->
				<div class="my-input" id="nicknameDiv">
					<label for="nickname">닉네임</label><br>
					<input type="text" maxlength="48" placeholder="닉네임을 기입" name="nickname" id="nickname">
					<br><span class="errMsg" id="nicknameErrmsg"></span>
				</div> <!-- 닉네임 div -->
				<div class="my-input" id="birthDiv">
					<label for="birth">생년월일</label><br>
					<input type="date" name="birth" id="birth">
					<br><span class="errMsg" id="birthErrmsg"></span>
				</div> <!-- 생년월일 div -->
				<div class="my-input" id="sexDiv">
					<label>성별<br>
					<input type="radio" name="sex" value="male">남자
					<input type="radio" name="sex" value="female">여자
					<input type="radio" name="sex" value="none" checked>선택 안 함
					</label>
					<br><span class="errMsg" id="sexErrmsg"></span>
				</div> <!-- 성별 div -->
				<div class="my-input" id="addressDiv">
					<label for="address">주소</label><br>
					<input type="text" maxlength="50" name="address" id="address" onclick="execDaumPostcode()">
					<br><span class="errMsg" id="adrressErrmsg"></span>
				</div> <!-- 주소 div -->
				<div class="my-input" id="phoneDiv">
					<label for="phone">휴대폰번호</label><br>
					<input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone">
					<br><span class="errMsg" id="phoneErrmsg"></span>
				</div> <!-- 휴대폰번호 div -->
				<div class="my-input" id="emailDiv">
					<label for="email">e-mail</label><br>
					<input type="email" maxlength="40" placeholder="example@example.org" name="email" id="email">
					<br><span class="errMsg" id="emailErrmsg"></span>
				</div> <!-- 이메일 div -->
			</fieldset> <!-- second fieldset end -->
			<div id="buttons">
				<input class="my-button" type="button" value="가입하기" onclick="joinFormCheck()">
				<input class="my-button" type="button" value="돌아가기" onclick="history.back()">
			</div>
		</form>
	</div>
	<!-- 제이쿼리 사용을 위한 CDN(Contents Delivery Network) 삽입 -->
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<!-- 다음 주소 API 사용을 위한 CDN 삽입 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	//아이디 중복 체크
	function isIdDuplicate() {
	    let id = $('#id').val();
	    //화면 전환을 하지 않는 비동기 방식을 사용하기 위한 ajax 문 실행
	    $.ajax({
	        url: "isIdDuplicate.jsp",
	        type: "post",
	        data: { userId: id },
	        success: function(result) {
	            if (result.trim() === "0") {
	                $("#idDuplicateResult").html("✘");
	                $("#idDuplicateResult").css('color', 'red');
	                $("#isIdChecked").val("N");
	            } else {
	                $("#idDuplicateResult").html('✓');
	                $("#idDuplicateResult").css('color', 'green');
	                $("#idCheckButton").attr('disabled', true);
	                $("#isIdChecked").val("Y");
	            }
	        },
	        error: function() {
	            alert("서버 요청에 실패했습니다.");
	        }
	    });
	}

	//다음 API를 호출하는 함수
	function execDaumPostcode() {
		//다음에서 제공하는 API 가이드(https://postcode.map.daum.net/guide)를 참고하여 작성함.
        new daum.Postcode({
            oncomplete: function(data) {
            	document.getElementById("address").value = data.address;
            }
        }).open();
    }
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>