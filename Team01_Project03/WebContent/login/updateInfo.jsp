<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page import="member.MemberDto"%>
<%@ page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String changeId = request.getParameter("prevId");
String changePw = request.getParameter("prevPw");
String changeName = request.getParameter("prevName");
String changeNickname = request.getParameter("prevNickname");
//https://stackoverflow.com/questions/21575253/classcastexception-java-util-date-cannot-be-cast-to-java-sql-date
DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utildate = formatter.parse(request.getParameter("prevBirth"));
java.sql.Date changeBirth = new java.sql.Date(utildate.getTime());
String changeSex = request.getParameter("prevSex");
String changeAddress = request.getParameter("prevAddress");
String changePhone = request.getParameter("prevPhone");
String changeEmail = request.getParameter("prevEmail");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link href="./css/join.css" rel="stylesheet" type="text/css">
</head>
<body>
	<script type="text/javascript" src="./js/checkForm.js"></script>
	<jsp:include page="/common/header.jsp" />
	<span style="color: red; font-size: 1.2em;"> 
		        <%= request.getAttribute("updateInfoErrMsg") == null ?
		                "" : request.getAttribute("updateInfoErrMsg") %>
		</span>
	<div id="formbox">
		<form name="updateInfoForm" id="updateInfoForm" action="./updateInfoProcess.jsp" method="post">
				<fieldset class="fs" id="idpwfs">
					<legend>내 회원 정보</legend>
					<div class="my-input" id="idDiv">
						<label for="newId">아이디</label><br>
						<input type="text" name="newId" id="newId" value=<%=changeId %> readonly>
					</div>
					<div class="my-input" id="oldPwDiv">
						<label for="newPw">기존 비밀번호</label><br>
						<input type="password" name="oldPw" id="oldPw" value=<%=changePw %>><br>
						<br><span class="errMsg" id="pwErrMsg"></span>
					</div>
					<div class="my-input" id="newPwDiv">
						<label for="newPw">새 비밀번호</label><br>
						<input type="password" name="newPw" id="newPw"><br>
						<br><span class="errMsg" id="pwErrMsg"></span>
					</div>
					<div class="my-input" id="newPwCheckDiv">
						<label for="newPw">새 비밀번호 확인</label><br>
						<input type="password" name="newPwCheck" id="newPwCheck"><br>
						<br><span class="errMsg" id="pwErrMsg"></span>
					</div>
				</fieldset> <!-- first fieldset end -->
				<fieldset class="fs" id="privacyfs">
					<legend>내 개인 정보</legend>
					<div class="my-input" id="nameDiv">
						<label for="newName">이름</label><br>
						<input type="text" name="newName" id="newName" value=<%=changeName %>>
						<br><span class="errMsg" id="nameErrMsg"></span>
					</div>
					<div class="my-input" id="nicknameDiv">
						<label for="newNickname">닉네임</label><br>
						<input type="text" name="newNickname" id="newNickname" value=<%=changeNickname %>>
						<br><span class="errMsg" id="nicknameErrMsg"></span>
					</div>
					<div class="my-input" id="birthDiv">
						<label for="newBirth">생년월일</label><br>
						<input type="date" name="newBirth" id="newBirth" value=<%=changeBirth %> required>
						<br><span class="errMsg" id="birthErrMsg"></span>
					</div>
					<div class="my-input" id="sexDiv">
						<label>성별<br>
						<% if (changeSex.equals("male")) {%>
						<input type="radio" name="newSex" value="male" checked>남자
						<input type="radio" name="newSex" value="female">여자
						<input type="radio" name="newSex" value="none">선택 안 함
						<%} else if (changeSex.equals("female")) {%>
						<input type="radio" name="newSex" value="male">남자
						<input type="radio" name="newSex" value="female" checked>여자
						<input type="radio" name="newSex" value="none">선택 안 함
						<%} else {%>
						<input type="radio" name="newSex" value="male">남자
						<input type="radio" name="newSex" value="female">여자
						<input type="radio" name="newSex" value="none" checked>선택 안 함
						<%} %>
						</label>
						<br><span class="errMsg" id="sexErrMsg"></span>
					</div>
					<div class="my-input" id="addressDiv">
						<label for="newAddressh">주소</label><br>
						<input type="text" name="newAddress" id="newAddress" value=<%=changeAddress %> onclick="execDaumPostcode()">
						<br><span class="errMsg" id="addressErrMsg"></span>
					</div>
					<div class="my-input" id="phoneDiv">
						<label for="newPhone">휴대폰번호</label><br>
						<input type="tel" name="newPhone" id="newPhone" value=<%=changePhone %>>
						<br><span class="errMsg" id="phoneErrMsg"></span>
					</div>
					<div class="my-input" id="emailDiv">
						<label for="newEmail">e-mail</label><br>
						<input type="email" name="newEmail" id="newEmail" value=<%=changeEmail %>>
						<br><span class="errMsg" id="emailErrMsg"></span>
					</div>
				</fieldset> <!-- second fieldset end -->
				<div id="buttons">
					<input class="my-button" type="button" value="회원수정" onclick="updateInfoFormCheck()">
					<input class="my-button" type="button" value="돌아가기" onclick="history.back()">
				</div>
			</form>
		</div>
		<jsp:include page="/common/footer.jsp" />
		<!-- 다음 주소 API 사용을 위한 CDN 삽입 -->
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		//다음 API를 호출하는 함수
		function execDaumPostcode() {
			//다음에서 제공하는 API 가이드(https://postcode.map.daum.net/guide)를 참고하여 작성함.
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	document.getElementById("newAddress").value = data.address;
	            }
	        }).open();
	    }
		</script>
</body>
</html>