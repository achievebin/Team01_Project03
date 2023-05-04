<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String yourId = (String)request.getAttribute("mypageId");
String yourPw = (String)request.getAttribute("mypagePw");
String yourName = (String)request.getAttribute("mypageName");
Date yourBirth = (Date)request.getAttribute("mypageBirth");
String yourSex = (String)request.getAttribute("mypageSex");
String yourAddress = (String)request.getAttribute("mypageAddress");
String yourPhone = (String)request.getAttribute("mypagePhone");
String yourEmail = (String)request.getAttribute("mypageEmail");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="./header.jsp"/>
	<section>
		<h2> <%=yourId %>님, 환영합니다.</h2>
		<h3>회원 등급은 Bronze입니다.</h3>
		<form action="./updateInfo.jsp" method="post">
		<fieldset>
		<legend>내 회원 정보</legend>
		<div>
		<label>아이디</label>
		<input type="text" name="id" value=<%=yourId %> readonly>
		</div>
		<div>
		<label>비밀번호</label>
		<input type="password" name="pw" value=<%=yourPw %> readonly>
		</div>
		</fieldset>
		<fieldset>
		<legend>내 개인 정보</legend>
		<div>
		<label>이름</label>
		<input type="text" name="name" value=<%=yourName %> readonly>
		</div>
		<div>
		<label>생년월일</label>
		<input type="date" name="birth" value=<%=yourBirth %> readonly>
		</div>
		<div>
		<label>성별</label>
		<% if (yourSex.equals("m")) {%>
		<input type="radio" name="sex" value="m" checked readonly onclick="return false">남자
		<input type="radio" name="sex" value="f" readonly onclick="return false">여자
		<%} else if (yourSex.equals("f")) {%>
		<input type="radio" name="sex" value="m" readonly onclick="return false">남자
		<input type="radio" name="sex" value="f" checked readonly onclick="return false">여자
		<%} else {%>
		<input type="radio" name="sex" value="m" readonly onclick="return false">남자
		<input type="radio" name="sex" value="f" readonly onclick="return false">여자
		<%} %>
		</div>
		<div>
		<label>주소</label>
		<input type="text" name="address" value=<%=yourAddress %> readonly>
		</div>
		<div>
		<label>휴대폰번호</label>
		<input type="tel" name="phone" value=<%=yourPhone %> readonly>
		</div>
		<div>
		<label>e-mail</label>
		<input type="email" name="email" value=<%=yourEmail %> readonly>
		</div>
		</fieldset>
		<input type="submit" value="회원수정">
		<input type="button" value="회원탈퇴" onclick="location.href='withdraw.jsp';">
	</form>
	</section>
	<aside>
		<ul>
			<li><a href="./myActivity.jsp">활동내역</a></li>
			<li><a href="./myReservation.jsp">예약정보</a></li>
			<li><a href="./bookmark.jsp">관심목록</a></li>
		</ul>
	</aside>
	<jsp:include page="./footer.jsp"/>
</body>
</html>