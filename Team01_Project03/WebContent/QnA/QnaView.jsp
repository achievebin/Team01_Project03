<%@ page import="QnA.QnAtblDAO" %>
<%@ page import="QnA.QnAtblDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기
String postId = request.getParameter("postId");

QnAtblDAO dao = new QnAtblDAO(application);  // DAO 생성

//dao.updateVisitCount(num);                 // 조회수 증가
QnAtblDTO dto = dao.selectView(num);        // 게시물 가져오기
dao.close();                               // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문과 답변</title>
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?");
    if (confirmed) {
        var form = document.writeFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식
        form.action = "DeleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
</head>
<body>
<%@ include file="/Common/header.jsp" %>

<h2>질문과 답변 상세보기</h2>

<!-- 댓글 목록 표시 영역 -->
<%-- <div>
    <% 
    // 게시물의 일련번호에 해당하는 댓글 목록을 가져옴
    List<CommentDTO> commentList = dao.getCommentList(postId);
    
    // 댓글 목록을 순회하며 출력
    for (CommentDTO comment : commentList) { %>
        <div>
            <p><%= comment.getWriter() %></p> <!-- 댓글 작성자 -->
            <p><%= comment.getContent() %></p> <!-- 댓글 내용 -->
        </div>
    <% } %>
</div> --%>

<%-- <!-- 댓글 작성 폼 -->
<form action="imsi.jsp" method="POST">
    <input type="hidden" name="postId" value="<%= postId %>"> <!-- 게시물의 일련번호 전달 -->
    <input type="text" name="writer" placeholder="작성자 이름">
    <textarea name="content" placeholder="댓글 내용"></textarea>
    <button type="submit">댓글 작성</button>
</form> --%>

<form name="writeFrm">
    <input type="hidden" name="num" value="<%= num %>" />
    <table border="1" style="width:90%">
        <tr>
            <td>번호</td>
            <td><%= dto.getQna_number() %></td>
             
            <td>작성자</td>
            <td><%= dto.getMit_id() %></td>
        </tr>
        
        <tr>
            <td>작성일</td>
            <td><%= dto.getPostdate() %></td>
        </tr>
        
        <tr>
            <td>제목</td>
            <td colspan="3"><%= dto.getQna_title() %></td>
        </tr>
        
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
                <%= dto.getQna_content().replace("\r\n", "<br/>") %></td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <%
                if (session.getAttribute("signInId") != null
                    && session.getAttribute("signInId").toString().equals(dto.getMit_id())) {
                	
                %>
                <!-- 수정 버튼 -->
                <button type="button"
                        onclick="location.href='QnaEdit.jsp?num=<%= dto.getQna_number() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
                <%
                }
                %>
                <%
                if (session.getAttribute("signInId") != null
                    && session.getAttribute("signInId").toString().equals("master")) {
                	
                %>
               <%--  <!-- 수정 버튼 -->
                <button type="button"
                        onclick="location.href='QnaEdit.jsp?num=<%= dto.getQna_number() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button>
                <!-- 답변하기 버튼 --> --%>
                <button type="button" onclick="location.href='QnaReply.jsp';">답변하기</button> 
                <%
                }
                %>
                <!-- 목록보기 버튼 -->
                <button type="button" onclick="location.href='QnaList.jsp';">
                    목록 보기
                </button>
                
            </td>
        </tr>
    </table>
</form>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
