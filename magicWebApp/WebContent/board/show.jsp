<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");
	

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int num = Integer.parseInt(request.getParameter("b_id"));
	BoardDBBean db = BoardDBBean.getInstance();
// 	board 객체에 게시글의 정보가 저장되어 있음
	BoardBean board = db.getBoard(num, true); //조회수 증가로 true 추가

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="delete.jsp?b_id=<%= num %>">
	<center>
		<h1>글 내용 보기</h1>
	</center>
	<center>
		<table cellspacing="0" border="1" width="800">
			<tr height="30" align="center">
				<td width="40">글번호</td>
				<td align="center"><%=num%></td>
				<td width="40">조회수</td>
				<td align="center"><%=board.getB_hit()%></td>
			</tr>
			<tr height="30" align="center">
				<td width="100">작성자</td>
				<td width="200" align="center"><%=board.getB_name()%></td>
				<td width="100">작성일</td>
				<td width="200" align="center"><%=sdf.format(board.getB_date())%></td>
			</tr>
			<tr height="30" align="center">
				<td width="110">파&nbsp;&nbsp;일</td>
				<td colspan="3">
				&nbsp;
				<%
					if(board.getB_fname() != null){
				%>
<!-- 					<img src="./images/zip.gif"> -->
					<img src="../images/zip.gif">
<%-- 					<a href="./upload/<%= board.getB_fname() %>"> --%>
<%-- 					<a href="./upload/<%= board.getB_fname() %>"> --%>
					<a href="../upload/<%= board.getB_fname() %>">
						원본 파일 : <%= board.getB_fname() %>
					</a>
				<%
					}
				%>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글제목</td>
				<td colspan="3" width="200" align="left"><%= board.getB_title()%></td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글내용</td>
				<td colspan="3" width="200" align="left"><%=board.getB_content()%></td>
			</tr>
			<tr height="30" align="center">
				<td colspan="4" align="right">
				<input type="button" value="글수정" onclick="location.href='edit.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>''">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="location.href='delete.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답변글" onclick="location.href='write.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>

		</table>
	</center>
	</form>
</body>
</html>
