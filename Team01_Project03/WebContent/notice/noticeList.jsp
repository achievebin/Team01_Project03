<!-- 
공지사항 게시판
관리자(admin)계정이 아니면 글쓰기 버튼이 보이지 않도록 처리
현재 url로 직접 접근시 계정 등급과 상관없이 글이 써지는 문제가 있음
-->

<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="board.NoticetblDAO" %>
<%@ page import="board.NoticetblDTO" %>
<%@ page import="member.MemberDao" %>
<%@ page import="member.MemberDto" %>
<%@ page import="utils.BoardPage" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	// DAO를 생성해 DB에 연결
NoticetblDAO dao = new NoticetblDAO(application);
NoticetblDTO gdto = dao.selectView("noc_num"); // 게시물 가져오기
String myGrade = (String) session.getAttribute("signInGrade");


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("searchWord", searchWord);
}

int totalCount = dao.selectCount(param); // 게시물 수 확인

/*** 페이지 처리 start ***/
// 전체 페이지 수 계산
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수

// 현재 페이지 확인
int pageNum = 1; // 기본값
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
    pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정

// 목록에 출력할 게시물 범위 계산
int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
int end = pageNum * pageSize; // 마지막 게시물 번호
param.put("start", start);
param.put("end", end);
/*** 페이지 처리 end ***/

List<NoticetblDTO> boardLists = dao.selectList(param); // 게시물 목록 받기
dao.close(); // DB 연결 닫기
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
<%-- <link href="${pageContext.request.contextPath}/common/css/notice.css" rel="stylesheet" type="text/css" /> --%>
<link href="./css/notice.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- css 정보 -->

<jsp:include page="../common/header.jsp"/>



<!-- 검색폼 -->
<div id="searchbarlist">
	<div class="searchbar">
		<h2>공지사항</h2>
		<form method="get">
		    <table border="1" style="width:90%">
		        <tr>
		            <td align="center">
		                <select name="searchField">
		                    <option value="noc_title">제목</option>
		                    <option value="noc_content">내용</option>
		                </select>
		                <input type="text" name="searchWord"/>
		                <input type="submit" value="검색하기"/>
		            </td>
		        </tr>
		    </table>
		</form>
	</div>
		
<!-- 게시물 목록 테이블(표) -->
	<table border="1" style="width:90%" id="noticeListTable">
	    <!-- 각 칼럼의 이름 -->
	    <tr>
	        <th width="10%">번호</th>
	        <th width="50%">제목</th>
	        <th width="15%">작성자</th>
	        <!-- <th width="10%">조회수</th> -->
	        <th width="15%">작성일</th>
	    </tr>
	    <!-- 목록의 내용 -->
	    <%
	    	if (boardLists.isEmpty()) {
	                // 게시물이 하나도 없을 때
	    %>
	        <tr>
	            <td colspan="5" align="center">
	                등록된 게시물이 없습니다^^*
	            </td>
	        </tr>
	        <%
	        	} else {
	                        // 게시물이 있을 때
	                        int virtualNum = 0; // 화면상에서의 게시물 번호
	                        for (NoticetblDTO dto : boardLists) {
	                            virtualNum = totalCount--; // 전체 게시물 수에서 시작해 1씩 감소
	        %>
	            <tr align="center">
	                <td><%= virtualNum %></td>
	                <!--게시물 번호-->
	                <td align="left">
	                    <!--제목(+ 하이퍼링크)-->
	                    <a href="noticeView.jsp?num=<%= dto.getNoc_num() %>"><%= dto.getNoc_title() %></a>
	                </td>
	                <td align="center"><%= dto.getMit_id() %></td>
	                <!--작성자 아이디-->
	                <td align="center"><%= dto.getPostdate() %></td>
	                <!--작성일-->
	            </tr>
	            <%
	        }
	    }
	    %>
	</table>
	<!--목록 하단의 [글쓰기] 버튼-->
	<table border="1" style="width:90%">
	    <tr align="center">
	        <!--페이징 처리-->
	        <td>
	            <%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
	        </td>
	        <!--글쓰기 버튼-->
	        <% if (myGrade != null && myGrade.equals("admin")) { %>
	         <td>
	             <button type="button" onclick="location.href='noticeWrite.jsp';">글쓰기</button>
	         </td>
	        <% } %>
	    </tr>
	</table>
</div>
<jsp:include page="/common/footer.jsp"/>
</body>
</html>
