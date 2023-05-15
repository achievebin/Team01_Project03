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
<div id = "terms" align="center" >

	<ul>
		<li><a href=>서비스이용약관</a></li>
		<li><a href="${pageContext.request.contextPath}/Common/privacy.htm">개인정보 보호법</a></li>	
		<li><a href="${pageContext.request.contextPath}/Common/ict.htm">정보통신망 이용법률</a></li>
	</ul>
</div>
<!-- 사이트 정보가 들어갈 영역 -->
<div id = "contact" align="center" >
	<ul>
		<li><a href="https://github.com/achievebin/Team01_Project03">개발 깃허브</a></li>	
	</ul>
</div>
</footer>
</body>
</html>
