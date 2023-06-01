<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- css 정보 추가  -->
<link href="./css/find.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>아이디·비밀번호 찾기</title>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div class="wrapper">
		<div id="content">
				<script type="text/javascript" src="./js/checkForm.js"></script>
				<div id="radio">
					<div id="radio-ground">
						<input type="radio" name="index" id="tab1" value="findId" checked>
						<input type="radio" name="index" id="tab2" value="findPw">
					<!-- 탭 메뉴 -->
					<section class="buttons">
					<div>
						<label for="tab1">아이디 찾기</label>
						<label for="tab2">비밀번호 찾기</label>
					</div>	
					</section>
				<!-- 아이디 찾기 폼 -->
					<div id="findIdTabMenu">
						<form name="findMyIdForm" id="findMyIdForm" action="findMyIdProcess.jsp" method="post">
							<fieldset>
								<label>이름</label>
								<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="findIdName" id="findIdName"><br>
								<label>휴대폰번호</label>
								<input type="tel" maxlength="20" placeholder="010-1234-5678" name="findIdPhone" id="findIdPhone"><br>
								<input type="button" onclick="findMyIdFormCheck()" value="아이디 찾기">
							</fieldset>
						</form> <!-- findMyIdForm End -->
					</div> <!-- findIdTab End -->
				<!-- 비밀번호 찾기 폼 -->
					<div id="findPwdTabMenu">
						<form name="findMyPwdForm" id="findMyPwdForm" action="findMyPwdProcess.jsp" method="post">
							<fieldset>
								<label>이름</label>
								<input type="text" maxlength="12" placeholder="성과 이름을 기입" name="findPwdName" id="findPwdName"><br>
								<label>휴대폰번호</label>
								<input type="tel" maxlength="20" placeholder="010-1234-5678" name="findPwdPhone" id="findPwdPhone"><br>
								<label>아이디</label>
								<input type="text" maxlength="12" placeholder="아이디" name="findPwdId" id="findPwdId"><br>
								<input type="button" onclick="findMyPwdFormCheck()" value="비밀번호 찾기">
							</fieldset>
						</form>
					</div> <!-- findPwdTab End -->
				</div> <!-- radio End -->
			</div> <!-- radio-ground -->
		</div> <!-- content End -->
	</div> <!-- wrapper -->
<%@ include file="../common/footer.jsp" %>
</body>
</html>