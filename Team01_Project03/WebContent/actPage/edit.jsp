<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 
ActDAO dao = new ActDAO(application);  // DAO 생성
ActDTO dto = dao.selectView(num);        // 게시물 가져오기 
String sessionId = session.getAttribute("signInId").toString(); // 로그인 ID 얻기 
if (!sessionId.equals(dto.getActId())) {      // 본인인지 확인
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
dao.close();  // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>

<!-- css 연결 -->
<link href="./css/actcss.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<!-- 타이틀 -->

<title>숙소정보 수정</title>

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

</head>

<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>	

<div id = "actEdit">
<h2>숙소정보 수정</h2>

<!-- 숙소정보 수정 폼 -->
<form name="ActEditFrm" method="post" action="editProcess.jsp"
      onsubmit="return validateForm(this);">
       <input type="hidden" name="act_number" value="<%= dto.getActNumber() %>" /> 
      <!-- 숙소정보 수정 테이블 -->
    <table border="1" style="width:90%" id="actEditTable">
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
        <!-- 숙소전화번호 입력 -->
            <td>숙소 전화번호</td>
            <td>
                <input type="text" name="act_phone" style="width: 90%;" />
            </td>
        </tr>
        
        <tr>
        <!-- 숙소주소 입력 -->
            <td>숙소 주소</td>
            <td>
                <input type="text" name="act_address" style="width: 90%;" />
            </td>
         </tr>
         <tr>
         <!-- 숙소가격 입력 -->
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
        <!-- 버튼 목록 -->
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='actList.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
    <!-- 숙소정보 수정 테이블 끝 -->
</form>
<!-- 숙소정보 수정 폼 끝 -->
</div>

</body>
<jsp:include page="../common/footer.jsp"/>
</html>
