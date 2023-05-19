<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/IsLoggedIn.jsp"%>
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
<meta charset="UTF-8">

<title>숙소정보 수정</title>
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>숙소정보 수정</h2>
<form name="ActEditFrm" method="post" action="EditProcess.jsp"
    <input type="hidden" name="act_number" value="<%= dto.getActNumber() %>" /> 
      onsubmit="return validateForm(this);">
    <table border="1" width="90%">
        <tr>
            <td>숙소명</td>
            <td>
                <input type="text" name="act_name" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>숙소정보</td>
            <td>
                <textarea name="act_info" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
            <td>숙소 전화번호</td>
            <td>
                <input type="text" name="act_phone" style="width: 90%;" />
            </td>
        </tr>
                <tr>
            <td>숙소 주소</td>
            <td>
                <input type="text" name="act_address" style="width: 90%;" />
            </td>
        </tr>
                <tr>
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
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>