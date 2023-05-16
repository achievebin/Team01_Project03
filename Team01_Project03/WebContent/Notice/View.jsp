<%@ page import="board.NoticetblDAO"%>
<%@ page import="board.NoticetblDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기

NoticetblDAO dao = new NoticetblDAO(application);  // DAO 생성
//dao.updateVisitCount(num);                 // 조회수 증가
NoticetblDTO dto = dao.selectView(num);        // 게시물 가져오기
dao.close();                               // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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

<h2>공지사항 상세보기</h2>
<form name="writeFrm">
    <input type="hidden" name="num" value="<%= num %>" />
    <table border="1" style="width:90%">
        <tr>
            <td>번호</td>
            <td><%= dto.getNoc_num() %></td>
             
            <td>작성자</td>
            <td><%= dto.getMit_id() %></td>
        </tr>
        
        <tr>
            <td>작성일</td>
            <td><%= dto.getPostdate() %></td>
        </tr>
        
        <tr>
            <td>제목</td>
            <td colspan="3"><%= dto.getNoc_title() %></td>
        </tr>
        
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
                <%= dto.getNoc_content().replace("\r\n", "<br/>") %></td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <%
                if (session.getAttribute("signInId") != null
                    && session.getAttribute("signInId").toString().equals(dto.getMit_id())) {
                %>
                <button type="button"
                        onclick="location.href='NoticeEdit.jsp?num=<%= dto.getNoc_num() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
                <%
                }
                %>
                <button type="button" onclick="location.href='NoticeList.jsp';">
                    목록 보기
                </button>
            </td>
        </tr>
    </table>
</form>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
