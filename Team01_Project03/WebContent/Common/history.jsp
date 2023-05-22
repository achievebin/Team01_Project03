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

<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="" class="d-block w-90" alt="...">
    </div>
    <div class="carousel-item">
      <img src="" class="d-block w-90" alt="...">
    </div>
    <div class="carousel-item">
      <img src="" class="d-block w-90" alt="...">
    </div>
    <div class="carousel-item">
      <img src="" class="d-block w-90" alt="...">
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

<div align="center">
<h2>연혁</h2>
<br>
<!-- -------------------------동그라미 2022------------------------------ -->
<div style="width: 100px; height: 100px; background-color: orange; border: 2px solid orange; border-radius: 50%; display: flex; justify-content: center; align-items: center; position: relative;">
    <span style="color: white; font-size: 24px; font-weight: bold;">2022</span>
<!-- ---------------------------세로 선---------------------------------- -->    
    <div style="width: 2px; height: 800px; background-color: orange; position: absolute; bottom: -800px; left: 50%; transform: translateX(-50%);"></div>
	</div>
</div>

<!-- -----------------------2022 활동 내역-------------------------------------- -->
<div class="leftward-move-container " align="center" style="display: flex; justify-content: center;">
  <div class="img-container">
    <img src="dwlogo.PNG">
    <p>대우 직업 능력 개발원 입원</p>
  </div>
</div>
  
<!-- -----------------------------동그라미 2023----------------------------------------------- --> 
<div align="center"> 
	  <div style="width: 100px; height: 100px; background-color: orange; border: 2px solid orange; border-radius: 50%; display: flex; justify-content: center; align-items: center; position: relative;">
	    <span style="color: white; font-size: 24px; font-weight: bold;">2023</span>
	  </div>
</div>
  
  <!-- ------------------------------1차 프로젝트----------------------------------- -->
 <!-- <div align="center" style="display: flex; justify-content: center;" >
	  <div align="center" style="display: flex;">
		  <div class="img-container">
		    <img src="proj1logo.PNG">
		    <p>1차 프로젝트<br>Naver Crawling<br>2023.02.20 ~ 03.03  </p>
		  </div>
	</div>
</div>


   -------------------------2차 프로젝트-----------------------------------
<div align="center" style="display: flex; justify-content: center;" >
	  <div class="img-container">
	    <img src="proj2logo.PNG">
	    <p>2차 프로젝트<br>SafeRoute<br>2023.04.16 ~ 05.05  </p>
	  </div>
</div>

 
   -------------------------3차 프로젝트-----------------------------------
<div align="center" style="display: flex; justify-content: center;" >
	  <div class="img-container">
	    <img src="proj3.PNG">
	    <p>3차 프로젝트<br>숙박시설 프로그램<br>2023.04.17 ~ 05.12  </p>
	  </div>
</div> -->
<div style="display: flex; justify-content: space-between;">
  <div class="img-container">
    <img src="proj3.PNG">
  </div>
  <div style="text-align: right;">
    <span class="text-container">안녕하세요</span>
  </div>
</div>



<div align="center" style="display: flex; " >
	<div class="img-container">
	<img src="proj1logo.PNG">
	</div>
</div>

<div align="center" style="display: flex; " >
	<div class="img-container">
	<img src="proj1logo.PNG">
	</div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>
