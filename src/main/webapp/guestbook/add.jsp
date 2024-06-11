<%@page import="himedia.dao.GuestBookDaoOracleImpl"%>
<%@page import="himedia.dao.GuestBookDao"%>
<%@page import="himedia.dao.GuestVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
ServletContext context = getServletContext();

String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");


String name = request.getParameter("n"); // 이름
String password = request.getParameter("pw"); // 비밀번호
String content = request.getParameter("ct"); // 컨텐츠

System.out.println("name: " + name);
System.out.println("password: " + password);
System.out.println("content: " + content);

if (name == null || name.isEmpty() || password == null || password.isEmpty() || content == null || content.isEmpty()) {
    out.println("<h1>Error</h1>");
    out.println("<p>모든 필드를 입력해 주세요.</p>");
    return;
}

GuestVo vo = new GuestVo(name, password, content);
GuestBookDao dao = new GuestBookDaoOracleImpl(dbuser, dbpass);

boolean success = dao.insert(vo);

if (success) {
	response.sendRedirect(request.getContextPath() + "/guestbook/list.jsp");
} else {
%>
<h1>Error</h1>
<p>오류가 발생했습니다.</p>
<%	
}
%>