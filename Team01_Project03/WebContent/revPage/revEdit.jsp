<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLoggedIn.jsp"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 
ReviewDAO dao = new ReviewDAO(application);  // DAO 생성
ReviewDTO dto = dao.selectView(num);        // 게시물 가져오기 
String sessionId = session.getAttribute("signInId").toString(); // 로그인 ID 얻기 
if (!sessionId.equals(dto.getId())) {      // 본인인지 확인
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
dao.close();  // DB 연결 해제
String actname = (String)session.getAttribute("actname"); //숙소명 가져오기
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>숙소정보 수정</title>

 <!-- 리뷰 수정 예외처리 함수 -->
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.rev_title.value == "") {
        alert("제목을 입력하세요.");
        form.rev_title.focus();
        return false;
    }
    if (form.rev_content.value == "") {
        alert("내용을 입력하세요.");
        form.rev_content.focus();
        return false;
    }
}
</script>
 <!-- 리뷰 수정 예외처리함수 끝 -->
</head>
<body>

<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

<h2>숙소정보 수정</h2>

<!-- 리뷰수정 폼 --> 
<form name="ReviewEditFrm" method="post" action="revEditProcess.jsp"
      onsubmit="return validateForm(this);">
      
      <!-- 리뷰번호 입력 -->
      <input type="hidden" name="rev_num" value="<%= dto.getNum() %>" />
    <table border="1" style="width:90%">
        <tr>
        <!-- 리뷰 제목 입력 -->
            <td>제목</td>
            <td>
                <input type="text" name="rev_title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
        <!-- 리뷰 내용 입력 -->
            <td>내용</td>
            <td>
                <textarea name="rev_content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr> 
        <!-- 리뷰 점수 입력 -->
        	<td>별점</td>
        	<td>
        		<input type="radio" name="rev_score" value=1 />1
        		<input type="radio" name="rev_score" value=2 />2
        		<input type="radio" name="rev_score" value=3 />3
        		<input type="radio" name="rev_score" value=4 />4
        		<input type="radio" name="rev_score" value=5 checked="checked" />5
        	</td>
        </tr>
        <!-- 버튼 목록 -->
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='actList.jsp';">
                    목록 보기</button>
            </td>
        </tr>
        <tr>
            <td>숙소명</td>
            <td><%= actname %></td>
        </tr>
    </table>
</form>
<!-- 리뷰수정 폼 끝 -->
</body>
</html>