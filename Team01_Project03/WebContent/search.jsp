<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function validateForm() {
        // 검색 필드의 값을 가져옴
        var searchValue = document.getElementById("accsearch").value;

        // 검색 필드가 비어 있는지 확인
        if (searchValue === "") {
            alert("검색어가 없습니다. 검색어를 입력하세요.");
            return false; // 폼 제출을 막음
        }
        return true; // 폼 제출을 진행
    }
</script>
</head>
<body>

<%
	//세션 시작
	HttpSession searchacco = request.getSession();
	
	//검색값 받기
	String searchValue = request.getParameter("accsearch");
	
	//이전 검색값 가져오기
	String previousSearchValue = (String) searchacco.getAttribute("searchValue");
	
	//검색값이 null이거나 처음 접속 시인 경우 빈 값으로 설정
	if (searchValue == null || searchValue.isEmpty()) {
		searchValue = "";
	 	previousSearchValue = "";
	} else {
		previousSearchValue = searchValue;
	}
    
%>

<!-- 검색폼 -->
<form action="accommodation.jsp" method="GET" onsubmit="return validateForm();">
    <tr>
        <td align="center">
            <input type="text" name="accsearch" id="accsearch" value="<%= searchValue %>" />
            <button type="submit">검색하기</button>
            <input type="hidden" id="searchText" name="searchText" value="act_name" />
            
            
        </td>
    </tr>
</form>

<!-- 이전 검색값을 세션에 저장 -->
<%
    searchacco.setAttribute("searchValue", previousSearchValue);
%>

</body>
</html>
