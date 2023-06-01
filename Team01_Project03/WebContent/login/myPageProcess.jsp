<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String yourId = (String)request.getAttribute("mypageId");
String yourPw = (String)request.getAttribute("mypagePw");
String yourName = (String)request.getAttribute("mypageName");
String yourNickname = (String)request.getAttribute("mypageNickname");
Date yourBirth = (Date)request.getAttribute("mypageBirth");
String yourSex = (String)request.getAttribute("mypageSex");
String yourAddress = (String)request.getAttribute("mypageAddress");
String yourPhone = (String)request.getAttribute("mypagePhone");
String yourEmail = (String)request.getAttribute("mypageEmail");
String yourGrade = (String)request.getAttribute("mypageGrade");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이지</title>
<link href="./css/myPage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div class="wrapper">
		<section>
			<h2><%=yourNickname %>님, 환영합니다.</h2>
			<h3>회원 등급은 <%=yourGrade%>입니다.</h3>
			<form name="myPageForm" action="./updateInfo.jsp" method="post">
				<fieldset>
					<legend>내 회원 정보</legend>
					<div>
						<label>아이디</label>
						<input type="text" name="prevId" value=<%=yourId %> readonly>
					</div>
					<div>
						<label>비밀번호</label>
						<input type="text" name="prevPw" value=<%=yourPw %> readonly>
					</div>
				</fieldset> <!-- first fieldset end -->
				<fieldset>
					<legend>내 개인 정보</legend>
					<div>
						<label>이름</label>
						<input type="text" name="prevName" value=<%=yourName %> readonly>
					</div>
					<div>
						<label>닉네임</label>
						<input type="text" name="prevNickname" value=<%=yourNickname %> readonly>
					</div>
					<div>
						<label>생년월일</label>
						<input type="date" name="prevBirth" value=<%=yourBirth %> readonly>
					</div>
					<div>
						<label>성별</label>
						<% if (yourSex.equals("male")) {%>
						<input type="radio" name="prevSex" value="male" checked readonly onclick="return false">남자
						<input type="radio" name="prevSex" value="female" readonly onclick="return false">여자
						<input type="radio" name="prevSex" value="none" readonly onclick="return false">선택 안 함
						<%} else if (yourSex.equals("female")) {%>
						<input type="radio" name="prevSex" value="male" readonly onclick="return false">남자
						<input type="radio" name="prevSex" value="female" checked readonly onclick="return false">여자
						<input type="radio" name="prevSex" value="none" readonly onclick="return false">선택 안 함
						<%} else {%>
						<input type="radio" name="prevSex" value="male" readonly onclick="return false">남자
						<input type="radio" name="prevSex" value="female" readonly onclick="return false">여자
						<input type="radio" name="prevSex" value="none" checked readonly onclick="return false">선택 안 함
						<%} %>
					</div>
					<div>
						<label>주소</label>
						<input type="text" name="prevAddress" value=<%=yourAddress %> readonly>
					</div>
					<div>
						<label>휴대폰번호</label>
						<input type="tel" name="prevPhone" value=<%=yourPhone %> readonly>
					</div>
					<div>
						<label>e-mail</label>
						<input type="email" name="prevEmail" value=<%=yourEmail %> readonly>
					</div>
				</fieldset> <!-- second fieldset end -->
				<input type="submit" value="회원수정">
				<input type="button" value="회원탈퇴" onclick="location.href='withdraw.jsp';">
			</form>
		</section>
		<aside>
			<ul>
				<li><a href="../revPage/myReview.jsp">활동내역</a></li>
				<li><a href="../resPage/myReservation.jsp">예약정보</a></li>
				<li><a href="../bmPage/bookMark.jsp">관심목록</a></li>
			</ul>
		</aside>
	</div>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
