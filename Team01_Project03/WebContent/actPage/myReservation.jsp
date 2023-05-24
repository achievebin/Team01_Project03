<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="connect.JDBConnect"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.Date, java.io.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./isLoggedIn.jsp"%>
<%

String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date sysdate = new Date(dateFormat.parse(todayfm).getTime());

// DAO를 생성해 DB에 연결
ReserveDAO dao = new ReserveDAO(application);
ActDTO adt = new ActDTO();


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = (String)session.getAttribute("signInId");
param.put("actnumber", searchWord);
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("resid", searchWord);
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

 List<ReserveDTO> ReserveLists = dao.selectListPage(param);  // 게시물 목록 받기

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
<jsp:include page="/common/header.jsp" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>예약 정보</title>
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
</head>
<body>



   <%--  <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2> --%>
    <h2>예약 목록</h2>

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
    <table border="1" style="width:90%">
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="5%">번호</th>
            <th width="10%">숙소명</th>
            <th width="10%">체크인</th>
            <th width="10%">체크아웃</th>
            <th width="10%">예약 아이디</th>
            <th width="10%">예약자 명</th>
            <th width="10%">가격</th>
            <th width="10%">지불수단</th>
            <th width="10%">예약여부</th>
        </tr>
        <!-- 목록의 내용 -->
<%
if (ReserveLists.isEmpty()) {
    // 게시물이 하나도 없을 때
%>
        <tr>
            <td colspan="5" align="center">
                예약 정보가 없습니다.
            </td>
        </tr>
<%
}
else {
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    
    for (ReserveDTO dto : ReserveLists)
    {
    	
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        request.setAttribute("num",dto.getResnumber());
%>

        <tr align="center">
            <td><%= dto.getResnumber() 
            %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="reservePrint.jsp?num=<%= dto.getResnumber() %>"><%= dto.getReshotel() %></a>
            </td>
            <td ><%= dto.getResstart() %></td>
			<td ><%= dto.getResend() %></td>
            <td ><%= dto.getResid() %></td>          <!--작성자 아이디-->
            <td ><%= dto.getResname() %></td>
            <td ><%= dto.getResprice() %></td>  <!--점수-->
            <td ><%= dto.getRespurchase() %></td>    <!--작성일-->
            <td ><%= dto.getRescancle() %></td>
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
