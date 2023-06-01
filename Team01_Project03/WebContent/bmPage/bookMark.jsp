<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="bookmark.BmDAO"%>
<%@ page import="bookmark.BmDTO"%>
<%@ page import="utils.Page"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// DAO를 생성해 DB에 연결
BmDAO dao = new BmDAO(application); //북마크 dao
ActDAO adao = new ActDAO(application); // 숙소 dao
ActDTO adt = new ActDTO(); // 숙소dto 
String accsearch = request.getParameter("accsearch"); //검색어

// 사용자가 입력한 검색 조건을 Map에 저장
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField"); //검색목록
String searchWord = request.getParameter("searchword"); //검색어

String id = (String)session.getAttribute("signInId"); //현재 아이디

param.put("id", id); //map에 아이디 입력

//검색어를 map 에 입력
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
// 페이징 끝 

 List<ActDTO> ActLists = dao.actList(param);  // 게시물 목록 받기
 List<ActDTO> chkLists = adao.bmCheck(param); // 현재 아이디의 북마크 목록 받기
 



String hotel = (String)request.getAttribute("actnumber"); //숙소 번호 받기
request.setAttribute("hotelname", hotel); // 숙소번호 request에 입력
List<BmDTO> bmLists = dao.selectList(param); // 북마크리스트 가져오기


%>
<!DOCTYPE html>

<html>
<!-- 차트 js 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<!-- 타이틀 -->
<title>관심 목록</title>

<!-- css 연결 -->
<link href="./css/bmcss.css" rel="stylesheet" type="text/css">

</head>

<body>
<!-- 헤더 적용 -->
<%@ include file="../common/header.jsp" %>	

<!-- bmList div 시작 -->
<div id="bmList">
    <h2>관심 목록</h2>
    
    <!-- bmListTable 시작 -->
    <table border="1" style="width:90%" id="bmListTable" >
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="3%">번호</th>
            <th width="13%">숙소명</th>
            <th width="8%">숙소종류</th>
            <th width="20%">숙소주소</th>
            <th width="12%">전화번호</th>
            <th width="7%">숙소가격</th>
            <th width="5%">남은객실수</th>
            <th width="5%">평균 점수</th>
            <th width="5%">관심 여부</th>
        </tr>
        <!-- 목록의 내용 -->
        
 <!-- 게시물이 없을 때 -->       
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
else {%>

	 <!-- 게시물이 있을 때 -->   
	<%
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    for (ActDTO dto : ActLists)	
    {	
    	ReserveDAO rdao = new ReserveDAO(application); //예약 정보 가져오기
    	int upd = rdao.updateRoom(Integer.parseInt(dto.getActNumber())); // 남은 객실수 업데이트
    	ScoreDAO sdao = new ScoreDAO(application); //평균점수 dao 연결
    	ScoreDTO sdto = sdao.scoreView(dto.getActNumber()); // 평균점수 dto
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        String bmchk = "O";
%>
        <tr align="center">
            <td><%= dto.getActNumber()  %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="../actPage/actView.jsp?num=<%= dto.getActNumber() %>">
                <%= dto.getActName() %></a>
            </td>
            <td style="text-align: left"><%= dto.getActDiv() %></td>          <!--숙소종류-->
            <td style="text-align: left"><%= dto.getActAddress() %></td>          <!--숙소주소-->
            <td style="text-align: left"><%= dto.getActPhone() %></td>  <!--숙소전화번호-->
            <td style="text-align: right"><%= dto.getActPrice() %></td>  <!--숙소가격-->
            <td ><%= dto.getActLeftRoom() %></td>    <!--남은객실수-->
            <td ><%= sdto.getAvgScore() %></td>    <!--평균점수-->
            
            <!--관심여부 확인-->
            <%for(ActDTO adto : chkLists){
            	
            	if (adto.getActBookMark().equals(dto.getActNumber())){
            		bmchk = "O";
            		
            	}%> <% }; %>
            	<!-- 관심 여부 출력 -->
			<td><%=bmchk %></td>
            
           
        </tr>
<% // DB 연결 닫기  
   rdao.close();
	sdao.close();	

    	}
	adao.close();
	dao.close();
}
%>
    </table>
    <!-- bmListTable 끝 -->
    
    <!-- 페이징 버튼 -->
    <%-- <table border="1" style="width:90%">
        <tr align="center">
            <!--페이징 처리-->
            <td>
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
<!--                         글쓰기 버튼
            <td><button type="button" onclick="location.href='ActWrite.jsp';">글쓰기
                </button></td> -->
        </tr>
    </table> --%>
</div>
<!-- bmList div 끝 -->
</body>

<!-- 푸터 적용 -->
<jsp:include page="../common/footer.jsp"/>
</html>
