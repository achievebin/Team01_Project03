<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸터 영역</title>
<style>
    #terms ul {
        list-style: none;
         background-color: #e0e0e0; /* 배경색을 검정색으로 지정 */
        color: white; /* 글자색을 흰색으로 지정 */
    }
    #contact ul {
        list-style: none;
    }
</style>
</head>
<body>

<footer>
<!-- 약관 등 내용이 들어갈 영역 -->
<div class="sticky-bottom">
	<div id = "terms" align="center" >
	
		<ul>
			<li><a href=>서비스이용약관</a></li>
			<li><a href="${pageContext.request.contextPath}/Common/htm/privacy.htm">개인정보 보호법</a></li>	
			<li><a href="${pageContext.request.contextPath}/Common/htm/ict.htm">정보통신망 이용법률</a></li>
			<li><a href="https://github.com/achievebin/Team01_Project03">개발 깃허브</a></li>	
		</ul>
	</div>
</div>
</footer>
</body>
</html>
