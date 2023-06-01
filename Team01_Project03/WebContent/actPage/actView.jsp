<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String num = request.getParameter("num");  // 일련번호 받기 

ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(num);        // 게시물 가져오기 



String actname = dto.getActName();  //숙소번호 변수지정

ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(num); //점수 가져오기

dao.scoreUpdate(Integer.parseInt(num)); // 해당페이지에 들어올 시 숙소점수 업데이트

ReserveDAO rdao = new ReserveDAO(application); //예약 dao 생성

ReserveDTO rdto = rdao.scoreView(num); //예약 가져오기

int upd = rdao.updateRoom(Integer.parseInt(num)); // 해당페이지에 들어올 시 남은객실 업데이트


//데이터 입력
request.setAttribute("actname",dto.getActName());
request.setAttribute("actnumber",dto.getActNumber());
request.setAttribute("actprice",dto.getActPrice());
session.setAttribute("actname",dto.getActName());
session.setAttribute("actnumber",dto.getActNumber());


// map에 값 입력
Map<String, Object> param = new HashMap<String, Object>();
String searchText = request.getParameter("searchText");
String accsearch = request.getParameter("accsearch");
String sortname = request.getParameter("sortname");

String id = (String)session.getAttribute("signInId");
param.put("bmid",id);

// map 에 검색어 입력
if (accsearch != null) {
	param.put("searchText", searchText);
	param.put("accsearch", accsearch);
	param.put("sortname", sortname);
	 
}


String bmchk = "X"; //관심목록 변수 설정
List<ActDTO> chkLists = dao.bmCheck(param); //관심목록 리스트


//out.println(actname);
dao.close();  // DB 연결 해제    
sdao.close();// DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<!-- 타이틀 -->
<title>숙소 소개</title>

<!-- 삭제 버튼 클릭시 해당스크립트 작동 -->
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "deleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>

<!-- 관심목록추가 버튼 클릭시 해당스크립트 작동 -->
<script>
function addBookMark() {
    var confirmed = confirm("정말로 추가하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "../bmPage/addBmProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
        
    }
}
</script>

<!-- 관심목록삭제 버튼 클릭시 해당스크립트 작동 -->
<script>
function delBookMark() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "../bmPage/delBmProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
        
    }
}
</script>

<!-- css 연결 -->
<link href="./css/actcss.css" rel="stylesheet" type="text/css">
</head>
<body>


<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>	
<!-- actView div 시작 -->
<div id="actView">
<h2>숙소 소개</h2>

<!-- 숙소소개 폼 시작  -->
<form name="ActViewFrm" method="get">
    <input type="hidden" name="num" value="<%= dto.getActNumber() %>" />  <!-- 공통 링크 -->
	<input type="hidden" name="actnum" value="<%= dto.getActNumber() %>" />
	<input type="hidden" name="actname" value="<%= dto.getActName() %>" />
	<!-- 숙소 소개 테이블 시작  -->
    <table border="1" style="width:90%" id="actViewTable">
    	<!-- 숙소 데이터 출력 -->
        <tr>
            <td style="width:10%">번호</td>
            
            <td><%= dto.getActNumber() %></td>
            <td style="width:10%">판매자</td>
            <td><%= dto.getActId() %></td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td><%= dto.getActPhone() %></td>
            <td>주소</td>
            <td><%= dto.getActAddress() %></td>
        </tr>
        <tr>
            <td>숙소명</td>
            
            <td><%= dto.getActName() %></td>
            
            <td>숙소종류</td>
            <td><%= dto.getActDiv() %></td>
        </tr>
        <tr>
            <td>숙소정보</td>
            <td colspan="3" height="100">
                <%= dto.getActInfo() %></td> 
        </tr>
        <tr>
            <td>숙소별점</td>
            
            <td><%= sdto.getAvgScore() %></td> 
            <td>숙소가격</td>
            
            <td><%= dto.getActPrice() %></td> 
        </tr>
        <tr>
            <td>남은객실</td>
            
            <td><%= dto.getActLeftRoom() %></td> 
            <td>관심 여부</td>
              <!--관심목록 표시용 반복문-->
            <%for(ActDTO adt : chkLists){
            	
            	if (adt.getActBookMark().equals(dto.getActNumber())){
            		bmchk = "O";
            		
            		}%> 
            <% }; %>
            <!--관심목록 표시-->
			<td><%=bmchk %></td>
        </tr>
        <!-- 숙소 데이터 출력 끝 -->
        
        <!-- 버튼 출력 -->
        <tr>
            <td colspan="4" align="center">
            <%
            if (session.getAttribute("signInId") != null
                && session.getAttribute("signInId").toString().equals(dto.getActId())) {
            %>
                <button type="button"
                        onclick="location.href='edit.jsp?num=<%= dto.getActNumber() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
            <%
            }
            %>
            <% if (dto.getActLeftRoom() != 0){ %>
                <button type="button" onclick="location.href='../resPage/reserve.jsp';">
                    예약 하기
                </button>
                <%} %>
                <button type="button" onclick="location.href='actList.jsp';">
                    목록 보기
                </button>
                <button type="button" onclick="location.href='../revPage/reviewWrite.jsp';">
                    리뷰 쓰기
                </button>
                <%if (bmchk.equals("X")){ %>
                <button type="button" onclick="addBookMark();" >
                    관심목록에 추가</button>
                   
               <%}else{%><button type="button" onclick="delBookMark();">
                    관심목록에 삭제</button><%} %>
            </td>
        </tr>
        <!-- 버튼 출력 끝 -->
                
           
    		
    </table>
    <!-- 숙소 소개 테이블 끝  -->
    
    <!-- 아래쪽에 리뷰리스트 출력 -->
    <jsp:include page="../revPage/reviewList.jsp" />
</form>
<!-- 숙소소개 폼 끝 -->
</div>
<!-- actView div 끝 -->

</body>
<!-- 푸터 적용 -->
<jsp:include page="../common/footer.jsp"/>
</html>
