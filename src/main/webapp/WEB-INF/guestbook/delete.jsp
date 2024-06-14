<%@page import="guestbook.GuestBookVO"%>
<%@page import="guestbook.GuestBookDAOOracleImpl"%>
<%@page import="guestbook.GuestBookDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String password = request.getParameter("password");
	ServletContext servletContext = getServletContext();
	String dbuser = servletContext.getInitParameter("dbuser");
	String dbpass = servletContext.getInitParameter("dbpass");
	GuestBookDAO dao = new GuestBookDAOOracleImpl(dbuser, dbpass);
	
	Long no = Long.parseLong(request.getParameter("no"));
	GuestBookVO vo = dao.get(no);
	if (password.equals(vo.getPassword())) {
		dao.delete(vo);
		response.sendRedirect(request.getContextPath() + "/guestbook");
	} else {
		
		%>
		<h1>비밀번호가 일치하지 않습니다.</h1>
		<a href="<%= request.getContextPath() + "/guestbook" %>">메인으로 돌아가기</a>
		<%
	}
%>