<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%> <!--로그인 확인-->
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<!-- 타이틀 -->
<title>숙소목록</title>

<!-- 폼 예외처리 -->
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
	let regPhone = /([0-9]{2,4})-?([0-9]{3,4})-?([0-9]{4})$/;
	let regPrice = /([0-9])$/;
	
    if (form.act_name.value == "") {
        alert("제목을 입력하세요.");
        form.act_name.focus();
        return false;
    }
    if (form.act_info.value == "") {
        alert("내용을 입력하세요.");
        form.act_info.focus();
        return false;
    }
    
    if (form.act_phone.value == "") {
        alert("전화번호를 입력하세요.");
        form.act_phone.focus();
        return false;
    }
    
	if (regPhone.test(form.act_phone.value) == false) {
		alert("잘못된 형식의 전화번호입니다.");
		form.act_phone.focus();
		return false;
		}
    
    if (form.act_address.value == "") {
        alert("주소를 입력하세요.");
        form.act_address.focus();
        return false;
    }
    
    if (form.act_price.value == "") {
        alert("가격을 입력하세요.");
        form.act_price.focus();
        return false;
    }
	if (regPrice.test(form.act_price.value) == false) {
		alert("잘못된 형식의 가격입니다.");
		form.act_price.focus();
		return false;
		}
    
}
</script>
<!-- 폼 예외처리 끝 -->

<!-- css 연결 -->
<link href="./css/actcss.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>	

<div id="actWrite">
<h2>숙소목록 - 글쓰기(Write)</h2>

<!-- 숙소 작성 폼 -->
<form name="ActwriteFrm" method="post" action="actWriteProcess.jsp"
      onsubmit="return validateForm(this);">
    <table border="1" style="width:90%" id="actWriteTable">
        <tr>
        <!-- 숙소명 입력 -->
            <td>숙소명</td>
            <td>
                <input type="text" name="act_name" style="width: 90%;" />
            </td>
        </tr>
        <tr>
        <!-- 숙소정보 입력 -->
            <td>숙소정보</td>
            <td>
                <textarea name="act_info" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
        <!-- 숙소 전화번호 입력 -->
            <td>숙소 전화번호</td>
            <td>
                <input type="text" name="act_phone" style="width: 90%;" />
            </td>
        </tr>
         <tr>
         <!-- 숙소 주소 입력 -->
            <td>숙소 주소</td>
            <td>
                <input type="text" name="act_address" style="width: 90%;" />
            </td>
        </tr>
         <tr>
         <!-- 숙소 가격 입력 -->
            <td>숙소 가격</td>
            <td>
                <input type="text" name="act_price" style="width: 90%;" />
            </td>
        </tr>
        <tr>
                <!-- 숙소 객실수 입력 -->
            <td>숙소 총 객실수</td>
            <td>
                <select name="act_room">
               	 	<option value=1>1개</option>
                	<option value=2>2개</option>
               		<option value=3>3개</option>
                	<option value=4>4개</option>
            	</select><br />
            </td>
        </tr>
        <tr>
                <!-- 숙소 객실수 입력 -->
            <td>숙소 구분</td>
            <td>
                <select name="act_div">
               	 	<option value="호텔,리조트">호텔,리조트</option>
                	<option value="모텔">모텔</option>
               		<option value="펜션">펜션</option>
                	<option value="게스트하우스">게스트하우스</option>
            	</select><br />
            </td>
        </tr>
        
        <tr>
        <!-- 버튼목록 -->
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='actList.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</div>
<!-- 숙소 작성 폼 끝 -->
</body>
</html>