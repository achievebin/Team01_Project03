<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<body>
	session = request.getSession();
	<!-- 검색폼 -->
    <form action="accommodation.jsp" method="GET">
    <table>
	    <tr>
	        <td align="center">
	            <input type="submit" value="이름순 정렬" />
	            <input type="hidden" name="sortname" value="act_name" />
	        </td>
	    </tr>
    </table>
</form>
	

</body>
</html>