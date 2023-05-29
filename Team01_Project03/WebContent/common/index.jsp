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
</div>
</body>
<jsp:include page="/common/footer.jsp" />
</html>
