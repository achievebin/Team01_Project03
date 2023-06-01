<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="utils.Page"%>
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
ReviewDAO dao = new ReviewDAO(application); //리뷰dao
ActDTO adt = new ActDTO();	//숙소dto


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");	
String searchWord = (String)session.getAttribute("signInId");	//map에 아이디 입력
param.put("id", searchWord);
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("id", searchWord);
}

int totalCount = dao.myselectCount(param);  // 게시물 수 확인

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

String hotel = (String)request.getAttribute("actnumber");	//숙소번호 변수지정
request.setAttribute("hotelname", hotel);	//숙소번호 리퀘스트지정
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성
String accsearch = request.getParameter("accsearch");
ScoreDTO sdto = sdao.scoreView(hotel); //점수 가져오기
sdao.close();	//점수db 연결해제
%>
<!DOCTYPE html>

<html>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>리뷰 목록</title>

<!-- 리뷰 삭제 스크립트 -->
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
<!-- 리뷰 삭제 스크립트 끝 -->

<!-- css 연결 -->
<link href="./css/revcss.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>	
	<div class="wrapper">
		<!-- myReview div 시작 -->		
		<div id="myReview">
		<h2>활동내역 - 내가 쓴 리뷰</h2>
		
		
		  
		
		<!--     검색폼
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
		
		    </form> -->
		    <!-- 검색 폼 끝 -->
		    
		    <!-- revListTable 시작 -->
		    <table border="1" style="width:90%" class="revListTable" >
		        <!-- 각 칼럼의 이름 -->
		        <tr align="center">
		            <th width="5%">번호</th>
		            <th width="20%">숙소명</th>
		            <th width="10%">제목</th>
		            <th width="40%" style="word-break:break-all">내용</th>
		            <th width="10%">작성자</th>
		            <th width="5%">별점</th>
		            <th width="10%">작성일</th>
		        </tr>
		        <!-- 목록의 내용 -->
		        
		        <!-- 게시물이 없을경우 -->
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
		else { %> 
			<!-- 게시물이 있을경우 목록 출력 -->
			<%
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
		            <td><%= dto.getNum()%></td>  <!--게시물 번호-->
		            <td align="left"><%= dto.getHotel() %></td> <!-- 숙소명 -->
		            
		            <td align="left">  <!--제목(+ 하이퍼링크)-->
		                <a href="../revPage/revView.jsp?num=<%= dto.getNum() %>">
		                <%= dto.getTitle() %></a> <!-- 리뷰제목 -->
		            </td>
		            
		            <!-- <td width="100px" height="100px" style = "word-break: break-all">O</td>  -->
		            <td width="400px" style = "word-break: break-all; text-align: left"><%= dto.getContent() %></td>    <!--내용-->
		            <td align="center"><%= dto.getId() %></td>          <!--작성자 아이디-->
		            <td align="center"><%= dto.getScore() %></td>  <!--숙소점수-->
		            <td align="center"><%= dto.getPostdate() %></td>    <!--작성일-->
		
		        </tr>
		
		
		
		<%
		    	
		    	}
			}
		%>
		
		    </table>
		    <!-- revListTable 끝 -->
		    
 <!-- 페이징 및 글쓰기 버튼 -->
	    <table border="1" style="width:90%">
	        <tr align="center">
	            <!--페이징 처리-->
	            <td  align="center" style="width:90%">
	                <%
				    String reqUrl = request.getRequestURI(); // 현재 요청의 URI를 가져옴
				    if (accsearch == null) { // accsearch가 null인 경우
				        reqUrl += "?"; // reqUrl에 ?를 추가
				    } else { // accsearch가 null이 아닌 경우
				        reqUrl += "?accsearch=" + accsearch; // reqUrl에 ?accsearch=값을 추가
				    }
				    reqUrl += "&searchText=act_name"; // reqUrl에 &searchText=act_name을 추가
				    out.println(Page.pagingStr(totalCount, pageSize, blockPage, pageNum, reqUrl)); // 페이지 링크 출력
					%>
	            </td>
	            
	            
	             <!--글쓰기 버튼-->
	        
	            <td align="right" style="width:10%">
	            	<button type="button" onclick="location.href='actWrite.jsp';">숙소 등록
	                </button>
	            </td>
	        </tr>
	    </table>
	    <!-- 페이징 및 글쓰기 버튼 끝 -->
		
		</div>
		<!-- myReview div 끝 -->
	</div>
	
</body>

<!-- 푸터 적용 -->
<jsp:include page="/common/footer.jsp"/>
</html>
