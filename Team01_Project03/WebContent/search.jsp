<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 검색폼 -->
    <form action="accommodation.jsp" method="GET">
    <tr>
        <td align="center">
            <input type="text" name="accsearch" />
            <input type="submit" value="검색하기" />
            <input type="hidden" name="searchField" value="act_name" />
            <a href="./accommodation.jsp">
        </td>
    </tr>
</form>
	

	
</body>
</html>