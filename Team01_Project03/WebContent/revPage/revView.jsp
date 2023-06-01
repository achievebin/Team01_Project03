<%@ page import="review.ReviewDAO"%>
<%@ page import="review.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 

ReviewDAO dao = new ReviewDAO(application);  // DAO 생성 
              
ReviewDTO dto = dao.selectView(num);        // 게시물 가져오기 
String actname = dto.getTitle();			// 숙소명 가져오기
dao.close();                               // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<!-- css 연결 -->
<link href="./css/revcss.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">

<!-- 타이틀 -->
<title>리뷰 상세</title>

<!--리뷰 삭제 함수 -->
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ReViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "revDelete.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
<!--리뷰 삭제 함수 끝 -->


</head>
<body>

<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>	

	<div class="wrapper">
		<!-- revView div 시작 -->
		<div id="revView">
		<h2>리뷰 상세</h2>
		
		<!-- 리뷰출력 폼 시작 -->
		<form name="ReViewFrm" method="post" >
		            <input type="hidden" name="revId" value="<%= dto.getId() %>" />
		            <input type="hidden" name="revNum" value="<%= dto.getNum() %>" />
			
			<!-- revViewTable 시작 -->
		    <table border="1" style="width:90%" id="revViewTable">
		    
		        <tr>
		            <td>번호</td><td><%= dto.getNum() %></td>
		            
		            <td>작성자</td><td><%= dto.getId() %></td>
		        </tr>
		
		        <tr>
		            <td>제목</td><td colspan="3"><%= dto.getTitle() %></td>
		
		        </tr>
		        
		        <tr>            
		        	<td>숙소</td><td colspan="3"><%= dto.getHotel() %></td>
		        </tr>
		        
		        <tr>
		            <td>내용</td>
		            <td colspan="3" height="100"><%= dto.getContent() %></td> 
		        </tr>
		        <tr>
		            <td>점수</td>
		            <td colspan="3" height="100"><%= dto.getScore() %></td> 
		        </tr>
		        <tr>
		            <td colspan="4" align="center">
		            
		            
		            <%//글 작성자인경우 수정, 삭제버튼 출력
		            if (session.getAttribute("signInId") != null
		                && session.getAttribute("signInId").toString().equals(dto.getId())) {
		            %>
		                <button type="button"
		                        onclick="location.href='revEdit.jsp?num=<%= dto.getNum() %>';">
		                    수정하기</button>
		                <button type="button" onclick="deletePost();">삭제하기</button> 
		            <%
		            }
		            %>
		                <button type="button" onclick="javascript:history.back();">
		                    이전화면
		                </button>
		            </td>
		        </tr>
		               
		    </table>
		    <!-- revViewTable 끝 -->
		    
		</form>
		<!-- 리뷰출력 폼 끝 -->
		
		</div>
		<!-- revView div 끝 -->
	</div>

</body>

<!-- 푸터 적용 -->
<jsp:include page="../common/footer.jsp"/>
</html>

