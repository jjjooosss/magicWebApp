<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"></script>
</head>
<body>
	<table border="1" width="800">
		<form action="" method="post">
			<caption align="top">
				<h1>게시판에 등록된 글 목록 보기</h1>
				<p align="right">
					<a href="write.jsp">글쓰기</a>
				</p>
			</caption>
		<tr align="center">
			<td width="40">번호</td>
			<td>글제목</td>
			<td>작성자</td>
		</tr>
		<% 
				BoardDBBean board = BoardDBBean.getInstance();
				ArrayList<BoardBean> list = board.listBoard();
				for(BoardBean boardBean: list){
					%>
		<tr>
			<td align="center"><%=boardBean.getB_id()%></td>
			<td><%=boardBean.getB_title()%></td>
			<td align="center" onmouseover="this.style.background='gray'"
				onmouseout="this.style.background='white'"><a href="#"><%=boardBean.getB_name()%>
			</a></td>
		</tr>
		<% } %>
		</form>
	</table>
</body>
</html>
