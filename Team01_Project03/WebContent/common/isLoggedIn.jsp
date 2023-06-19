<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.JSFunction"%>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<%
if (session.getAttribute("signInId") == null) {
    String message = "로그인 후 이용해주십시오.";
    String redirectUrl = "../login/signIn.jsp";
%>
    <script>
    $().ready(function () {
        Swal.fire({
            icon: 'error',
            title: '로그인 실패!',
            text: '<%= message %>',
        }).then(function () {
            location.href='<%= redirectUrl %>';
        });
    });
    </script>
<%
    return;
}
%>