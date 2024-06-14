<%@page import="guestbook.GuestBookVO"%>
<%@page import="guestbook.GuestBookDAOOracleImpl"%>
<%@page import="guestbook.GuestBookDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	if (name.equals(""))
		name = "익명";
	String pass = request.getParameter("pass");
	String content = request.getParameter("content");
	
	
	ServletContext servletContext = getServletContext();
	String dbuser = servletContext.getInitParameter("dbuser");
	String dbpass = servletContext.getInitParameter("dbpass");
	
	GuestBookDAO dao = new GuestBookDAOOracleImpl(dbuser, dbpass);
	GuestBookVO vo = new GuestBookVO(name, pass, content);
	boolean success = dao.insert(vo);
	
	if (success)
		response.sendRedirect(request.getContextPath() + "/guestbook");
	else {
		%>
		<h1>Error</h1>
		<p>데이터 입력 중 오류가 발생했습니다</p>
		<%
	}
	
%>