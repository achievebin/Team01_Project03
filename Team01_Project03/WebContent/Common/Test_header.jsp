<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더 영역</title>
<link href="${pageContext.request.contextPath}/Common/NewFile.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>

        
        
 <!-- ------------------------------------------------------------ -->
 <!-- --------------------------테스트------------------------------ -->
 <!-- ------------------------------------------------------------ -->
 <header>
 <nav class="navbar navbar-expand-lg headcolor">
  <div class="container-fluid">
<!--     <a class="navbar-brand" href="#"></a>
 -->    
   <img  class="navbar-brnad" href="#" src="LOL.png">
   
  <!-- -------------------------검색창------------------------------ -->  
      <form class="d-flex position-absolute top-50 start-50 translate-middle" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
  <!-- -----------------생성할 하위 페이지로 넘겨줄 구역------------------- -->
    <div class="position-absolute top-50 end-0 translate-middle-y">        
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse " id="navbarSupportedContent">
    
      <ul class="navbar-nav ">
        <li class="nav-item dropdown">
           <a class="nav-link active drodown-toggle" aria-current="page" href=""  id="navbarDropdown" 
          role="button" data-bs-toggle="dropdown" aria-expanded="false">안내</a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
      <li><a class="dropdown-item" href="#">소개</a></li>
      <li><a class="dropdown-item" href="#">연혁</a></li>
      
    </ul>
  </li>
</ul>
        <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link active drodown-toggle" aria-current="page" href=""  id="navbarDropdown" 
          role="button" data-bs-toggle="dropdown" aria-expanded="false">고객지원</a>
           <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
      <li><a class="dropdown-item" href="#">공지사항</a></li>
      <li><a class="dropdown-item" href="#">고객센터</a></li>
      
    </ul>
  </li>
</ul>
<ul class="navbar-nav">
       <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="">예약정보</a>
        </li>
        <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="">로그인</a>
        </li>
       
      </ul>
    </ul>
    </div>
    </div> 
  </div>
</nav>
</header>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
