<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더 영역</title>
<link href="${pageContext.request.contextPath}/Common/header.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg headcolor">
			<div class="container-fluid"> <!-- first start -->
				<a href="../Common/index.jsp">
					<img class="navbar-brnad" src="../Common/logo.png" alt="로고">
				</a>
			 	<!-- -------------------------검색창------------------------------ -->  
				<%@ include file="../common/search.jsp" %>
				<!-- -----------------생성할 하위 페이지로 넘겨줄 구역------------------- -->
				<div class="position-absolute top-50 end-0 translate-middle-y"> <!-- second start -->       
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse " id="navbarSupportedContent"> 
						<ul class="navbar-nav ">
							<li class="nav-item dropdown">
								<a class="nav-link active drodown-toggle" aria-current="page" href=""  id="navbarDropdown" 
									          role="button" data-bs-toggle="dropdown" aria-expanded="false">안내</a>
								<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
									<li><a class="dropdown-item" href="../Common/introduce.jsp">소개</a></li>
									<li><a class="dropdown-item" href="../Common/history.jsp">연혁</a></li>  
								</ul>
							</li>
						</ul>
						<ul class="navbar-nav">
							<li class="nav-item dropdown">
							<a class="nav-link active drodown-toggle" aria-current="page" href=""  id="navbarDropdown" 
								          role="button" data-bs-toggle="dropdown" aria-expanded="false">고객지원</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="../Notice/NoticeList.jsp">공지사항</a></li>
								<li><a class="dropdown-item" href="../QnA/QnaList.jsp">고객센터</a></li>  
							</ul>
							</li>
						</ul>
						<ul class="navbar-nav">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="../ActPage/ActList.jsp">숙소목록</a>
							</li>
						</ul>
						<ul class="navbar-nav">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="../ActPage/myReservation.jsp">예약정보</a>
							</li>
						</ul>
						<% if (session.getAttribute("signInId") == null) { %>
						<ul class="navbar-nav">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="../Login/signIn.jsp">로그인</a>
							</li>
						</ul>
				        <% } else { %>
				        <ul class="navbar-nav">
							<li class="nav-item dropdown">
							<a class="nav-link active drodown-toggle" aria-current="page" href=""  id="navbarDropdown" 
								          role="button" data-bs-toggle="dropdown" aria-expanded="false"><%= session.getAttribute("signInId") %></a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><%= session.getAttribute("signInNickname") %>님 환영합니다.<li>
								<li><%= session.getAttribute("signInGrade") %><li>
								<li><a class="dropdown-item" href="../Login/myPage.jsp">내 페이지</a></li>
								<li><a class="dropdown-item" href="../Login/signOut.jsp">로그아웃</a></li>  
							</ul>
							</li>
						</ul>
				        <% } %>
					</div>
				</div> <!-- second start -->
			</div> <!-- first end -->
		</nav>
	</header>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
