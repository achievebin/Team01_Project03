<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- css 연결 -->
<link href="./css/joinB.css" rel="stylesheet" type="text/css">
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
	<div id="join">
	<h2>회원가입</h2>
	<form name="joinForm" id="joinForm" action="./joinProcess.jsp" method="post">
	
	<table id="joinTable">
		<tr ><td colspan = '2'>신규 회원 정보</td></tr>
			
			<tr>
				<td><label>아이디</label></td>
				<td><input type="text" maxlength="12" placeholder="아이디" name="id" id="id">
				<input type="button" value="중복확인"></td>
			</tr>
			<tr>
				<td><label>비밀번호</label></td>
				<td><input type="password" maxlength="12" placeholder="비밀번호 입력" name="pw" id="pw"></td>
			</tr>
			<tr>
				<td><label>비밀번호 확인</label></td>
				<td><input type="password" maxlength="12" placeholder="비밀번호 재입력" name="pwCheck" id="pwCheck"></td>
			</tr>
		
		
			<tr><td colspan = '2'>개인 정보</td></tr>
			
			<tr>
				<td><label>이름</label></td>
				<td><input type="text" maxlength="12" placeholder="성과 이름을 기입" name="name" id="name"></td>
			</tr>
			<tr>
				<td><label>닉네임</label></td>
				<td><input type="text" maxlength="48" placeholder="닉네임을 기입" name="nickname" id="nickname"></td>
			</tr>
			<tr>
				<td><label>생년월일</label></td>
				<td><input type="date" name="birth" id="birth"></td>
			</tr>
			<tr>
				<td><label>성별</label></td>
				<td><input type="radio" name="sex" value="male">남자
				<input type="radio" name="sex" value="female">여자
				<input type="radio" name="sex" value="none" checked>선택 안 함</td>
			</tr>
			<tr>
				<td><label>주소</label></td>
				<td><input type="text" maxlength="50" name="address" id="address"></td>
			</tr>
			<tr>
				<td><label>휴대폰번호</label></td>
				<td><input type="tel" maxlength="20" placeholder="010-1234-5678" name="phone" id="phone"></td>
			</tr>
			<tr>
				<td><label>e-mail</label></td>
				<td><input type="email" maxlength="40" placeholder="example@example.org" name="email" id="email"></td>
			</tr>
			<tr>
				<td colspan = '2'><input type="button" value="가입하기" onclick="joinFormCheck()">
				<input type="button" value="돌아가기" onclick="history.back()"></td>
			</tr>
		</table>
	</form>
	 <%@ include file="../common/footer.jsp" %>
	</div>
</body>
</html>
