<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("signInId") == null) {
    JSFunction.alertLocation("로그인 후 이용해주십시오.",
                             "../Login/signIn.jsp", out);
    return;

}
%>