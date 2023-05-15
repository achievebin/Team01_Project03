<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="IsLoggedIn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글쓰기</title>
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
	<h2>글쓰기</h2>
	<form name="writeFrm" method="post" action="WriteProcess.jsp"
     	 onsubmit="return validateForm(this);">
   	 <table border="1" style="width:90%">
       	 <tr>
           	 <td>제목</td>
           	 <td>
                <input type="text" name="title" style="width: 90%;" placeholder="제목을 입력해 주세요." />
              
            	</td>
          </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 300px;" placeholder="내용을 입력해 주세요." ></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit" >작성 완료</button>
                <!-- <button type="reset">다시 입력</button>-->
                <!-- <button type="button" onClick="location.href='List.jsp';"> -->
                <button type="button" onclick="if(confirm('목록 페이지로 이동하시겠습니까?')){location.href='NoticeList.jsp';}">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>