<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int num = Integer.parseInt(request.getParameter("b_id"));
	BoardDBBean db = BoardDBBean.getInstance();
// 	board 객체에 게시글의 정보가 저장되어 있음
	BoardBean board = db.getBoard(num);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>글 내용 보기</h1>
	</center>
	<center>
		<table cellspacing="0" border="1" width="800">
			<tr height="30" align="center">
				<td width="40">글번호</td>
				<td align="center"><%=num%></td>
			</tr>
			<tr height="30" align="center">
				<td width="100">작성자</td>
				<td width="200" align="center"><%=board.getB_name()%></td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글제목</td>
				<td width="200" align="left"><%=board.getB_title()%></td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글내용</td>
				<td width="200" align="left"><%=board.getB_content()%></td>
			</tr>

		</table>
	</center>
</body>
</html>
