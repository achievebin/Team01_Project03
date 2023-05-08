<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="accommodation.jsp" method="GET">

<%
    // 세션 시작
    HttpSession userSession = request.getSession();

    // 검색값 받기
    String searchValue = request.getParameter("accsearch");

    // 검색값 세션에 저장
    userSession.setAttribute("searchValue", searchValue);

    // 이전 검색값 가져오기
    String previousSearchValue = (String) userSession.getAttribute("searchValue");

    // 검색값이 null이면 빈 칸으로 설정
    previousSearchValue = (previousSearchValue != null) ? previousSearchValue : "";

    // 검색값 유지를 위해 이전 검색값 사용
    if (!previousSearchValue.isEmpty()) {
        // 이전 검색값을 사용하여 검색 로직 실행
        // ...
        // 검색 결과를 표시하는 코드
        // ...
    }
%>

<input type="text" name="accsearch" value="<%= previousSearchValue %>" />


</body>
</html>