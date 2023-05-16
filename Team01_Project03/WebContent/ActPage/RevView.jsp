<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");  // 일련번호 받기 

ReviewDAO dao = new ReviewDAO(application);  // DAO 생성 
              
review.ReviewDTO dto = dao.selectView(num);        // 게시물 가져오기 
String actname = dto.getTitle();

out.println(actname);
dao.close();                               // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 소개</title>
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "DeleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
</head>
<body>
<jsp:include page="../ActPage/MainLink.jsp" />
<h2>회원제 게시판 - 상세 보기(View)</h2>
<form name="ReViewFrm" method="post">
    <table border="1" style="width:90%">
        <tr>
            <td>번호</td>
            
            <td><%= dto.getActNumber() %></td>
            <td>작성자</td>
            <td><%= dto.getId() %></td>
        </tr>
        <tr>

        </tr>
        <tr>
            <td>제목</td>
            
            <td colspan="3"><%= dto.getTitle() %></td>
        </tr>
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
                <%= dto.getContent() %></td> 
        </tr>
        <tr>
            <td colspan="4" align="center">
            <%
            if (session.getAttribute("signInId") != null
                && session.getAttribute("signInId").toString().equals(dto.getId())) {
            %>
                <button type="button"
                        onclick="location.href='ReviewEdit.jsp?num=<%= dto.getNum() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
            <%
            }
            %>
                <button type="button" onclick="location.href='ActList.jsp';">
                    목록 보기
                </button>
                <button type="button" onclick="location.href='ReviewWrite.jsp';">
                    리뷰 쓰기
                </button>
            </td>
        </tr>
    	<jsp:include page="./ReviewList.jsp" />
    </table>
</form>
</body>
</html>
