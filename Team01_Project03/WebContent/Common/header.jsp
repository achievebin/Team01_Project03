<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더 영역</title>
</head>
<body>
<header>
<!-- 웹 사이트 이미지가 삽입될 구역 -->
<div id="sitename">
	<h1>이미지 대용</h1>
</div>
<!-- 검색창이 들어갈 구역 -->

<div id="search">
	<%@ include file="../search.jsp" %>
</div>
<!-- 생성할 하위 페이지로 넘겨줄 구역 -->
<nav>
	<ul>
		<li>안내
			<ul>
				<li><a href="../introduce.jsp">소개</a></li>
				<li><a href="../history.jsp">연혁</a></li>
			</ul>
		</li>
		<li><a href="../myReservation.jsp">예약정보</a></li>
		<li>고객지원
			<ul>
				<li><a href="${pageContext.request.contextPath}/Notice/NoticeList.jsp">공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/CustomerService.jsp">고객센터</a></li>
			</ul>
		</li>
	</ul>
</nav>
<!-- 로그인 여부에 따라 달라질 구역 -->
<div id="account">
	<!-- 로그인 여부에 따른 메뉴 변화 -->
        <% if (session.getAttribute("signInId") == null) { %>
            <a href="${pageContext.request.contextPath}/signIn.jsp">로그인</a>
        <% } else { %>
        	<%= session.getAttribute("signInId") %>
        	<ul>
        		<li><a href="${pageContext.request.contextPath}/myPageProcess.jsp">내 페이지</a></li>
        		<li><a href="${pageContext.request.contextPath}/signOut.jsp">로그아웃</a></li>
            </ul>
        <% } %>
</div>
</header>
</body>
</html>