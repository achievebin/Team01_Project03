<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="./header.jsp"/>

<style>
  .tab_menu{position:relative;}
  .tab_menu .list{overflow:hidden;}
  .tab_menu .list li{float:left;}
  .tab_menu .list .btn{font-size:13px; margin-right:14px;}
  .tab_menu .list .cont{display:none; position:absolute; background:#555; color:#fff; text-align:center; width:250px; height:100px; line-height:100px;}
  .tab_menu .list li.is_on .btn{font-weight:bold; color:green;}
  .tab_menu .list li.is_on .cont{display:block;}
</style>


<!-- 숙소 데이터 들어갈곳 -->


<div class="tab_menu">
  <ul class="list">
    <li class="is_on">
      <a href="#tab1" class="btn">Tab Button1</a>
      <div id="tab1" class="cont">Tab Content1</div>
    </li>
    <li>
      <a href="#tab2" class="btn">Tab Button2</a>
      <div id="tab2" class="cont">Tab Content2</div>
    </li>
    <li>
      <a href="#tab3" class="btn">Tab Button3</a>
      <div id="tab3" class="cont">Tab Content3</div>
    </li>
  </ul>
</div>

<jsp:include page="./footer.jsp"/>
</body>
</html>