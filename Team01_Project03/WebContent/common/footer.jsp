<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸터 영역</title>
<link href="${pageContext.request.contextPath}/common/css/footer.css" rel="stylesheet" type="text/css" />
</head>
<body>

<footer>
<!-- 약관 등 내용이 들어갈 영역 -->
<!-- <div class="wrapper"> -->
	<div class="bottom">
		<div id="to-top">
			<ul>
	          <li>
	            <a href="#" onclick="scrollToTop()" target="_self">
	              <img id="scrollToTop" src="${pageContext.request.contextPath}/common/images/up.png" height="45" width="40">
	            </a>
	          </li>
	        </ul>
	    </div>  
		<div id = "info" align="center" >
			<ul>
				<li><a href=>서비스이용약관</a></li>
				<li><a href="${pageContext.request.contextPath}/common/htm/privacy.htm">개인정보 보호법</a></li>	
				<li><a href="${pageContext.request.contextPath}/common/htm/ict.htm">정보통신망 이용법률</a></li>
				<li><a href="https://github.com/achievebin/Team01_Project03">개발 깃허브</a></li>	
			</ul>
		</div>
	
	</div>
<!-- </div> -->
</footer>
<script>
  document.getElementById('to-top').addEventListener('click', function () {
    window.scrollTo({top: 0, behavior: 'smooth'});
  });
</script>
</body>
</html>
