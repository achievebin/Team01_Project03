<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History</title>
<link rel="stylesheet" type="text/css" href="history.css">
</head>
<body>
<%@include file="header.jsp" %>

<style>
.carousel-item img {
   max-height: 500px; /* 이미지 높이 조절 */
   margin: 0 auto; /* 중앙 정렬 */
}
</style>


<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="hotel1.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="hotel2.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="hotel3.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="hotel4.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

&nbsp;
&nbsp;





<div align="center">
	<img src="historyname.PNG" >
	<br>
		<!-- -------------------------동그라미 2022------------------------------ -->
		<div style="width: 100px; height: 100px; background-color: orange; border: 2px solid orange; border-radius: 50%; display: flex; justify-content: center; align-items: center; position: relative;">
		    <span style="color: white; font-size: 24px; font-weight: bold;">2022</span>
	<!-- ---------------------------세로 선---------------------------------- -->    
	    	<div style="width: 2px; height: 800px; background-color: orange; position: absolute; bottom: -800px; left: 50%; transform: translateX(-50%);"></div>
		</div>
</div>

<!-- -----------------------2022 활동 내역-------------------------------------- -->
<div style="display: flex; justify-content: space-between;">
  <div class="img-container">
    <img src="daewoologo.PNG">
  </div>
  <div class="text-container">
	  <div style="text-align: right;">
	    <span >    대우직업능력개발원 입원</span>
	  </div>
  </div>
</div>
  
<!-- -----------------------------동그라미 2023------------------------------------ --> 
<div align="center"> 
	  <div style="width: 100px; height: 100px; background-color: orange; border: 2px solid orange; border-radius: 50%; display: flex; justify-content: center; align-items: center; position: relative;">
	    <span style="color: white; font-size: 24px; font-weight: bold;">2023</span>
	  </div>
</div>
  
  <!-- ------------------------------1차 프로젝트----------------------------------- -->
<div style="display: flex; justify-content: space-between;">
  <div class="img-container">
    <img src="proj1.PNG">
  </div>
  <div class="text-container">
	  <div style="text-align: right;">
	    <span >1차 프로젝트<br>naver crawling<br>2023.02.20 ~ 03.03  </span>
	  </div>
  </div>
</div>

  <!-------------------------2차 프로젝트----------------------------------->
<div style="display: flex; justify-content: space-between;">
  <div class="img-container">
    <img src="proj2.PNG">
  </div>
  <div class="text-container">
	  <div style="text-align: right;">
	    <span >2차 프로젝트<br>SafeRoute<br>2023.04.16 ~ 05.05  </span>
	  </div>
  </div>
</div>

 
  <!-------------------------3차 프로젝트----------------------------------->
<div style="display: flex; justify-content: space-between;">
  <div class="img-container">
    <img src="proj3.PNG">
  </div>
  <div class="text-container">
	  <div style="text-align: right;">
	    <span >2차 프로젝트<br>SafeRoute<br>2023.04.16 ~ 05.05  </span>
	  </div>
  </div>
</div>

<%@include file="footer.jsp" %>
</body>
</html>
