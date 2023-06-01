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
				<input type="hidden" name="prevId" value=<%=yourId %> readonly>
				<input type="hidden" name="prevPw" value=<%=yourPw %> readonly>
				<input type="hidden" name="prevName" value=<%=yourName %> readonly>
				<input type="hidden" name="prevNickname" value=<%=yourNickname %> readonly>
				<input type="hidden" name="prevBirth" value=<%=yourBirth %> readonly>
				<input type="hidden" name="prevSex" value=<%=yourSex %>>
				<input type="hidden" name="prevAddress" value=<%=yourAddress %> readonly>
				<input type="hidden" name="prevPhone" value=<%=yourPhone %> readonly>
				<input type="hidden" name="prevEmail" value=<%=yourEmail %> readonly>
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
