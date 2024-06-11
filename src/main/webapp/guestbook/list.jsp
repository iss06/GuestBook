<%@page import="himedia.dao.GuestVo"%>
<%@page import="java.util.List"%>
<%@page import="himedia.dao.GuestBookDaoOracleImpl"%>
<%@page import="himedia.dao.GuestBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
ServletContext context = getServletContext();
String dbuser = context.getInitParameter("dbuser");
String dbpass = context.getInitParameter("dbpass");

GuestBookDao dao = new GuestBookDaoOracleImpl(dbuser, dbpass);
List<GuestVo> list = dao.getList();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
	<h1>방명록 리스트</h1>
	<form action="<%=request.getContextPath()%>/guestbook/add.jsp"
		method="POST">
		<table border=1 width=500>


			<tr>
				<td>이름</td>
				<td><input type="text" name="n"></td>

				<td>비밀번호</td>
				<td><input type="password" name="pw"></td>

			</tr>
			<tr>
				<td colspan=4><textarea name="ct" cols=60 rows=5></textarea></td>
			</tr>
			<tr>
				<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
			</tr>
		</table>
	</form>
	<br />
	<%
	for (GuestVo vo : list) {
	%>
	<table width=510 border=1>
		<tr>
            <td>[<%= vo.getNo() %>]</td>
            <td><%= vo.getName() %></td>
            <td><%= vo.getRegDate() %></td>
            <td><a href="<%=request.getContextPath()%>/guestbook/deleteform.jsp?no=<%= vo.getNo() %>">삭제</a></td>
        </tr>
        <tr>
            <td colspan="4"><%= vo.getContent() %></td>
        </tr>
    </table>
    <br />
    <%
    }
    %>
</body>
</html>