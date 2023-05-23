<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="bookmark.bmDAO"%>
<%@ page import="bookmark.bmDTO"%>
<%@ page import="utils.Page"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("signInId");
// DAO를 생성해 DB에 연결
act.ActDAO dao = new act.ActDAO(application);
bmDAO bdao = new bmDAO(application);
bmDTO bdto = bdao.selectView(id);

//사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String searchText = request.getParameter("searchText");
	String accsearch = request.getParameter("accsearch");
	String sortname = request.getParameter("sortname");
	
	
	if (accsearch != null) {
		param.put("searchText", searchText);
		param.put("accsearch", accsearch);
		param.put("sortname", sortname);
		 
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
param.put("bmid",id);
/*** 페이지 처리 end ***/
List<bmDTO> bmLists = bdao.selectList(param);
List<ActDTO> ActLists = dao.selectListPage(param);  // 게시물 목록 받기
List<ActDTO> chkLists = dao.bmCheck(param);
dao.close();  // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../Common/header.jsp" %>	
<meta charset="UTF-8">
<title>숙소 목록</title>
</head>
<body>

    
	<%@ include file = "../ActPage/accommodationDate.jsp" %>

    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    
  	<!-- 정렬 기능 -->
	<form action="../ActPage/ActList.jsp" method="GET">
	    <input type="hidden" name="accsearch" value="<%=searchValue%>">
	    <input type="hidden" name="searchText" value="act_name">
	    <select name="sortname" onchange="this.form.submit()">
	        <option value="">정렬</option>
	        <option value="asc_name">이름순(오름차순)</option>
	        <option value="desc_name">이름순(내림차순)</option>
	        <option value="asc_leftroom">남은객실수(오름차순)</option>
	        <option value="desc_leftroom">남은객실수(내림차순)</option>
	    </select>
	</form>
    
    <!-- 게시물 목록 테이블(표) -->
    <table border="1" style="width:90%" >
        <!-- 각 칼럼의 이름 -->
        <tr align="center">
            <th width="10%">번호</th>
            <th width="10%">숙소명</th>
            <th width="30%">숙소정보</th>
            <th width="10%">숙소주소</th>
            <th width="10%">전화번호</th>
            <th width="5%">남은객실수</th>
            <th width="5%">평균 점수</th>
            <th width="5%">관심 여부</th>
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
    {	ReserveDAO rdao = new ReserveDAO(application); //예약 정보 가져오기
    	int upd = rdao.updateRoom(Integer.parseInt(dto.getActNumber())); // 남은 객실수 업데이트
    	ScoreDAO sdao = new ScoreDAO(application);
    	ScoreDTO sdto = sdao.scoreView(dto.getActNumber());
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        String bmchk = "X";
%>		
        <tr align="center">
            <td><%= dto.getActNumber()  %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <a href="ActView.jsp?num=<%= dto.getActNumber() %>"><%= dto.getActName() %></a>
            </td>
            <td ><%= dto.getActInfo() %></td>          <!--숙소정보-->
            <td ><%= dto.getActAddress() %></td>          <!--숙소주소-->
            <td ><%= dto.getActPhone() %></td>  <!--숙소번호-->
            <td ><%= dto.getActLeftRoom() %></td>    <!--남은객실수-->
            <td ><%= sdto.getAvgScore() %></td>    <!--평균점수-->
            
            <!--관심목록 표시-->
            <%for(ActDTO adt : chkLists){
            	
            	if (adt.getActBookMark().equals(dto.getActNumber())){
            		bmchk = "O";
            		
            	}%> <% }; %>
			<td><%=bmchk %></td>
           
        </tr>
<%
   rdao.close();
	sdao.close();	
    	}
}
%>
    </table>
    <table border="1" style="width:90%">
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
        </tr>
    </table>
</body>
</html>
