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
<%
//세션 아이디 변수지정
String id = (String)session.getAttribute("signInId");
// DAO를 생성해 DB에 연결
act.ActDAO dao = new act.ActDAO(application);

//북마크 dao 연결
BmDAO bdao = new BmDAO(application);
// 북마크 정보 dto로 가져오기
BmDTO bdto = bdao.selectView(id);

//사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String searchText = request.getParameter("searchText");
	String accsearch = request.getParameter("accsearch");
	String sortname = request.getParameter("sortname");
	String actdiv = request.getParameter("actdiv");
	if (accsearch != null) {
		param.put("searchText", searchText);
		param.put("accsearch", accsearch);
		param.put("sortname", sortname);
		 
}
	if (actdiv != null) {
		param.put("actdiv", actdiv);
		 
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

//체크인 시작 날짜 map에 입력
param.put("start", start);
//체크인 끝 날짜 map에 입력
param.put("end", end);
//북마크 조회용 아이디 map에 입력
param.put("bmid",id);
/*** 페이지 처리 end ***/

//dao로 리스트 받기
List<ActDTO> ActLists = dao.selectListPage(param);  // 게시물 목록 받기
List<ActDTO> chkLists = dao.bmCheck(param); //북마크 목록
dao.close();  // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>

<!-- css 연결 -->
<link href="./css/actcss.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>숙소 목록</title>
</head>

<body>

<!-- 헤더 --> 
<%@ include file="../common/header.jsp" %>	
<div id="actList">
    <!-- 날짜 입력용 달력 -->
	<%@ include file = "../actPage/accommodationDate.jsp" %>

    <h2>숙소 목록</h2>
    
  	<!-- 정렬 기능 -->
  	
	<form action="../actPage/actList.jsp" method="GET">
	    <input type="hidden" name="accsearch" value="<%=searchValue%>">
	    <input type="hidden" name="searchText" value="act_name">
	    <select name="sortname" onchange="this.form.submit()">
	        <option value="">정렬</option>
	        <option value="asc_name">숙소명(↑)</option>
	        <option value="desc_name">숙소명(↓)</option>
	        <option value="asc_leftroom">남은객실수(↑)</option>
	        <option value="desc_leftroom">남은객실수(↓)</option>
	        <option value="asc_price">숙소가격(↑)</option>
	        <option value="desc_price">숙소가격(↓)</option>
	    </select>
	</form>
    <!-- 정렬 기능 끝 -->
    
        <!-- 숙소 구분 폼 -->
    <form action="../actPage/actList.jsp" method="get">
            <select name="actdiv" onchange="this.form.submit()">
            	<option value="">숙소종류</option>
            	<option value="호텔,리조트">호텔,리조트</option>
            	<option value="모텔">모텔</option>
               	<option value="펜션">펜션</option>
                <option value="게스트하우스">게스트하우스</option>
           	</select>
           	<button type="button" onclick="location.href='actList.jsp';">전체보기
            </button>
    </form>
    
    
    <!-- 숙소 구분 폼 끝 -->
 
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" style="width:90%" id="actListTable" >
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="3%">번호</th>
            <th width="10%">숙소명</th>
            <th width="8%">숙소종류</th>
            <th width="20%">숙소주소</th>
            <th width="7%">전화번호</th>
            <th width="10%">숙소가격</th>
            <th width="5%">남은객실수</th>
            <th width="5%">평균 점수</th>
            <th width="5%">관심 여부</th>
        </tr>
        <!-- 목록의 내용 -->
        
        <!-- 목록이 없을경우 -->
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
<!-- 목록이 있을경우 -->
			<%
    // 게시물이 있을 때
    int virtualNum = 0;  // 화면상에서의 게시물 번호
    int countNum = 0;
    for (ActDTO dto : ActLists)	
    {	ReserveDAO rdao = new ReserveDAO(application); //예약 정보 가져오기
    	int upd = rdao.updateRoom(Integer.parseInt(dto.getActNumber())); // 남은 객실수 업데이트
    	
    	ScoreDAO sdao = new ScoreDAO(application); // 숙소별 점수 DB연결
    	ScoreDTO sdto = sdao.scoreView(dto.getActNumber()); // 숙소별 점수 DTO
        
    	// virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        
       
        String bmchk = "X";  //북마크 체크용 변수 지정
%>		
        <tr align="center">
            <td><%= dto.getActNumber()  %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="actView.jsp?num=<%= dto.getActNumber() %>">
                <%= dto.getActName() %></a>
            </td>
            <td ><%= dto.getActDiv() %></td>          <!--숙소종류-->
            <td ><%= dto.getActAddress() %></td>          <!--숙소주소-->
            <td ><%= dto.getActPhone() %></td>  <!--숙소전화번호-->
            <td ><%= dto.getActPrice() %></td>  <!--숙소가격-->
            <td ><%= dto.getActLeftRoom() %></td>    <!--남은객실수-->
            <td ><%= sdto.getAvgScore() %></td>    <!--평균점수-->
            
            <!--관심목록 표시용 반복문-->
            <%for(ActDTO adt : chkLists){
            	
            	if (adt.getActBookMark().equals(dto.getActNumber())){
            		bmchk = "O"; // 관심목록 데이터에 해당 숙소가 있을경우 O로 표시
            		
            	}%> <% }; %>
            <!--관심목록 표시-->	
			<td><%=bmchk %></td>
           
        </tr>
<%
   rdao.close();
	sdao.close();	
    	}
}
%>
    </table>
    <!-- 게시물 목록 테이블 끝 -->
    
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
</div>
    <!-- 페이징 및 글쓰기 버튼 끝 -->


</body>

</html>
