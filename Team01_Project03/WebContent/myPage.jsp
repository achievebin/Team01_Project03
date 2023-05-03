<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String myid = (String) session.getAttribute("signInId");
	if (myid == null) {
		response.sendRedirect("./signIn.jsp");
	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="./header.jsp"/>
	<section>
		<h2><%=myid %>님, 환영합니다.</h2>
		<h3>회원 등급은 Bronze입니다.</h3>
		<div>
			<a href="./withdraw.jsp">회원탈퇴</a>
		</div>
	</section>
	<aside>
		<ul>
			<li><a href="./updateInfo.jsp">회원정보수정</a></li>
			<li><a href="./myActivity.jsp">활동내역</a></li>
			<li><a href="./myReservation.jsp">예약정보</a></li>
			<li><a href="./bookmark.jsp">관심목록</a></li>
		</ul>
	</aside>
	<jsp:include page="./footer.jsp"/>
</body>
</html>