<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="Review.ReviewDAO"%>
<%@ page import="Review.ReviewDTO"%>
<%@ page import="Act.ActDTO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// DAO를 생성해 DB에 연결
ReviewDAO dao = new ReviewDAO(application);
ActDTO adt = new ActDTO();

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

List<ReviewDTO> ReviewLists = dao.selectListPage(param);  // 게시물 목록 받기

dao.close();  // DB 연결 닫기

String hotel = (String)request.getAttribute("actname");
request.setAttribute("hotelname", hotel);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
    <jsp:include page="../ActPage/ActLink.jsp" />  <!-- 공통 링크 -->


    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    <h2>현재 숙소: <%= hotel %>  </h2>
    <h2>별점 평균:    <% 
    // DB에 연결
    JDBConnect jdbc = new JDBConnect();

    // 쿼리문 생성   
    String sql = "select rev_avg from review_score where hotel = '" + hotel + "'";  
    Statement stmt = jdbc.con.createStatement();

    // 쿼리 수행
    ResultSet rs = stmt.executeQuery(sql);  

    // 결과 확인(웹 페이지에 출력)
    while (rs.next()) { 
        String id = rs.getString("rev_avg");

        
        
        out.println(String.format("%s", id) + "<br/>"); 
        
    }

    // 연결 닫기
    
    %>
  
      전체리뷰:     <%

    // 쿼리문 생성   
    String countAll = "select count(rev_score)from reviewtbl where rev_hotel ='" + hotel + "'";  

    // 쿼리 수행
    ResultSet ca = stmt.executeQuery(countAll);  

    // 결과 확인(웹 페이지에 출력)
    while (ca.next()) { 
        String id = ca.getString("count(rev_score)");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    
    %>개 

    
    
      5점:     <%

    // 쿼리문 생성   
    String count5 = "select count5 from review_score where hotel = '" + hotel + "'";  

    // 쿼리 수행
    ResultSet c5 = stmt.executeQuery(count5);  

    // 결과 확인(웹 페이지에 출력)
    while (c5.next()) { 
        String id = c5.getString("count5");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    
    %>개 
    
    4점: <%

    // 쿼리문 생성   
    String count4 = "select count4 from review_score where hotel = '" + hotel + "'";  

    // 쿼리 수행
    ResultSet c4 = stmt.executeQuery(count4);  

    // 결과 확인(웹 페이지에 출력)
    while (c4.next()) { 
        String id = c4.getString("count4");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    //jdbc.close();
    %>개 
    
    3점: <%

    // 쿼리문 생성   
    String count3 = "select count3 from review_score where hotel = '" + hotel + "'";  

    // 쿼리 수행
    ResultSet c3 = stmt.executeQuery(count3);  

    // 결과 확인(웹 페이지에 출력)
    while (c3.next()) { 
        String id = c3.getString("count3");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    //jdbc.close();
    %>개 
    
    2점: <%

    // 쿼리문 생성   
    String count2 = "select count2 from review_score where hotel = '" + hotel + "'";  

    // 쿼리 수행
    ResultSet c2 = stmt.executeQuery(count2);  

    // 결과 확인(웹 페이지에 출력)
    while (c2.next()) { 
        String id = c2.getString("count2");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    //jdbc.close();
    %>개 
    
    1점: <%

    // 쿼리문 생성   
    String count1 = "select count1 from review_score where hotel = '" + hotel + "'";  

    // 쿼리 수행
    ResultSet c1 = stmt.executeQuery(count1);  

    // 결과 확인(웹 페이지에 출력)
    while (c1.next()) { 
        String id = c1.getString("count1");

        
        
        out.println(String.format("%s", id)); 
    }

    // 연결 닫기
    jdbc.close();
    %>개   </h2>
    <!-- 검색폼 -->
    <form method="get">
    <table border="1" width="90%">
    <tr>
        <td align="left">
            <select name="searchField">
                <option value="rev_title">제목</option>
                <option value="rev_content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
            <input type="text" name="hotelname" value=<%= hotel %>/>
        </td>
    </tr>
    </table>
        <!--목록 하단의 [글쓰기] 버튼-->
    <table border="1" width="90%">
        <tr align="right">
            <!--페이징 처리-->
            <td>
                <%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>  
            </td>
            <!--글쓰기 버튼-->
            <td><button type="button" onclick="location.href='ReviewWrite.jsp';">글쓰기
                </button></td>
        </tr>
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 -->
        <tr>
            <th width="5%">번호</th>
            <th width="10%">제목</th>
            <th width="10%">사진</th>
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
                등록된 게시물이 없습니다^^*
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
%>
        <tr align="center">
            <td><%= virtualNum %></td>  <!--게시물 번호-->
            <td align="center">  <!--제목-->
                <%= dto.getTitle() %>
            </td>
            <td width="100px" height="100px" style = "word-break: break-all">O</td> 
            <td width="400px" style = "word-break: break-all"><%= dto.getContent() %></td>    <!--내용-->
            <td align="center"><%= dto.getId() %></td>          <!--작성자 아이디-->
            <td align="center"><%= dto.getScore() %></td>  <!--점수-->
            <td align="center"><%= dto.getPostdate() %></td>    <!--작성일-->
        </tr>
<%
    }
}
%>
    </table>

</body>
</html>
