<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="accommodation.AccommodationDTO"%>
<%@ page import="accommodation.AccommodationDAO"%>
<%@ page import="utils.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//DAO를 생성해 DB에 연결
	AccommodationDAO dao = new  AccommodationDAO(application);
	
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
//전체 페이지 수 계산
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수

//현재 페이지 확인
int pageNum = 1;  // 기본값
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정

//목록에 출력할 숙소 목록 범위 계산
int start = (pageNum - 1) * pageSize + 1;  // 첫 번째 숙소 번호
int end = pageNum * pageSize; // 마지막 숙소 번호
param.put("start", start);
param.put("end", end);
/*** 페이지 처리 end ***/

List<AccommodationDTO> accommodationLists = dao.selectListPage(param);  // 게시물 목록 받기
dao.close();  // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙박업소 목록</title>
</head>
<body>
<%@ include file="../Common/header.jsp" %>
<%@ include file = "./accommodationDate.jsp" %>

<h2>숙소 목록 보기 - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
 
<%@ include file = "./sortbutton.jsp" %>
 
 <!-- 게시물 목록 테이블(표) -->
 <table border="1" style="width:90%">
     <!-- 각 칼럼의 이름 -->
     <tr>
         <th width="10%">이미지</th>
         <th width="35%">숙박업소 이름</th>
         <th width="15%">소재지</th>
         <th width="10%">전화번호</th>
         <th width="15%">총 객실 수</th>
         <th width="15%">예약 가능 여부</th>
     </tr>
     <!-- 목록의 내용 -->
<%
if (accommodationLists.isEmpty()) {
	// 숙소 목록이 하나도 없을 때
%>
     <tr>
         <td colspan="6" align="center">
             등록된 숙소가 없습니다
         </td>
     </tr>
<%
}
else {
	// 숙소 목록이 있을 때
	int virtualNum = 0;  // 화면상에의 숙소 번호
	int countNum = 0;
	for (AccommodationDTO dto : accommodationLists)
		{
		// virtualNumber = totalCount--;  // 전체 숙소 수에서 시작해 1씩 감소
		virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
     <tr align="center">
         <td>이미지<%-- <%= virtualNum %> --%></td>  <!--게시물 번호-->
         <td align="left">  <!--제목(+ 하이퍼링크)-->
         	<!-- 성원씨 페이지로 넘겨야함 -->
             <a href="../Actpage/ActView.jsp?num=<%= dto.getAct_number() %>"><%= dto.getAct_name() %></a>
         </td>
         <td align="center"><%= dto.getAct_address() %></td>        <!--소재지-->
         <td align="center"><%= dto.getAct_phone() %></td>          <!--전화번호-->
         <td align="center"><%= dto.getAct_room() %></td>  			<!--총 객실 수-->
         <td align="center"><%= dto.getAct_rcheck() %></td>    		<!--예약가능 여부-->
     </tr>
<%
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

 <%@ include file="../Common/footer.jsp" %> 
</body>
</html>
