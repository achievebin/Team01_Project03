<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>첫 화면</title>
<link href="./css/index.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="/common/header.jsp" />
<body>

<div class="wrapper">
	<!-- 대 배너 -->
	<div class="contents">
		<div class="main" id="main">
			<img src="./images/main.png"/>
		</div>
	</div>
	<!-- 중배너 -->
	<div class="banner">	
		<div class="sbanner">
			<div class="abanner"> 
				<img src="./images/main.png"/>
			</div>
			<div class="abanner">
				<img src="./images/main.png"/>
 			</div>
		</div>
	</div>
	<!-- 숙소 종류별 버튼 -->
	   <button type="button" onclick="location.href='../actPage/actList.jsp?actdiv=호텔%2C리조트';">호텔,리조트</button>
       <button type="button" onclick="location.href='../actPage/actList.jsp?actdiv=모텔';">모텔</button>
       <button type="button" onclick="location.href='../actPage/actList.jsp?actdiv=펜션';">펜션</button>
       <button type="button" onclick="location.href='../actPage/actList.jsp?actdiv=게스트하우스';">게스트하우스</button>
</div>
</body>
<jsp:include page="/common/footer.jsp" />
</html>
