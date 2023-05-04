<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="Review.ReviewDAO"%>
<%@ page import="Review.ReviewDTO"%>
<%@ page import="Act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="Review.ReviewDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>

<%@ include file="./IsLoggedIn.jsp"%> <!--로그인 확인-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
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
<jsp:include page="../ActPage/ActLink.jsp" />
<%String hotel = (String)request.getAttribute("hotelname"); %>
<h2>회원제 게시판 - 글쓰기(Write)</h2>
<h2>현재 숙소: <%=hotel%>  </h2>
<form name="ReviewwriteFrm" method="post" action="ReviewWriteProcess.jsp"
      onsubmit="return validateForm(this);">
    <table border="1" width="90%">
        <tr>
        
            <td>제목</td>
            <td>
                <input type="text" name="rev_title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="rev_content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr> 
        	<td>별점</td>
        	<td>
        		<input type="radio" name="rev_score" value=1 />1
        		<input type="radio" name="rev_score" value=2 />2
        		<input type="radio" name="rev_score" value=3 />3
        		<input type="radio" name="rev_score" value=4 />4
        		<input type="radio" name="rev_score" value=5 />5
        	</td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='ReviewList.jsp';">
                    목록 보기</button>
            </td>
        </tr>
        <tr>
            <td>숙소명</td>
            <td>
               <%= hotel %>
            </td>
        </tr>
    </table>
</form>
</body>
</html>