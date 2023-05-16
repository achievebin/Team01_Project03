<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<style>
  .video-container {
    display: flex;
    justify-content: center;
  }
  .video-group {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 20px;
  }
  .video-title {
    margin-bottom: 10px;
  }
</style>
<body>
<img src="introduce.png" width=100%/>

 <!-- -------------------------------목차 목록-------------------------------- -->

<div class="margin-space"></div>

<div style="text-align:center;">
<div class="btn-group ">
  <a href="#member" class="btn btn-primary active border-white" aria-current="page"
     style="background-color:orange; color:white; border-color:orange;">팀원소개</a>
 
  <a href="#project" class="btn btn-primary active border-white" aria-current="page"
     style="background-color:orange; color:white; border-color:orange;">프로젝트 소개</a>
</div>
</div>

<div class="margin-space"></div>

<!---------------------------우측 이동식 배너------------------------------->

 <div class="list-group list-set center">
  <a href="#member" class="list-group-item list-group-item-action">팀원소개</a>
  <a href="#project" class="list-group-item list-group-item-action">프로젝트소개</a>
  </div>

<!-- ------------------------------팀원 소개---------------------------------- -->
 <h3 class="center" id="member">팀원 소개</h3>

<div class="margin-space"></div>

  <div class="row">
  		<div class="col-lg-2">
  		<div class="card" style="width: 11rem;">
  <img src="blank.png" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">김도욱</h5>
    <p class="card-text">역할</p>
  
  </div>
</div>
</div>

  		<div class="col-lg-2">
  		<div class="card" style="width: 11rem;">
  <img src="blank.png" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">이성혁</h5>
    <p class="card-text">역할</p>
   
  </div>
</div>
  		</div>
  		
  		<div class="col-lg-2">
  		<div class="card" style="width: 11rem;">
  <img src="blank.png" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">강성빈</h5>
    <p class="card-text">역할</p>
   
  </div>
</div>
  		</div>
  		<div class="col-lg-2" >
  		<div class="card" style="width: 11rem;">
  <img src="blank.png" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">김재현</h5>
    <p class="card-text">역할</p>
   
  </div>
</div>
</div>
  		
  		<div class="col-lg-2">
  		<div class="card" style="width: 11rem;">
  <img src="blank.png" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">김성원</h5>
    <p class="card-text">역할</p>
   
  </div>
</div>
  		
  		</div>
  </div>
  
  <div class="margin-space"></div>
  
  <hr>
  
     <!-- -----------------------------프로젝트 소개--------------------------------- -->
  <div class="margin-space"></div>
  
  <h3 class="center" id="project">프로젝트 소개</h3>
  
  <div class="margin-space"></div>
  
  <div class="center">
  <h4>&lt;1차 프로젝트&gt;</h4>
  </div>


<div class="video-container">
  <div class="video-group">
    <h3 class="video-title">발표영상</h3>
    <video src="Project01_introduction.mp4" width="320" height="240" controls></video>
  </div>

  <div class="video-group">
    <h3 class="video-title">시연영상</h3>
    <video src="Project01_play.mp4" width="320" height="240" controls></video>
  </div>
</div>

<div class="center">
	    <p>제목:Naver Crawling</p>
	           <p>사용 언어:python</p>
	           <p>프로젝트 설명:</p>
	           <p>찾고자 뉴스의 관련 단어를 검색하면 그 단어가 들어간 뉴스를 crawling을 해 받아온다</p>
	     <br>
</div>

<div class="video-container">
  <div class="video-group">
    <h3 class="video-title">발표영상</h3>
    <video src="Team01_Project02_발표.mp4" width="320" height="240" controls></video>
  </div>

  <div class="video-group">
    <h3 class="video-title">시연영상</h3>
    <video src="Team01_Project02_시연.mp4" width="320" height="240" controls></video>
  </div>
</div>
	        <div class="center">
	    <p>제목:코로나 19로 부터 안전한 여행 정보 제공 프로그램</p>
	           <p>사용 언어:python</p>
	           <p>프로젝트 설명:</p>
	           <p>UI를 이용하여 국내 여행에 관심을 갖고 있는 사람들에게 성별 연령별로 선호하는 지역 정보를 제공하고<br>테마별로 선호하는 스타일의 여행정보를 제공</p>
	  
	  	     <br>
 </div>
<body>

</body>
</html>