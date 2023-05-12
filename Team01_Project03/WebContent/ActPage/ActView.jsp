<%@ page import="Act.ActDAO"%>
<%@ page import="Act.ActDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 

ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(num);        // 게시물 가져오기 
String actname = dto.getActName();
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(num); //점수 가져오기

request.setAttribute("actname",dto.getActName());
request.setAttribute("actnumber",dto.getActNumber());
session.setAttribute("actname",dto.getActName());
session.setAttribute("actnumber",dto.getActNumber());

out.println(actname);
dao.close();      
sdao.close();// DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 소개</title>
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
        var form = document.ActViewFrm;       // 이름(name)이 "writeFrm"인 폼 선택
        form.method = "post";               // 전송 방식 
        form.action = "DeleteProcess.jsp";  // 전송 경로
        form.submit();                      // 폼값 전송
    }
}
</script>
</head>
<body>
<%-- <jsp:include page="../ActPage/MainLink.jsp" /> --%>
<h2>숙소 소개</h2>
<form name="ActViewFrm" method="post">
    <input type="hidden" name="num" value="<%= num %>" />  <!-- 공통 링크 -->
	<input type="hidden" name="actnum" value="<%= dto.getActNumber() %>" />
	<input type="hidden" name="actname" value="<%= dto.getActName() %>" />
    <table border="1" width="90%">
        <tr>
            <td>번호</td>
            
            <td><%= dto.getActNumber() %></td>
            <td>작성자</td>
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
            
            <td colspan="3"><%= dto.getActName() %></td>
        </tr>
        <tr>
            <td>숙소정보</td>
            <td colspan="3" height="100">
                <%= dto.getActInfo() %></td> 
        </tr>
        <tr>
            <td>숙소별점</td>
            <td><%= sdto.getAvgScore() %></td> 
        </tr>
        <tr>
            <td colspan="4" align="center">
            <%
            if (session.getAttribute("signInId") != null
                && session.getAttribute("signInId").toString().equals(dto.getActId())) {
            %>
                <button type="button"
                        onclick="location.href='Edit.jsp?num=<%= dto.getActNumber() %>';">
                    수정하기</button>
                <button type="button" onclick="deletePost();">삭제하기</button> 
            <%
            }
            %>
                <button type="button" onclick="location.href='ActList.jsp';">
                    목록 보기
                </button>
                <button type="button" onclick="location.href='ReviewWrite.jsp';">
                    리뷰 쓰기
                </button>
            </td>
        </tr>
                
            <h3>액션 태그로 페이지 포함하기</h3>
    		<jsp:include page="./ReviewList.jsp" />
    </table>
</form>
</body>
</html>
