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
ActDTO adt = new ActDTO(); //숙소 dto 


// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchword");
String actnumber = (String)request.getAttribute("actnumber"); // 숙소 번호 변수지정

param.put("actnumber", actnumber); //숙소 번호 map에 입력

//검색어 map에입력
if (searchWord != null) {
    param.put("searchField", searchField);
    param.put("searchword", searchWord);
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

String hotel = (String)request.getAttribute("actnumber"); //숙소번호 얻기
request.setAttribute("hotelname", hotel); //숙소번호 리퀘스트 지정
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(hotel); //점수 가져오기
sdao.close(); //점수 db연결해제
%>
<!DOCTYPE html>

<html>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>리뷰 목록</title>

<!-- css 연결 -->
<link href="../revPage/css/revcss.css" rel="stylesheet" type="text/css">

</head>
<body>

<div class="revList">

   <!-- 점수 db에서 값 가져와서 점수현황 표시 -->
    <h2>현재 숙소: <%= request.getAttribute("actname") %>  </h2>
   

    <h2>별점 평균:<%= sdto.getAvgScore()%> 
  
    전체리뷰:<%= sdto.getCountAll()%> 개 
 
    5점:<%= sdto.getCount5()%>개 
    
    4점:<%= sdto.getCount4()%>개 
    
    3점:<%= sdto.getCount3()%>개  
    
    2점:<%= sdto.getCount2()%>개 
    
    1점:<%= sdto.getCount1()%>개    </h2>
    
    <!-- 점수 db에서 값 가져와서 점수현황 표시 끝 -->


<!-- 별점 시각화 -->

<div class="chart-container" align="center">
	<canvas id="myChart" width="700" height="300" ></canvas>
</div>

<!-- // 해당 부분은 JS파일을 따로 만들어서 사용해도 된다. -->
<script>
// 차트를 그럴 영역을 dom요소로 가져온다.
var chartArea = document.getElementById('myChart').getContext('2d');
// 차트를 생성한다. 
var myChart = new Chart(chartArea, {
    // ①차트의 종류(String)
    type: 'bar',
    // ②차트의 데이터(Object)
    data: {
        // ③x축에 들어갈 이름들(Array)
        labels: ['5점', '4점', '3점', '2점', '1점'],
        // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
        datasets: [{
            // ⑤dataset의 이름(String)
            label: '# 점수 카운트',
            // ⑥dataset값(Array)
            data: [<%=sdto.getCount5()%>, <%=sdto.getCount4()%>, 
            	<%=sdto.getCount3()%>, <%=sdto.getCount2()%>, <%=sdto.getCount1()%>],
            // ⑦dataset의 배경색(rgba값을 String으로 표현)
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            // ⑧dataset의 선 색(rgba값을 String으로 표현)
            borderColor: 'rgba(255, 99, 132, 1)',
            // ⑨dataset의 선 두께(Number)
            borderWidth: 1
        }]
    },
    // ⑩차트의 설정(Object)
    options: { maintainAspectRatio: false,
    	 responsive: false,
        // ⑪축에 관한 설정(Object)
        scales: {
            // ⑫y축에 대한 설정(Object)
			yAxes: [{

				display: true,

				ticks: {

					suggestedMax: 10,    // minimum will be 0, unless there is a lower value.

					// OR //

					beginAtZero: true   // minimum value will be 0.

				}

			}]
        }
    }
});
</script>
<!-- 별점 시각화 끝 -->


<!--     검색, 글쓰기버튼폼
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
    </form>
    검색폼 끝 -->
    
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" style="width:90%" class="revListTable">
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="5%">번호</th>
            <th width="10%">제목</th>
            <th width="10%">사진</th>
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

	<!-- 게시물이 있는경우 -->
	<%
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    
    for (ReviewDTO dto : ReviewLists) //게시물 목록 가져오기
    {
    	
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        request.setAttribute("num",dto.getNum());
%>

        <tr align="center">
            <td><%= dto.getNum() 
            %></td>  <!--게시물 번호-->
            <td>  <!--제목(+ 하이퍼링크)-->
                <a href="../revPage/revView.jsp?num=<%= dto.getNum() %>">
                <%= dto.getTitle() %></a> <!-- 리뷰 제목 -->
            </td>
            <td width="100px" height="100px" style = "word-break: break-all">O</td> 
            <td width="400px" style = "word-break: break-all"><%= dto.getContent() %></td><!--리뷰내용-->
            <td ><%= dto.getId() %></td>          <!--작성자 아이디-->
            <td ><%= dto.getScore() %></td>  <!--점수-->
            <td ><%= dto.getPostdate() %></td>    <!--작성일-->
            
        </tr>


<%
    	
    }
}
%>

    </table>
     <!-- 게시물 목록 테이블(표) 끝 -->

</div>

</body>

</html>
