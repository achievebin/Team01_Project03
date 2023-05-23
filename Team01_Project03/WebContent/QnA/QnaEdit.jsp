<%@ page import="QnA.QnAtblDAO" %>
<%@ page import="QnA.QnAtblDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Common/IsLoggedIn.jsp"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 
QnAtblDAO dao = new QnAtblDAO(application);  // DAO 생성
QnAtblDTO dto = dao.selectView(num);        // 게시물 가져오기 
String sessionId = session.getAttribute("signInId").toString(); // 로그인 ID 얻기 
if (!sessionId.equals(dto.getMit_id())) {      // 본인인지 확인
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
dao.close();  // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>공지사항</title>
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
	<jsp:include page="../Common/header.jsp" />
<h2>공지사항 - 수정하기(Edit)</h2>
<form name="writeFrm" method="post" action="EditProcess.jsp"
      onsubmit="return validateForm(this);">
    <input type="hidden" name="num" value="<%= dto.getQna_number() %>" /> 
    <table border="1" style="width:90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" 
                       value="<%= dto.getQna_title() %>"/> 
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"><%= dto.getQna_content() %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <!-- <button type="reset">다시 입력</button> -->
                <button type="button" onclick="location.href='QnaList.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>