<%@page import="himedia.dao.GuestBookDaoOracleImpl"%>
<%@page import="himedia.dao.GuestBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ServletContext context = getServletContext();
String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");

String noParam = request.getParameter("no");
String password = request.getParameter("password");

if (noParam == null || noParam.isEmpty()) {
    
    response.sendRedirect(request.getContextPath() + "/guestbook/list.jsp?error=invalidNo");
    return;
}

Long no = null;
try {
    no = Long.parseLong(noParam);
} catch (NumberFormatException e) {
    
    response.sendRedirect(request.getContextPath() + "/guestbook/list.jsp?error=invalidNoFormat");
    return;
}

GuestBookDao dao = new GuestBookDaoOracleImpl(dbuser, dbpass);
boolean success = dao.delete(no);

if (success) {
	response.sendRedirect(request.getContextPath() + "/guestbook/list.jsp");
} else {
%>
<h1>Error</h1>
<p>삭제하지 못했습니다.</p>
<%
}
%>