<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="connect.JDBConnect"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// DAO를 생성해 DB에 연결
ReviewDAO dao = new ReviewDAO(application);
ActDTO adt = new ActDTO();


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = (String)session.getAttribute("signInId");
param.put("id", searchWord);
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("id", searchWord);
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

 List<ReviewDTO> ReviewLists = dao.selectMyList(param);  // 게시물 목록 받기

dao.close();  // DB 연결 닫기

String hotel = (String)request.getAttribute("actnumber");
request.setAttribute("hotelname", hotel);
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(hotel); //점수 가져오기
sdao.close();
%>
<!DOCTYPE html>

<html>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>리뷰 목록</title>
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "revDeleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
<%@ include file="../common/header.jsp" %>	
</head>
<body>
<h2>활동내역 - 내가 쓴 리뷰</h2>


  

    <!-- 검색폼 -->
    <form method="get">
    <table border="1" style="width:90%">
    <tr>
        <td align="left">
            <select name="searchField">
                <option value="rev_title">제목</option>
                <option value="rev_content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
            
        </td>
    </tr>
    </table>
        <!--목록 하단의 [글쓰기] 버튼-->
    <table border="1" style="width:90%">
        <tr align="right">
            <!--페이징 처리-->
            <td>
                <%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>  
            </td>

        </tr>
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" style="width:90%" >
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="5%">번호</th>
            <th width="10%">숙소명</th>
            <th width="10%">제목</th>
            <th width="40%" style="word-break:break-all">내용</th>
            <th width="10%">작성자</th>
            <th width="5%">별점</th>
            <th width="10%">작성일</th>
        </tr>
        <!-- 목록의 내용 -->
<%
if (ReviewLists.isEmpty()) {
    // 게시물이 하나도 없을 때
%>
        <tr>
            <td colspan="5" align="center">
                첫 리뷰를 작성해보세요!
            </td>
        </tr>
<%
}
else {
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    
    for (ReviewDTO dto : ReviewLists)
    {
    	
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        request.setAttribute("num",dto.getNum());
%>

        <tr align="center">
            <td><%= dto.getNum() 
            %></td>  <!--게시물 번호-->
            <td align="center"><%= dto.getHotel() %></td> 
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="../revPage/revView.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a>
            </td>
            <!-- <td width="100px" height="100px" style = "word-break: break-all">O</td>  -->
            <td width="400px" style = "word-break: break-all"><%= dto.getContent() %></td>    <!--내용-->
            <td align="center"><%= dto.getId() %></td>          <!--작성자 아이디-->
            <td align="center"><%= dto.getScore() %></td>  <!--점수-->
            <td align="center"><%= dto.getPostdate() %></td>    <!--작성일-->
<%--                         <td colspan="4" align="center">
            <%
            if (session.getAttribute("signInId") != null
                && session.getAttribute("signInId").toString().equals(dto.getId())) {
            %>
                <button type="button"
                        onclick="location.href='RevEdit.jsp?num=<%= dto.getActNumber() %>';">
                    수정하기</button>
                <!-- <button type="button" onclick="deletePost();">삭제하기</button>  -->
            <%
            }
            %>
            </td> --%>
        </tr>


<%
    	
    }
}
%>

    </table>
    


</body>
</html>
