<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글쓰기</title>
<script type="text/javascript">
	// 내용이 비어있을시 경고메세지 출력
function NoticeWriteForm(form) {  // 폼 내용 검증
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
<link href="./css/notice.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../common/header.jsp" /> 

<div class="wrapper">
	<div id="noticeWrite">
		<!-- 수정 폼 전송 -->
			<h2>글쓰기</h2>
		<form name="writeFrm" method="post" action="writeProcess.jsp"
	     	 onsubmit="return noticeWriteForm(this);">
	   	 	<table border="1" style="width:90%" id="">
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
		                <button type="button" onclick="if(confirm('목록 페이지로 이동하시겠습니까?')){location.href='noticeList.jsp';}">
		                    목록 보기</button>
		            </td>
		        </tr>
	   	 	</table>
		</form>
	</div>
</div>	
<jsp:include page="../common/footer.jsp" />
</body>
</html>