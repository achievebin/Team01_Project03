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
<%@ page import="bookmark.bmDAO"%>
<%@ page import="bookmark.bmDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// DAO를 생성해 DB에 연결
bmDAO dao = new bmDAO(application);
ActDAO adao = new ActDAO(application);
ActDTO adt = new ActDTO();
String accsearch = request.getParameter("accsearch");

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

 List<ActDTO> ActLists = dao.actList(param);  // 게시물 목록 받기
 List<ActDTO> chkLists = adao.bmCheck(param);
dao.close();  // DB 연결 닫기

String hotel = (String)request.getAttribute("actnumber");
request.setAttribute("hotelname", hotel);
List<bmDTO> bmLists = dao.selectList(param);
%>
<!DOCTYPE html>

<html>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>관심 목록</title>
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "RevDeleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
<%@ include file="../Common/header.jsp" %>	
</head>
<body>

    
	<%@ include file = "../Acc/accommodationDate.jsp" %>

    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    
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
    {	
    	ReserveDAO rdao = new ReserveDAO(application); //예약 정보 가져오기
    	int upd = rdao.updateRoom(Integer.parseInt(dto.getActNumber())); // 남은 객실수 업데이트
    	ScoreDAO sdao = new ScoreDAO(application);
    	ScoreDTO sdto = sdao.scoreView(dto.getActNumber());
        // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
        String bmchk = "O";
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
            <%for(ActDTO adto : chkLists){
            	
            	if (adto.getActBookMark().equals(dto.getActNumber())){
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
                        <!--글쓰기 버튼-->
            <td><button type="button" onclick="location.href='ActWrite.jsp';">글쓰기
                </button></td>
        </tr>
    </table>
</body>
</html>
