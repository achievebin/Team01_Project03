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
	<!-- 슬라이드 배너로 바꿀예정 -->
	<div class="banner">	
		<div class="sbanner">
			<div class="abanner"> 
				<img src="./images/hotel1.jpg"/>
			</div>
			<div class="abanner">
				<img src="./images/hotel2.jpg"/>
 			</div>
		</div>
	</div>
	<div class="banner">
	<!-- 숙소 종류별 버튼 -->
		<div class="actDivButton" align="center">
		   <button id="hotelButton" type="button" onclick="location.href='../actPage/actList.jsp?actdiv=호텔%2C리조트';"><img width="250px" src="./images/hotelresort.png"/></button>
	       <button id="motelButton" type="button" onclick="location.href='../actPage/actList.jsp?actdiv=모텔';"><img width="250px" src="./images/motel.png"/></button>
	       <button id="pensionButton" type="button" onclick="location.href='../actPage/actList.jsp?actdiv=펜션';"><img width="250px" src="./images/pension.png"/></button>
	       <button id="guesthouseButton" type="button" onclick="location.href='../actPage/actList.jsp?actdiv=게스트하우스';"><img width="250px" src="./images/guesthouse.png"/></button>
		</div>
	</div>
</div>
</body>
<jsp:include page="/common/footer.jsp" />
</html>
