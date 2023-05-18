<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="review.ReviewDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="connect.JDBConnect"%>

<%@ include file="./IsLoggedIn.jsp"%> <!--로그인 확인-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 쓰기</title>
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
<%
	// DAO를 생성해 DB에 연결
ReviewDAO dao = new ReviewDAO(application);
act.ActDTO adt = new act.ActDTO();
String actname = (String)session.getAttribute("actname");
String actnumber = (String)session.getAttribute("actnumber");


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = (String)request.getAttribute("actnumber");
param.put("actnumber", searchWord);
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("actnumber", searchWord);
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

List<review.ReviewDTO> ReviewLists = dao.selectListPage(param);  // 게시물 목록 받기

dao.close();  // DB 연결 닫기
%>
<h2>리뷰 쓰기</h2>
<%-- <h2>현재 숙소: <%=hotelname%>  </h2> --%>
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
            	<%= actname %>
               <input type="hidden" name="rev_hotel" value= <%= actname %> style="width: 90%;" />
               <input type="hidden" name="act_number" value= <%= actnumber %> style="width: 90%;" />
            </td>
        </tr>
    </table>
</form>
</body>
</html>