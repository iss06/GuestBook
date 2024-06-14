<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="guestbook.GuestBookVO"%>
<%@page import="java.util.List"%>
<%@page import="guestbook.GuestBookDAOOracleImpl"%>
<%@page import="guestbook.GuestBookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
<link type="text/css" 
	rel="stylesheet" 
	href="<%= request.getContextPath() %>/css/guestbook.css"/>
</head>
<body>
	<a href="<%= request.getContextPath() %>">메인으로 돌아가기</a>
	<hr>
	<form action="add.jsp" method="POST">
	<table border=1 width=500>
		<tr>
			<td>이름</td><td><input type="text" name="name"></td>
			<td>비밀번호</td><td><input type="password" name="pass"></td>
		</tr>
		<tr>
			<td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
		</tr>
		<tr>
			<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
		</tr>
	</table>
	</form>
	<br/>

<%
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String content = request.getParameter("content");
ServletContext servletContext = getServletContext();
String dbuser = servletContext.getInitParameter("dbuser");
String dbpass = servletContext.getInitParameter("dbpass");
GuestBookDAO dao = new GuestBookDAOOracleImpl(dbuser, dbpass);
List<GuestBookVO> lst = dao.getList();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
for (GuestBookVO node: lst) {
%>
	<table width=510 border=1>
		<tr>
			<td><%= node.getNo() %></td>
			<td><%= node.getName() %></td>
			<td>생성일시: <%= sdf.format(node.getDate()) %></td>
			<td><a href="deleteform.jsp?no=<%=node.getNo() %>">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4><%= node.getContent() %></td>
		</tr>
	</table>
        <br/>
<%
}
%>
</body>
</html>