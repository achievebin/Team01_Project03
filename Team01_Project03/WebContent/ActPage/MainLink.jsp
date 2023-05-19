<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table border="1" width="90%"> 
    <tr>
        <td align="center">
        <!-- 로그인 여부에 따른 메뉴 변화 -->
        <% if (session.getAttribute("signInId") == null) { %>
            <a href="../index.jsp">로그인</a>
        <% } else { %>
            <a href="../index.jsp">로그아웃</a>
        <% } %>
            <!-- 회원제 게시판 프로젝트에서 사용할 링크 -->   
            &nbsp;&nbsp;&nbsp; 
            <a href="../ActPage/ActList.jsp">숙소목록</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="../ActPage/ReviewList.jsp">리뷰</a>
        </td>
    </tr>
</table>
