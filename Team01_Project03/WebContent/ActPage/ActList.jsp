<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DAO를 생성해 DB에 연결
act.ActDAO dao = new act.ActDAO(application);

// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("searchWord", searchWord);
}

int totalCount = dao.selectCount(param);  // 게시물 수 확인

/*** 페이지 처리 start ***/
// 전체 페이지 수 계산
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수

// 현재 페이지 확인
int pageNum = 1;  // 기본값
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
    pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정

// 목록에 출력할 게시물 범위 계산
int start = (pageNum - 1) * pageSize + 1;  // 첫 게시물 번호
int end = pageNum * pageSize; // 마지막 게시물 번호
param.put("start", start);
param.put("end", end);
/*** 페이지 처리 end ***/

List<ActDTO> ActLists = dao.selectListPage(param);  // 게시물 목록 받기
dao.close();  // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 목록</title>
</head>
<body>
    <jsp:include page="../ActPage/MainLink.jsp" />  <!-- 공통 링크 -->

    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    <!-- 검색폼 -->
    <form method="get">
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 -->
        <tr>
            <th width="10%">번호</th>
            <th width="10%">숙소명</th>
            <th width="30%">숙소정보</th>
            <th width="10%">숙소주소</th>
            <th width="10%">전화번호</th>
            <th width="15%">남은객실수</th>
        </tr>
        <!-- 목록의 내용 -->
<%
if (ActLists.isEmpty()) {
    // 게시물이 하나도 없을 때
%>
        <tr>
            <td colspan="5" align="center">
                첫 숙소를 등록해주세요!
            </td>
        </tr>
<%
}
else {
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    for (ActDTO dto : ActLists)
    {
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
        <tr align="center">
            <td><%= dto.getActNumber() %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="ActView.jsp?num=<%= dto.getActNumber() %>"><%= dto.getActName() %></a>
            </td>
            <td align="center"><%= dto.getActInfo() %></td>          <!--숙소정보-->
            <td align="center"><%= dto.getActAddress() %></td>          <!--숙소주소-->
            <td align="center"><%= dto.getActPhone() %></td>  <!--숙소번호-->
            <td align="center"><%= dto.getActRoom() %></td>    <!--남은객실수-->
        </tr>
<%
    }
}
%>
    </table>
    <!--목록 하단의 [글쓰기] 버튼-->
    <table border="1" width="90%">
        <tr align="center">
            <!--페이징 처리-->
            <td>
                <%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>  
            </td>
            <!--글쓰기 버튼-->
            <td><button type="button" onclick="location.href='ActWrite.jsp';">글쓰기
                </button></td>

    </table>
</body>
</html>
