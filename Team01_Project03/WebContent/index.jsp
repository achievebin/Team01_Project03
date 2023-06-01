<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>첫 화면</title>
<link href="./common/css/index.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="./common/header.jsp" />
<body>

<div class="wrapper">
	<!-- 대 배너 -->
	<div class="contents">
		<div class="main" id="main">
			<img src="./common/images/main.png"/>
		</div>
	</div>
	<!-- 중배너 -->
	<!-- 슬라이드 배너로 바꿀예정 -->
	<div class="sub">	
		<div class="banner">
			<div class="abanner"> 
				<img src="./common/images/t1.jpg"/>
				<img src="./common/images/t2.jpg"/>
			</div>
<!-- 			<div class="bbanner">
				
 			</div> -->
		</div>
	</div>
	<div class="sub">
	<!-- 숙소 종류별 버튼 -->
		<div class="actDivButton" align="center">
		   <button id="hotelButton" type="button" style="font-size: 1.4em;" onclick="location.href='./actPage/actList.jsp?actdiv=호텔%2C리조트';"><img width="250px" src="./common/images/hotelresort.png" /><br>호텔,리조트</button>
	       <button id="motelButton" type="button" style="font-size: 1.4em;" onclick="location.href='./actPage/actList.jsp?actdiv=모텔';"><img width="250px" src="./common/images/motel.png"/><br>모텔</button>
	       <button id="pensionButton" type="button" style="font-size: 1.4em;" onclick="location.href='./actPage/actList.jsp?actdiv=펜션';"><img width="250px" src="./common/images/pension.png"/><br>펜션</button>
	       <button id="guesthouseButton" type="button" style="font-size: 1.4em;" onclick="location.href='./actPage/actList.jsp?actdiv=게스트하우스';"><img width="250px" src="./common/images/guesthouse.png"/><br>게스트하우스</button>
		</div>
	</div>
</div>
</body>
<jsp:include page="./common/footer.jsp" />
</html>
