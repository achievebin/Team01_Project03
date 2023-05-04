<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<jsp:include page="./header.jsp"/>
	<span style="color: red; font-size: 1.2em;"> 
	        <%= request.getAttribute("joinErrMsg") == null ?
	                "" : request.getAttribute("joinErrMsg") %>
	</span>
	<h2>회원가입</h2>
	<form action="./joinProcess.jsp" method="post">
		<fieldset>
		<legend>신규 회원 정보</legend>
		<div>
		<label>아이디</label>
		<input type="text" placeholder="아이디를 입력해주세요" name="id" required>
		</div>
		<div>
		<label>비밀번호</label>
		<input type="password" placeholder="비밀번호를 입력해주세요" name="pw" required>
		</div>
		<div>
		<label>비밀번호 확인</label>
		<input type="password" placeholder="비밀번호 재입력하세요" name="pwCheck" required>
		</div>
		</fieldset>
		<fieldset>
		<legend>개인 정보</legend>
		<div>
		<label>이름</label>
		<input type="text" placeholder="성과 이름을 기입" name="name" required>
		</div>
		<div>
		<label>생년월일</label>
		<input type="date" name="birth" required>
		</div>
		<div>
		<label>성별</label>
		<input type="radio" name="sex" value="m">남자
		<input type="radio" name="sex" value="f">여자
		</div>
		<div>
		<label>주소</label>
		<input type="text" name="address">
		</div>
		<div>
		<label>휴대폰번호</label>
		<!-- <select name="mobileCarrier">
		<option>SKT</option>
		<option>KT</option>
		<option>LG</option>
		</select> -->
		<input type="tel" placeholder="010-1234-5678" name="phone" required>
		</div>
		<div>
		<label>e-mail</label>
		<input type="email" placeholder="example@example.org" name="email" required>
		</div>
		</fieldset>
		<input type="submit" value="가입하기">
		<input type="button" value="돌아가기" onclick="location.href='index.jsp';">
	</form>
	<jsp:include page="./footer.jsp"/>
</body>
</html>